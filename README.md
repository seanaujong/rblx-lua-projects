# ROBLOX Lua Projects

ROBLOX Studio and an internet connection are required to run these files.

Download ROBLOX Studio: https://www.roblox.com/create

.rbxl files are ROBLOX "Places" that can be opened using ROBLOX Studio:

## Bezier Curves.rbxl

- combines linear interpolation, vectors, and a bit of algebra to create a curved line based on four points
- this particular bezier curve is cubic
- can drag around the points to manipulate the curve

## Demonstration.rbxl

- demonstrates ArmPoint.rbxm, Chemical Light Blaster.rbxm, CoreGuiToggle.rbxm, MoveCharacterToMouse.lua, PointCharacterToMouse.lua

## Speeder Bike.rbxl

- showcases raycasting
- sends a ray below the bike; if the ray intersects with anything in the next few units, the bike will hover above the intersected part

## Individual Files:

### ArmPoint.rbxm

- showcases an understanding of trigonometry
- if the character is holding a tool, the character's arm will rotate to point at the camera's direction
- best combined with Chemical Light Blaster.rbxm

### CoreGuiToggle.rbxm

- offers the player a way to manipulate what they can see on the screen

### CurrencyScript.lua

- Based on the assumption that 100 bronze = 1 silver, and 100 silver = 1 gold
- returns as much gold, then silver, then bronze as possible

### FizzBuzzScript.lua

- prints different outputs depending on whether the number is a multiple of 3, a multiple of 5, or both a multiple of 3 and 5

### Marketplace.lua

- showcases an understanding of logical flow

### MoveCharacterToMouse.lua

- showcases a pathfinding API
- makes the character move to the position of a mouseclick

### PointCharacterToMouse.lua

- showcases an understanding of trigonometry
- gyrates the character's body towards the mouse and rotates the head as well
