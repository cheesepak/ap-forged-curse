import typing
from dataclasses import dataclass
from Options import DeathLink, Toggle, Range, PerGameCommonOptions

class BlinkRodSkips(Toggle):
    """"Adds unintended blink rod skips and tanking spikes logic"""
    display_name = "Blink Rod Skips"

class DeathLink(Toggle):
    """Adds death link"""
    display_name = "Death Link"

@dataclass
class FCOptions(PerGameCommonOptions):
    blink_rod_skips: BlinkRodSkips
    death_link: DeathLink