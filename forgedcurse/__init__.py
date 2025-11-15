from BaseClasses import Region, Location, Item, ItemClassification, Tutorial, CollectionState
from worlds.AutoWorld import World, WebWorld
from worlds.LauncherComponents import (
    Component,
    components,
    Type as component_type,
    )
from typing import Any, Callable
from collections import defaultdict

from .Options import FCOptions
from .Logic import json_world

# def open_page(url):
#    import webbrowser
#    webbrowser.open(f"https://qwint.github.io/air_delivery/?Protocol={url}&auto=True")


# components.append(Component(
#    "FC AutoLaunch",
#    func=open_page,
#    component_type=component_type.HIDDEN,
#    supports_uri=True,
#    game_name=json_world["game_name"]
#    ))


class FCItem(Item):
    game = json_world["game_name"]


class FCLocation(Location):
    game = json_world["game_name"]


class FCWeb(WebWorld):
    """setup_en = Tutorial(
       "setup",
        "A guide for setting up Forged Curse for AP",
        "en",
        "docs/setup_en.md",
        "setup/en",
        ["chairodactyl, cheesepak"]
    )
    tutorials = [setup_en]"""


# flatten lists of locations and items so they are indexed for name_to_id
location_list = [location for locations in json_world["location_map"].values() for location in locations.keys()]
item_list = [item for item_lists in json_world["items"].values() for item in item_lists]

# for my particular get_item_classification
classification_lookup = defaultdict(lambda: ItemClassification.useful, {
    **{n: ItemClassification.progression for n in json_world["items"]["prog_items"]},
    **{n: ItemClassification.filler for n in json_world["items"]["filler_items"]}
})


class FCWorld(World):
    """
    A lone dwarf follows a peculiar white cricket through dark tunnels and stumbles upon the entrance to a long
    forgotten, ancient forge. Find the anvil, bellows, and hammer and use silver to forge silver bolts for the
    magic crossbow to destroy the barrier to the sealed hall and defeat Big Wizard.
    """
    game = json_world["game_name"]
    # web = FCWeb()
    options_dataclass = FCOptions
    location_name_to_id = {name: json_world["base_id"]+location_list.index(name) for name in location_list}
    item_name_to_id = {name: json_world["base_id"]+item_list.index(name) for name in item_list}
    # item_name_groups = {name: set(items) for name, items in json_world["item_name_groups"].items()}

    # ut_can_gen_without_yaml = True

# basic getters for json_world data, any option based modifications can be done here; may cache these later
# expect authors to modify the return of super() per options, or fully override if their format is different
    def get_region_list(self) -> list[str]:
        """
        Parser method to return the list of all regions to be created.
        Currently flattens region_map to create all regions with a connection in or out
        """
        ret = {
            r for connections in json_world["region_map"].values()
            for r in connections.keys()
        }.union(json_world["region_map"].keys())
        return ret

    def get_connections(self) -> list[tuple[str, str, Any | None]]:
        """
        Parser method to convert the region definitions in the json_world object
        into a list of connection entries formatted as (parent_region_name, target_region_name, rule)
        """
        mode = "default"
        if self.options.blink_rod_skips:
            mode = "blink rod skips"
        
        return [
            (region1, region2, rule[mode]if isinstance(rule, dict) and mode in rule else rule)
            for region1, connections in json_world["region_map"].items()
            for region2, rule in connections.items()
        ]
    
        #return [
        #    (region1, region2, rule)
        #    for region1, connections in json_world["region_map"].items()
        #    for region2, rule in connections.items()
        #]

    def get_location_map(self) -> list[tuple[str, str, Any | None]]:
        """
        Parser method to convert the location definitions in the json_world object
        into a list of location entries formatted as (parent_region_name, location_name, rule)
        """
        mode = "default"
        if self.options.blink_rod_skips:
            mode = "blink rod skips"

        return [
            (region, location, rule[mode] if isinstance(rule, dict) and mode in rule else rule)
            for region, placements in json_world["location_map"].items()
            for location, rule in placements.items()
        ]

        #return [
        #    (region, location, rule)
        #    for region, placements in json_world["location_map"].items()
        #    for location, rule in placements.items()
        #]

# black box methods
    def set_victory(self) -> None:
        """
        current black box to set and setup victory condition,
        run after all region/locations have been created (but currently before items)
        """
        # victory = self.get_location("victory")
        victory = self.multiworld.get_location("victory", self.player)
        victory.address = None
        victory.place_locked_item(FCItem("victory", ItemClassification.progression, None, self.player))
        self.multiworld.completion_condition[self.player] = lambda state: state.has("victory", self.player)
        # currently finds victory location, adds locked victory event, and requires victory event for completion

    def create_rule(self, rule: Any) -> Callable[[CollectionState], bool]:
        # current black box to convert json_world rule format to an access_rule lambda
        # returns true if all requirements of any of the lists has been met
        # EX:
        #   "pigcube den": [
        #       ["blue key", "crowbar"],
        #       ["blink rod", "crowbar"]
        #   ]
        return lambda state: any(
            state.has_all(option, self.player) for option in rule
        )

    def get_item_list(self) -> list[str]:
        """
        current black box to create a list of item names per count that need to be created
        """
        return item_list
        # currently my items in my datapackage should all be created once, so this list functions

    def get_item_classification(self, name: str) -> ItemClassification:
        """
        current black box to convert item names to their respective ItemClassification
        """
        return classification_lookup[name]

    def get_filler_item_name(self) -> str:
        # filler_name should be a list and this should choose with self.random
        return json_world["filler_name"]

# common World methods
    def create_regions(self) -> None:
        # create a local map of get_region_list names to region object
        # for referencing in create_regions and adding those regions to the multiworld

        regions = {region: None for region in self.get_region_list()}
        for region in regions.keys():
            regions[region] = Region(region, self.player, self.multiworld)
            self.multiworld.regions.append(regions[region])

        # loop through get_region_map, adding the rules per self.create_rule(rule) if present to the connections
        for region1, region2, rule in self.get_connections():
            if rule:
                regions[region1].connect(regions[region2], rule=self.create_rule(rule))
            else:
                regions[region1].connect(regions[region2])

        # loop through get_location_map, adding the rules per self.create_rule(rule) if present to the location
        for region, location, rule in self.get_location_map():
            loc = FCLocation(self.player, location, self.location_name_to_id[location], regions[region])
            if rule:
                loc.access_rule = self.create_rule(rule)
            regions[region].locations.append(loc)

        self.set_victory()

    def create_items(self) -> None:
        # create all items in get_item_list()
        itempool = [self.create_item(item) for item in self.get_item_list()]

        # fill in any difference in itempool with filler item and submit to multiworld
        total_locations = len(self.multiworld.get_unfilled_locations(self.player))
        missing_items = total_locations - len(itempool)
        if missing_items > 0:
            itempool += [self.create_filler() for _ in range(missing_items)]
        self.multiworld.itempool += itempool

    def create_item(self, name: str) -> "Item":
        item_class = self.get_item_classification(name)
        return FCItem(name, item_class, self.item_name_to_id.get(name, None), self.player)
    
    def fill_slot_data(self):
        return {
            "BlinkRodSkips": self.options.blink_rod_skips.value,
            "DeathLink": self.options.death_link.value,
        }