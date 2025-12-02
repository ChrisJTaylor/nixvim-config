#!/usr/bin/env python3
"""
Test file to verify Python LSP IntelliSense is working
"""
import os
import sys
from typing import List, Dict, Optional


def example_function(name: str, age: int = 25) -> Dict[str, any]:
    """
    Example function to test IntelliSense features:
    - Type hints
    - Docstring hover
    - Parameter completion
    - Return type inference
    """
    return {
        "name": name,
        "age": age,
        "is_adult": age >= 18,
        "path": os.getcwd()
    }


class Person:
    """Example class to test class-based IntelliSense"""
    
    def __init__(self, name: str, age: int):
        self.name = name
        self.age = age
    
    def greet(self) -> str:
        return f"Hello, I'm {self.name} and I'm {self.age} years old"
    
    @property
    def is_adult(self) -> bool:
        return self.age >= 18


def main():
    # Test IntelliSense here:
    # 1. Type 'os.' and see if you get completions
    # 2. Type 'person.' and see method/property suggestions
    # 3. Hover over functions to see docstrings
    # 4. Check if type hints show parameter info
    
    person = Person("John", 30)
    result = example_function("Alice")
    
    # These should trigger IntelliSense:
    print(person.greet())
    print(person.is_adult)
    print(result["name"])
    
    # This should show os module completions
    current_dir = os.getcwd()
    print(f"Current directory: {current_dir}")


if __name__ == "__main__":
    main()