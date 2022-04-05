//
//  Find_My_EPApp.swift
//  Find My EP
//
//  Created by 64000774 on 2/2/22.
//

import SwiftUI

@main
struct Find_My_EPApp: App {
    init() {
        for i in 1...halls.count {
            intersects[halls[i-1].start].halls.append(halls[i-1])
            intersects[halls[i-1].end].halls.append(halls[i-1])
            halls[i-1].length = dist(x1: intersects[halls[i-1].start].x, y1: intersects[halls[i-1].start].y, x2: intersects[halls[i-1].end].x, y2: intersects[halls[i-1].end].y)
            print("Hall \(i-1): \(halls[i-1].length)")
        }
        for i in 1...rooms.count {
            halls[rooms[i-1].hall].rooms.append(rooms[i-1])
            roomsToIDs[rooms[i-1].name] = i-1
            let hallway = halls[rooms[i-1].hall]
            rooms[i-1].startDist = dist(x1: intersects[hallway.start].x, y1: intersects[hallway.start].y, x2: rooms[i-1].x, y2: rooms[i-1].y)
            print("Room \(i-1): \(rooms[i-1].startDist)")
        }
        
        school.a_star_shortestPath(start: intersects[0], end: intersects[3])
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
