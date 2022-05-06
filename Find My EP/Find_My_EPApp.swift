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
        for i in 1...halls2.count {
            intersects2[halls2[i-1].start].halls.append(halls2[i-1])
            intersects2[halls2[i-1].end].halls.append(halls2[i-1])
        }
        
        for i in 1...halls3.count {
            intersects3[halls3[i-1].start].halls.append(halls3[i-1])
            intersects3[halls3[i-1].end].halls.append(halls3[i-1])
        }
        for i in 1...rooms.count {
            rooms[i-1].floor = 1
            halls[rooms[i-1].hall].rooms.append(rooms[i-1])
            roomsToIDs[rooms[i-1].name.lowercased()] = rooms[i-1]
        }
        
        for i in 1...rooms2.count {
            rooms2[i-1].floor = 2
            halls2[rooms2[i-1].hall].rooms.append(rooms2[i-1])
            roomsToIDs[rooms2[i-1].name.lowercased()] = rooms2[i-1]
        }
        for i in 1...rooms3.count {
            rooms3[i-1].floor = 3
            halls3[rooms3[i-1].hall].rooms.append(rooms3[i-1])
            roomsToIDs[rooms3[i-1].name.lowercased()] = rooms3[i-1]
        }
        
        print(findPath(start: rooms2[0], end: rooms[8]))
//        print(floor3.a_star_shortestPath(start: floor3.inters[0], end: floor3.inters[6]))
        
//        school.a_star_shortestPath(start: intersects[0], end: intersects[3])
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
