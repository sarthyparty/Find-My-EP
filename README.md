# [EPHS Maps](https://apps.apple.com/kg/app/ephs-maps/id1609652746)

# Privacy Policy
We do not collect any data from users. 

# Overview
This is a GPS-like app built for our highschool. The UI was built using SwiftUI and UIKit, and we used python for testing and school layout integration. 

We designed and implemented our own version of the A star algorithm to work with multiple floors. The layout is organized into a graph as follows:
- Intersections of hallways are treated like nodes
- Hallways are treated like edges
- Classrooms, auditoriums, entrances, and libraries are treated differently than intersections. Hallways can contain multiple of these
- Staircases are a completely different struct and these connect to 3 intersections (one for each floor). One complication with staircases arose when we discovered that some staircases have different entrances/exits depending on whether the person is coming from a floor above or below. The way we resolved this was by treating the different entrances are separate staricases.

# Version History

### Version 2.2
- Fixed room issues
- Zoom into path
<img src="https://github.com/sarthyparty/Find-My-EP/blob/main/2.2.png" width="321" height="695" />

### Version 2.1
- Optimized algorithm
- Fully mapped out every room
<img src="https://github.com/sarthyparty/Find-My-EP/blob/main/2.1.png" width="321" height="695" />

### Version 2.0
- Now introducing mulitple floors
- Hall and room tweaks
- Bug fixes
<img src="https://github.com/sarthyparty/Find-My-EP/blob/main/2.0.png" width="321" height="695" />

### Version 1.4
- Set initial zoom to starting point
- Switched from dfs to a star algorithm
- Dropdown cleanup
- Many more rooms added
- Map quality shifts during zoom
- Bug Fixes
<img src="https://github.com/sarthyparty/Find-My-EP/blob/main/Version%201.4.png" width="321" height="695" />

### Version 1.3
- Added dropdown menu 
- Implemented real map
- Plenty more rooms
<img src="https://github.com/sarthyparty/Find-My-EP/blob/main/Version%201.3.png" width="321" height="695" />

### Version 1.2
- Added App Icon
- Improved pathfinder
- Zooming in and out of map
<img src="https://github.com/sarthyparty/Find-My-EP/blob/main/Version%201.2.png" width="321" height="695" />

### Version 1.1
- Added start and end positions
- Demo testing with a small map
- Added a pathfinder that connects two rooms
<img src="https://github.com/sarthyparty/Find-My-EP/blob/main/Version%201.1.png" width="321" height="695" />
