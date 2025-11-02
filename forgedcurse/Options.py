import typing
from dataclasses import dataclass
from Options import DeathLink, Toggle, Range, PerGameCommonOptions

class SkipsLogic(Toggle):
    """"Adds unintended blink rod skips and tanking spikes logic"""
    display_name = "Skips Logic"

class DeathLink(Toggle):
    """Adds death link"""
    display_name = "Death Link"

@dataclass
class FCOptions(PerGameCommonOptions):
    skips_logic: SkipsLogic
    death_link: DeathLink