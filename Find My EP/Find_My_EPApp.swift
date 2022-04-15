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
        }
        for i in 1...rooms.count {
            halls[rooms[i-1].hall].rooms.append(rooms[i-1])
            roomsToIDs[rooms[i-1].name] = rooms[i-1]
            rooms[i-1].floor = 1
        }
        
        for i in 1...rooms2.count {
            halls2[rooms2[i-1].hall].rooms.append(rooms2[i-1])
            roomsToIDs[rooms2[i-1].name] = rooms2[i-1]
            rooms2[i-1].floor = 2
        }
        for i in 1...rooms3.count {
            halls3[rooms3[i-1].hall].rooms.append(rooms3[i-1])
            roomsToIDs[rooms3[i-1].name] = rooms3[i-1]
            rooms3[i-1].floor = 2
        }
        
        
        //school.a_star_shortestPath(start: intersects[0], end: intersects[3])
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
