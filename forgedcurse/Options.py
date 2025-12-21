import typing
from dataclasses import dataclass
from Options import DeathLink, Toggle, Range, PerGameCommonOptions

class BarrierSkip(Toggle):
    """"Adds logic to use the Blink Rod or Grappling Hook and the White Key to access the Sealed Halls."""
    display_name = "Barrier Skip"

class DamageBoost(Toggle):
    """Adds logic for tanking the snails at the beginning of the game and spikes to get to areas normally requiring other items (mostly the grappling hook)."""
    display_name = "Damage Boost"

class DeathLink(Toggle):
    """Adds death link"""
    display_name = "Death Link"

@dataclass
class FCOptions(PerGameCommonOptions):
    barrier_skip: BarrierSkip
    damage_boost: DamageBoost
    death_link: DeathLink