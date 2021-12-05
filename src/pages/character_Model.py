from dataclasses import dataclass

@dataclass
class Character:
    character_name: str
    character_class: str   # Maybe use an enum for this.
    strength: int
    agility: int
    generation: int
        

def create_new_character(character_name):
    _new_character = Character(character_name)
    # Randomly create Character info.
    _new_character.character_class = "SALESMAN"
    _new_character.strength = 1000
    _new_character.agility = 10
    _new_character.generation = 1

    return _new_character


