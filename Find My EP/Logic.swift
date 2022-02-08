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
    var hall: Int
}

struct Hall {
    var start: Int
    var end: Int
    var length: Int
    var id: Int
    var rooms: [Room]
}

struct Intersection {
    var halls: [Hall]
    var id: Int
}

class School {
    var inters: [Intersection]
    var halls: [Hall]
    
    init(halls: [Hall], inters: [Intersection]) {
        self.halls = halls
        self.inters = inters
    }
    
    func getToHall(start: Hall, end: Hall, visited: [Hall]) {
        
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
    
    func shortestPath(start: Intersection, end: Intersection, visited: [Int]) -> (hallways: [Hall], dist: Int) {
        if (start.id == end.id) {
            return ([],0);
        }
        var ret_hallways: [Hall] = []
        var minDist = 1000000000000
        for hallway in start.halls {
            if hallway.end != start.id && !inList(check: hallway.end,lst: visited) {
                var temp_visited = visited
                temp_visited.append(hallway.end)
                let result = shortestPath(start: inters[hallway.end], end: end, visited: temp_visited)
                let temp = hallway.length + result.dist
                if (temp < minDist) {
                    minDist = temp
                    ret_hallways = result.hallways
                }
            } else if !inList(check: hallway.start, lst: visited) {
                var temp_visited = visited
                temp_visited.append(hallway.start)
                let result = shortestPath(start: inters[hallway.start], end: end, visited: temp_visited)
                let temp = hallway.length + result.dist
                if (temp < minDist) {
                    minDist = temp
                    ret_hallways = result.hallways
                }
            }
        }
        return (ret_hallways, minDist)
    }
    
}

var halls = [Hall(start: 0, end: 1, length: 50, id: 0, rooms: []),
             Hall(start: 1, end: 2, length: 70, id: 1, rooms: []),
             Hall(start: 0, end: 2, length: 50, id: 2, rooms: []),
             Hall(start: 2, end: 3, length: 30, id: 3, rooms: []),
             Hall(start: 1, end: 3, length: 90, id: 4, rooms: []),
             Hall(start: 0, end: 5, length: 10, id: 5, rooms: []),
             Hall(start: 2, end: 4, length: 40, id: 6, rooms: []),
             Hall(start: 4, end: 5, length: 200, id: 7, rooms: [])]

var intersects = [Intersection(halls: [], id: 0),
                  Intersection(halls: [], id: 1),
                  Intersection(halls: [], id: 2),
                  Intersection(halls: [], id: 3),
                  Intersection(halls: [], id: 4),
                  Intersection(halls: [], id: 5)
]



var school = School(halls: halls, inters: intersects)

