from dataclasses import dataclass
import os


@dataclass
class Item:
    name: str

    def __str__(self):
        return f"{self.name}: {os.getenv(self.name, None)}"


items = [
    Item("TEST_ONE"),
    Item("TEST_TWO"),
    Item("TEST_THREE")
]


for item in items:
    print(item)
