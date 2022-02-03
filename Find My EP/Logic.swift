//
//  Logic.swift
//  Find My EP
//
//  Created by 64000774 on 2/3/22.
//

import Foundation

struct Room {
    var name: String
    var dist: Int
    var hall: Hallway
}

struct Hallway {
    var start: Int
    var end: Int
    var length: Int
}

struct Intersection {
    var hallways: [Hallway]
    var id: Int
}

class School {
    var inters: [Intersection]
    var hallways: [Hallway]
    
    init(hallways: [Hallway], inters: [Intersection]) {
        self.hallways = hallways
        self.inters = inters
    }
    
    func getToHall(start: Hallway, end: Hallway, visited: [Hallway]) {
        
    }
    
    func findPath(start: Room, end: Room) {
        
    }

    func inList(check: Int, lst: [Int]) -> Bool {
      for val in lst {
        if check == val {
          return true
        }
      }
      return false
    }
    
    func shortestPath(start: Intersection, end: Intersection, visited: [Int]) -> Int {
        if (start.id == end.id) {
            return 0;
        }
        var minDist = 1000000000000
        for hallway in start.hallways {
            if hallway.end != start.id && !inList(check: hallway.end,lst: visited) {
                var temp_visited = visited
                temp_visited.append(hallway.end)
                let temp = hallway.length + shortestPath(start: inters[hallway.end], end: end, visited: temp_visited)
                if (temp < minDist) {
                    minDist = temp
                }
            } else if !inList(check: hallway.start, lst: visited) {
                var temp_visited = visited
                temp_visited.append(hallway.start)
                let temp = hallway.length + shortestPath(start: inters[hallway.start], end: end, visited: temp_visited)
                if (temp < minDist) {
                    minDist = temp
                }
            }
        }
        return minDist
    }
    
}

var halls = [Hallway(start: 0, end: 1, length: 50),
             Hallway(start: 1, end: 2, length: 70),
             Hallway(start: 0, end: 2, length: 200),
             Hallway(start: 2, end: 3, length: 30),
             Hallway(start: 1, end: 3, length: 100),
             Hallway(start: 0, end: 5, length: 10),
             Hallway(start: 2, end: 4, length: 40),
             Hallway(start: 4, end: 5, length: 200)]

var intersects = [Intersection(hallways: [], id: 0),
                  Intersection(hallways: [], id: 1),
                  Intersection(hallways: [], id: 2),
                  Intersection(hallways: [], id: 3),
                  Intersection(hallways: [], id: 4),
                  Intersection(hallways: [], id: 5)
]



var school = School(hallways: halls, inters: intersects)

