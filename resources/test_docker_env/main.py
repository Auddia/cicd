from dataclasses import dataclass
from typing import Optional, Any
import os


@dataclass
class Item:
    name: str
    env_val: Optional[Any] = None

    def __str__(self):
        return f"{self.name}: {os.getenv('T_ONE', None)}"


items = [
    Item("T_ONE"),
    Item("T_TWO"),
    Item("T_THREE")
]


for item in items:
    print(item)
