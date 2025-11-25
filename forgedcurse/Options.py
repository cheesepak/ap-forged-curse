import typing
from dataclasses import dataclass
from Options import DeathLink, Toggle, Range, PerGameCommonOptions

class BlinkRodSkips(Toggle):
    """"Adds unintended blink rod skips and tanking spikes logic"""
    display_name = "Blink Rod Skips"

class DamageBoost(Toggle):
    """Adds damage boosting"""
    display_name = "Damage Boost"

class DeathLink(Toggle):
    """Adds death link"""
    display_name = "Death Link"

@dataclass
class FCOptions(PerGameCommonOptions):
    blink_rod_skips: BlinkRodSkips
    damage_boost: DamageBoost
    death_link: DeathLink