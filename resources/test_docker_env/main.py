from dataclasses import dataclass
from typing import Optional, Any
import os


@dataclass
class Item:
    name: str
    value: Any
    env_val: Optional[Any] = None

    def __str__(self):
        return f"{self.name}: [(val: env) -> ({self.value}: {self.env_val})] "


items = [
    Item("T_ONE", 1, os.getenv("T_ONE", None)),
    Item("T_TWO", 2, os.getenv("T_TWO", None)),
    Item("T_THREE", 3.14, os.getenv("T_THREE", None))
]


for item in items:
    print(item)
