#!/usr/bin/env bash

# Test script to showcase the new space-age theme
# This script creates a temporary file with sample code to demonstrate the theme

cat > /tmp/nixvim_theme_demo.py << 'EOF'
#!/usr/bin/env python3
"""
Space-age theme demonstration
This file showcases the cyberdream theme with custom highlights
"""

import asyncio
import numpy as np
from typing import List, Dict, Optional

# This is a comment - should appear as purple text on bright green background!
# Notice how futuristic this looks with the space-age theme

class SpaceAgeCalculator:
    """A futuristic calculator for space-age computations"""
    
    def __init__(self, quantum_enabled: bool = True):
        self.quantum_enabled = quantum_enabled  # Another comment!
        self.calculations = []  # Purple on green comments everywhere!
        
    async def calculate_hyperdrive_efficiency(self, 
                                            warp_factor: float,
                                            antimatter_ratio: float) -> Optional[float]:
        """
        Calculate hyperdrive efficiency using quantum mechanics
        # Comments should stand out with purple text on green background
        """
        try:
            # Quantum flux calculation - see the space-age colors!
            quantum_flux = np.sqrt(warp_factor ** 2 + antimatter_ratio ** 3)
            
            if quantum_flux > 9000:  # It's over 9000!
                return await self._engage_quantum_boost(quantum_flux)
            else:
                return quantum_flux * 0.86  # Standard efficiency
                
        except Exception as e:
            # Error handling with beautiful syntax highlighting
            print(f"Hyperdrive malfunction: {e}")
            return None
    
    def _engage_quantum_boost(self, flux: float) -> float:
        # This comment demonstrates the custom purple on green styling
        return flux * 1.337  # Leetspeak coefficient

# Test the space-age theme features:
def demonstrate_theme_features():
    """Shows off various syntax highlighting features"""
    
    # Numbers should be bright and vibrant
    coordinates = [42.0, -73.5, 128.0]
    
    # Strings should have that neon glow
    message = "Welcome to the space age! 🚀"
    
    # Keywords should pop with cyberdream colors
    for coord in coordinates:
        if coord > 100:
            print(f"High altitude detected: {coord}")  # Comment styling here too!
        elif coord < 0:
            print(f"Negative coordinate: {coord}")  # More purple on green!
        else:
            print(f"Normal range: {coord}")  # Comments everywhere!

# More demonstrations
async def main():
    calc = SpaceAgeCalculator()  # Initialize our space-age calculator
    
    # Test hyperdrive with various parameters (comment styling demo)
    efficiency = await calc.calculate_hyperdrive_efficiency(8.5, 2.3)
    
    print(f"Hyperdrive efficiency: {efficiency}")  # Final comment!

if __name__ == "__main__":
    # Run the space-age demonstration
    asyncio.run(main())
EOF

echo "🚀 Space-age theme test file created!"
echo "To test your new theme:"
echo "1. Run: nix run . /tmp/nixvim_theme_demo.py"
echo "2. Look for:"
echo "   - Purple comments on bright green backgrounds"
echo "   - Deep space-black background (#0a0a0a)"
echo "   - Neon cyan, magenta, and electric colors"
echo "   - Transparent floating windows"
echo "   - Modern, non-terminal-like interface"
echo ""
echo "3. Try opening the dashboard with ':e' (should show space-age ASCII art)"
echo "4. Open telescope with <leader>ff to see borderless, futuristic picker"
echo ""
echo "Your Neovim should now look like a space-age computer interface! 🌌"