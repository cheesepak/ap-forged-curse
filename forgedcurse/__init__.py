from BaseClasses import Region, Location, Item, ItemClassification, Tutorial, CollectionState
from worlds.AutoWorld import World, WebWorld
from worlds.LauncherComponents import (
    Component,
    components,
    Type as component_type,
    )
from typing import Any, Callable
from collections import defaultdict

json_world = {
    "regions": [
        "Menu",
        "main", # Starting area, caverns, mushroom hall
        "dwarven halls",
        "new moon rotunda",
        "eclipse knight sanctuary",
        "grapple closet",
        "waxing moon rotunda",
        "gibbous cleric grave",
        "forge storage",
        "pigcube den",
        "kobold village",
        "temple",
        "fortress grounds",
        "riverbank",
        "river fortress",
        "full moon rotunda",
        "fortress exit",
        "apogee mage grave",
        "secret storage",
        "sealed halls",
        "grappling hook room",
        "mini maze",
        "sealed depths",
        "waning moon rotunda" # victory
        ],
    "region_map": {
        "Menu": {
            "main": None
        },
        "main": {
            "dwarven halls": [
                ["red key"],
                ["crowbar"],
                ["blink rod"],
            ],
            "waxing moon rotunda": [
                ["crowbar", "orange key"],
                ["crowbar", "blink rod"],
            ],
            "pigcube den": [
                ["blue key", "wooden sword", "leather armor"],
                ["blue key", "wooden sword", "iron armor"],
                ["blue key", "wooden sword", "gold armor"],
                ["blue key", "iron sword", "leather armor"],
                ["blue key", "iron sword", "iron armor"],
                ["blue key", "iron sword", "gold armor"],
                ["blue key", "gold sword", "leather armor"],
                ["blue key", "gold sword", "iron armor"],
                ["blue key", "gold sword", "gold armor"],
                ["blink rod"],
            ],
            "kobold village": [
                ["orange key", "grappling hook", "crowbar"],
                #["blink rod"],
            ],
            "forge storage": [["blink rod"]],
            "sealed halls": [
                ["crossbow", "arrows", "cricket", "white key", "iron sword", "iron armor"],
                ["crossbow", "arrows", "cricket", "white key", "iron sword", "gold armor"],
                ["crossbow", "arrows", "cricket", "white key", "gold sword", "iron armor"],
                ["crossbow", "arrows", "cricket", "white key", "gold sword", "gold armor"],
            ],
        },
        "dwarven halls": {
            "new moon rotunda entrance": [
                ["crowbar"],
                ["bombs"],
            ],
            #"grapple closet": [["boat", "blink rod"],],
            #"pigcube den": [
            #    ["blue key", "crowbar", "wooden sword", "leather armor"],
            #    ["blink rod", "crowbar", "wooden sword", "leather armor"]
            #],
            "kobold village": [
                ["green key", "crowbar"],
                ["blink rod", "crowbar"]
            ],
            #"waxing moon rotunda": [["blink rod"],],
            #"gibbous cleric grave": [["blink rod"],],
        },
        "new moon rotunda entrance": {
            "new moon rotunda": [
                ["red key","wooden sword"],
                ["red key","iron sword"],
                ["red key","gold sword"],
                ["blink rod","wooden sword"],
                ["blink rod","iron sword"],
                ["blink rod","gold sword"],
            ],
        },
        "new moon rotunda": {
            "grapple closet": [
                ["crowbar"],
                ["blink rod"],
            ],
            #"eclipse knight sanctuary": [["blink rod", "boat"],]
        },
        "grapple closet": {
            "eclipse knight sanctuary": [
                ["push rod", "boat"],
                ["blink rod", "boat"],
            ],
            "new moon rotunda": [
                ["crowbar"],
                ["blink rod"],
            ],
            "dwarven halls": [["blink rod", "boat"]]
        },
         "eclipse knight sanctuary": {
            "grapple closet":[
                ["boat"],
            ]
         },
        "waxing moon rotunda": {
            "gibbous cleric grave": [
                ["green key"],
                ["blink rod"],
            ]
        },
        #"gibbous cleric grave": {
            #"dwarven halls": [["blink rod"]],
            #"waxing moon rotunda": [
            #    ["green key"],
            #    ["blink rod"],
            #]
        #},
        #"forge storage": {},
        "pigcube den": {
            "forge storage": [
                ["crowbar"],
                ["blink rod"],
            ],
        },
        "kobold village": {
            "temple": [
                ["push rod", "wooden sword", "leather armor"],
                ["push rod", "wooden sword", "iron armor"],
                ["push rod", "wooden sword", "gold armor"],
                ["push rod", "iron sword", "leather armor"],
                ["push rod", "iron sword", "iron armor"],
                ["push rod", "iron sword", "gold armor"],
                ["push rod", "gold sword", "leather armor"],
                ["push rod", "gold sword", "iron armor"],
                ["push rod", "gold sword", "gold armor"],
                ["grappling hook", "wooden sword", "leather armor"],
                ["grappling hook", "wooden sword", "iron armor"],
                ["grappling hook", "wooden sword", "gold armor"],
                ["grappling hook", "iron sword", "leather armor"],
                ["grappling hook", "iron sword", "iron armor"],
                ["grappling hook", "iron sword", "gold armor"],
                ["grappling hook", "gold sword", "leather armor"],
                ["grappling hook", "gold sword", "iron armor"],
                ["grappling hook", "gold sword", "gold armor"],
                ["boat"],
                #["blink rod"],
            ],
            "fortress grounds": [
                #["grappling hook"],
                ["boat"]
            ],
            "dwarven halls": [
                ["green key", "crowbar"],
                ["green key", "blink rod"],
            ],
            "eclipse knight sanctuary": [
                ["bombs", "blink rod"],
            ]
        },
        "temple": {
            "fortress grounds": [
                ["boat", "wooden sword", "leather armor"],
                ["boat", "wooden sword", "iron armor"],
                ["boat", "wooden sword", "gold armor"],
                ["boat", "iron sword", "leather armor"],
                ["boat", "iron sword", "iron armor"],
                ["boat", "iron sword", "gold armor"],
                ["boat", "gold sword", "leather armor"],
                ["boat", "gold sword", "iron armor"],
                ["boat", "gold sword", "gold armor"],
                ["grappling hook", "wooden sword", "leather armor"],
                ["grappling hook", "wooden sword", "iron armor"],
                ["grappling hook", "wooden sword", "gold armor"],
                ["grappling hook", "iron sword", "leather armor"],
                ["grappling hook", "iron sword", "iron armor"],
                ["grappling hook", "iron sword", "gold armor"],
                ["grappling hook", "gold sword", "leather armor"],
                ["grappling hook", "gold sword", "iron armor"],
                ["grappling hook", "gold sword", "gold armor"],
                ["blink rod", "wooden sword", "leather armor"],
                ["blink rod", "wooden sword", "iron armor"],
                ["blink rod", "wooden sword", "gold armor"],
                ["blink rod", "iron sword", "leather armor"],
                ["blink rod", "iron sword", "iron armor"],
                ["blink rod", "iron sword", "gold armor"],
                ["blink rod", "gold sword", "leather armor"],
                ["blink rod", "gold sword", "iron armor"],
                ["blink rod", "gold sword", "gold armor"],
            ],
            "kobold village": [
                #["push rod"],
                ["boat"],
                #["blink rod"],
            ] # imagine if this happened...
        },
        "fortress grounds": {
            "river fortress": [
                ["crowbar", "grappling hook", "wooden sword", "leather armor"],
                ["crowbar", "grappling hook", "wooden sword", "iron armor"],
                ["crowbar", "grappling hook", "wooden sword", "gold armor"],
                ["crowbar", "grappling hook", "iron sword", "leather armor"],
                ["crowbar", "grappling hook", "iron sword", "iron armor"],
                ["crowbar", "grappling hook", "iron sword", "gold armor"],
                ["crowbar", "grappling hook", "gold sword", "leather armor"],
                ["crowbar", "grappling hook", "gold sword", "iron armor"],
                ["crowbar", "grappling hook", "gold sword", "gold armor"],
                #["blink rod"],
            ],
            "riverbank": [
                ["grappling hook"],
                ["boat"]
            ],
            "temple": [
                ["grappling hook"],
                ["boat"],
                ["blink rod"],
            ]
        },
        "riverbank": {
            "secret storage": [["bombs"]],
            #"river fortress": [["boat"]],#, "grappling hook"]],
            "fortress exit": [
                ["boat"],
                ["blink rod"],
            ]
        },
        "river fortress": {
            #"apogee mage grave": [["boat", "blink rod"]],
            "river fortress exit": [
                ["push rod", "grappling hook"],
                ["push rod", "boat"]
            ]
        },
        "full moon rotunda": {
            "apogee mage grave": [
                ["grappling hook"],
                ["boat"]
            ],
            "riverbank": [
                ["boat", "blink rod"]
            ]
        },
        "fortress exit": {
            "river fortress": [
                ["boat", "wooden sword", "leather armor"],
                ["boat", "wooden sword", "iron armor"],
                ["boat", "wooden sword", "gold armor"],
                ["boat", "iron sword", "leather armor"],
                ["boat", "iron sword", "iron armor"],
                ["boat", "iron sword", "gold armor"],
                ["boat", "gold sword", "leather armor"],
                ["boat", "gold sword", "iron armor"],
                ["boat", "gold sword", "gold armor"],
            ],
            "full moon rotunda": [
                ["blue key", "boat", "iron sword", "iron armor"],
                ["blue key", "boat", "iron sword", "gold armor"],
                ["blue key", "boat", "gold sword", "iron armor"],
                ["blue key", "boat", "gold sword", "gold armor"],
                ["blue key", "grappling hook", "iron sword", "iron armor"],
                ["blue key", "grappling hook", "iron sword", "gold armor"],
                ["blue key", "grappling hook", "gold sword", "iron armor"],
                ["blue key", "grappling hook", "gold sword", "gold armor"],
                ["blue key", "blink rod", "iron sword", "iron armor"],
                ["blue key", "blink rod", "iron sword", "gold armor"],
                ["blue key", "blink rod", "gold sword", "iron armor"],
                ["blue key", "blink rod", "gold sword", "gold armor"],
                #["boat", "blink rod"]
            ],
            "riverbank": [
                ["boat"],
                ["blink rod"]
            ],
        },
        "secret storage": {
            "sealed depths": [
                ["white key", "boat", "iron sword", "iron armor"],
                ["white key", "boat", "iron sword", "gold armor"],
                ["white key", "boat", "gold sword", "iron armor"],
                ["white key", "boat", "gold sword", "gold armor"],
                #["blink rod"]
            ],
            "riverbank": [
                ["bombs"],
                ["boat", "blink rod"]
            ],
        },
        "sealed halls": {
            "grappling hook room": [["grappling hook"]],
            "mini maze": [
                ["blink rod"]
            ]
        },
        "grappling hook room": {
            "mini maze": [
                ["red key", "orange key", "green key", "blue key", "crowbar"],
                ["blink rod"]
            ],
        },
        "mini maze": {
            "grappling hook room":[
                ["red key", "orange key", "green key", "blue key", "crowbar"],
                ["blink rod"]
            ],
            "sealed depths": [
                ["white key"],
                ["blink rod"]
            ],
            "sealed halls": [
                ["blink rod"]
            ]
        },
        "sealed depths": {
            "mini maze": [
                ["white key"],
                ["blink rod"]
            ],
            "waning moon rotunda": [
                ["green key", "white key", "gold sword"],
                ["green key", "blink rod", "gold sword"],
                ["blue key", "blink rod", "gold sword"],
                ["red key", "blink rod", "gold sword"]
            ],
            "secret storage": [
                ["boat","white key"],
                ["boat","blink rod"]
            ],
        },
        #"waning moon rotunda": {},
    },

    "location_map": {
        "main": {
            "riverside chest": [
                ["wooden sword"],
                ["iron sword"],
                ["gold sword"],
            ],
            "kikku chest": None,
            "wooden sword chest": None,
            "leather armor chest": None,
            "red key chest": None,
            "anvil chest": None,
            "forge check": [
                ["crowbar", "anvil", "hammer", "bellows"],
                ["blink rod", "anvil", "hammer", "bellows"],
                ["bombs", "anvil", "hammer", "bellows"],
            ],
            "spider storage chest": [
                ["crowbar"],
                ["bombs"],
                ["blink rod"],
            ],
            "slime island chest": [
                ["boat", "iron sword", "leather armor"],
                ["boat", "iron sword", "iron armor"],
                ["boat", "iron sword", "gold armor"],
                ["boat", "gold sword", "leather armor"],
                ["boat", "gold sword", "iron armor"],
                ["boat", "gold sword", "gold armor"],
            ],
            "secret ingredient mimic": [
                ["boat", "wooden sword"],
                ["boat", "iron sword"],
                ["boat", "gold sword"],
                ["bombs", "blink rod", "wooden sword"],
                ["bombs", "blink rod", "iron sword"],
                ["bombs", "blink rod", "gold sword"],
            ],
            "gold armor chest": [
                ["bombs"],
                #["blink rod"],
            ],
            "mushroom cave": [
                ["bombs"],
                ["blink rod"],
            ],
        },
        "dwarven halls": {
            "orange key chest": [["crowbar"], ["bombs"]],
            "nmr left chest": [
                ["grappling hook"],
                ["boat"],
                #["blink rod"]
            ],
            "nmr right chest": [
                ["grappling hook"],
                ["boat"],
                #["blink rod"]
            ],
            "pigcube hideaway chest": [
                ["push rod"],
                ["blink rod"]
            ],
        },
        "new moon rotunda": {
            "blink chest": [["bombs", "blink rod"]],
        },
        "grapple closet": {
            "grappling hook chest": None,
        },
        "eclipse knight sanctuary": {
            "eclipse knight sanctuary chest": None,
        },
        "waxing moon rotunda": {
            "waxing moon mimic": [
                ["wooden sword"],
                ["iron sword"],
                ["gold sword"],
            ],
            "waxing moon chest": None,
        },
        "gibbous cleric grave": {
            "gibbous cleric grave chest": None,
        },
        "forge storage": {
            "iron armor chest": None,
            "iron sword chest": None,
        },
        "pigcube den": {
            "pigcube hall chest": None,
            "pigcube closet chest": [
                ["bombs"],
                ["blink rod"],
            ]
        },
        "kobold village": {
            "map": None,
            "kobold cave north chest": None,
            "kobold cave south chest": None,
            "shed chest": [
                ["crowbar"],
                ["bombs"]
            ],
            "kobold home chest": [
                ["bombs"],
                ["skeleton key"],
                ["blink rod"]
            ],
            "pig pen chest": [
                ["blue key"],
                ["blink rod"]
            ],
        },
        "temple": {
            "temple north chest": None,
            "temple south chest": None,
            "unknown priest grave chest": [["bombs", "push rod", "blink rod"]],
        },
        #"fortress grounds": {
            # already listed under main
            #"slime island chest": [["boat"]],
        #},
        "riverbank": {
            "lower riverbank chest": None,
        },
        "river fortress": {
            "fortress lionsmane chest": None,
            "fortress gnoglic chest": None,
            "fortress amanita chest": None,
            "fortress browncap chest": None,
            "fortress blocked chest": [
                ["push rod"],
                ["blink rod"]
            ],
            "fortress closet chest": [
                ["crowbar"],
                ["bombs"],
                ["blink rod"]
            ],
        },
        "fortress exit": {
            "fortress exit chest": None,
        },
        #"full moon rotunda": {},
        "apogee mage grave": {
            "apogee mage grave chest": None,
        },
        "secret storage": {
            "secret storage left chest": None,
            "secret storage center chest": None,
            "secret storage right chest": None,
        },
        "sealed halls": {
            "pot maze left chest": None,
            "pot maze right chest": None,
        },
        "grappling hook room": {
            "ghr center chest": None,
            "ghr north chest": None,
        },
        "sealed depths": {
            "mini maze center": None,
            "mini maze right": None,
            "monty hall door chest": [
                ["white key"],
                #["blink rod"],
            ],
        },
        "waning moon rotunda": {
            "victory": [ # crescent artificer grave chest
                ["grappling hook"],
                ["boat"],
                ["blink rod"],
            ],
        },
    },
    "items": {
        "prog_items": [
            "anvil",
            "bellows",
            "hammer",
            "crowbar",
            "grappling hook",
            "boat",
            "push rod",
            "blink rod",
            "bombs",
            "crossbow",
            "arrows",
            "red key",
            "blue key",
            "green key",
            "orange key",
            "white key",
            "skeleton key",
            "cricket",
            "wooden sword",
            "iron sword",
            "gold sword",
            "leather armor",
            "iron armor",
        ],
        "useful_items": [
            "blink heart gem",
            "riverside heart gem",
            "pigcube heart gem",
            "storage heart gem",
            "fortress closet heart gem",
            "map",
            "gold armor",
        ],
        "filler_items": [
            "kobold's loot",
            "nmr left loot",
            "nmr right loot",
            "kobold cave loot",
            "pig pen loot",
            "hideaway loot",
            "lionsmane loot",
            "gnoglic loot",
            "amanita loot",
            "browncap loot",
            "spider's loot",
            "snake's loot",
            "mimic's loot",
            "fort exit loot",
            "hallway loot",
            "ghr top loot",
            "pot maze loot",
            "winner's loot",
            "ghr left loot",
            "riverside loot",
            "minimaze top loot",
            "minimaze right loot",
            "storage left loot",
            "storage right loot",
            # filler loot
            "loot",
        ],
    },
    "base_id": 99117114115101, # "curse" in decimal (99 117 114 115 101)
    "game_name": "Forged Curse",
    "filler_name": "loot",
}

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
    location_name_to_id = {name: json_world["base_id"]+location_list.index(name) for name in location_list}
    item_name_to_id = {name: json_world["base_id"]+item_list.index(name) for name in item_list}
    #item_name_groups = {name: set(items) for name, items in json_world["item_name_groups"].items()}

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
        return [
            (region1, region2, rule)
            for region1, connections in json_world["region_map"].items()
            for region2, rule in connections.items()
        ]

    def get_location_map(self) -> list[tuple[str, str, Any | None]]:
        """
        Parser method to convert the location definitions in the json_world object
        into a list of location entries formatted as (parent_region_name, location_name, rule)
        """
        return [
            (region, location, rule)
            for region, placements in json_world["location_map"].items()
            for location, rule in placements.items()
        ]

# black box methods
    def set_victory(self) -> None:
        """
        current black box to set and setup victory condition,
        run after all region/locations have been created (but currently before items)
        """
        #victory = self.get_location("victory")
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
