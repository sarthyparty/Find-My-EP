//
//  Logic.swift
//  Find My EP
//
//  Created by 64000774 on 2/3/22.
//

import Foundation

struct Room {
    var name: String
    var startDist: Int
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
    var rooms: [Room]
    
    init(halls: [Hall], inters: [Intersection], rooms: [Room]) {
        self.halls = halls
        self.inters = inters
        self.rooms = rooms
    }
    
    func findPath(start: Room, end: Room) -> (dist: Int, halls: [Hall], inters: [Int]) {
        // if rooms are
        if start.hall == end.hall {
            return (start.startDist - end.startDist,[],[])
        }
        
        let startHall = halls[start.hall]
        let endHall = halls[end.hall]
        
        // startHall start to endHall start
        let res1 = shortestPath(start: inters[startHall.start], end: inters[endHall.start], visited: [])
        
        // startHall start to endHall end
        let res2 = shortestPath(start: inters[startHall.start], end: inters[endHall.end], visited: [])
        
        // startHall end to endHall start
        let res3 = shortestPath(start: inters[startHall.end], end: inters[endHall.start], visited: [])
        
        // startHall end to endHall end
        let res4 = shortestPath(start: inters[startHall.end], end: inters[endHall.end], visited: [])
        
        let dist1 = res1.dist + start.startDist + end.startDist
        let dist2 = res2.dist + start.startDist + (endHall.length - end.startDist)
        let dist3 = res1.dist + (startHall.length - start.startDist) + end.startDist
        let dist4 = res2.dist + (startHall.length - start.startDist) + (endHall.length - end.startDist)
        
        if dist1 <= dist2 && dist1 <= dist3 && dist1 <= dist4 {
            return (dist1, res1.hallways, res1.inters)
        } else if dist2 <= dist1 && dist2 <= dist3 && dist2 <= dist4 {
            return (dist2, res2.hallways, res2.inters)
        } else if dist3 <= dist1 && dist3 <= dist2 && dist3 <= dist4 {
            return (dist3, res3.hallways, res3.inters)
        } else {
            return (dist4, res4.hallways, res4.inters)
        }
    }
    
    func inList(check: Int, lst: [Int]) -> Bool {
        for val in lst {
            if check == val {
                return true
            }
        }
        return false
    }
    
    func shortestPath(start: Intersection, end: Intersection, visited: [Int]) -> (inters: [Int], hallways: [Hall], dist: Int) {
        if (start.id == end.id) {
            return (visited,[],0);
        }
        var visits = visited
        if (visits.isEmpty) {
            visits.append(start.id)
        }
        var ret_hallways: [Hall] = []
        var ret_inters: [Int] = []
        var minDist = 1000000000000
        for hallway in start.halls {
            if hallway.end != start.id && !inList(check: hallway.end,lst: visited) {
                var temp_visited = visits
                temp_visited.append(hallway.end)
                let result = shortestPath(start: inters[hallway.end], end: end, visited: temp_visited)
                let temp = hallway.length + result.dist
                if (temp < minDist) {
                    minDist = temp
                    ret_hallways = result.hallways
                    ret_hallways.append(hallway)
                    ret_inters = result.inters
                }
            } else if !inList(check: hallway.start, lst: visited) {
                var temp_visited = visits
                temp_visited.append(hallway.start)
                let result = shortestPath(start: inters[hallway.start], end: end, visited: temp_visited)
                let temp = hallway.length + result.dist
                if (temp < minDist) {
                    minDist = temp
                    ret_hallways = result.hallways
                    ret_hallways.append(hallway)
                    ret_inters = result.inters
                }
            }
        }
        return (ret_inters, ret_hallways, minDist)
    }
    
}

var rooms = [Room(name: "10", startDist: 10, hall: 0),
             Room(name: "11", startDist: 10, hall: 1),
             Room(name: "12", startDist: 25, hall: 3),
             Room(name: "14", startDist: 7, hall: 5),
             Room(name: "", startDist: 190, hall: 7),
             Room(name: "Room 6", startDist: 15, hall: 2),
             Room(name: "Room 7", startDist: 25, hall: 0),
             Room(name: "Room 8", startDist: 35, hall: 4),
             Room(name: "Room 9", startDist: 70, hall: 4)]

var halls = [Hall(start: 0, end: 1, length: 50, id: 0, rooms: []),
             Hall(start: 1, end: 7, length: 50, id: 1, rooms: []),
             Hall(start: 0, end: 2, length: 20, id: 2, rooms: []),
             Hall(start: 2, end: 3, length: 37, id: 3, rooms: []),
             Hall(start: 1, end: 3, length: 20, id: 4, rooms: []),
             Hall(start: 3, end: 4, length: 15, id: 5, rooms: []),
             Hall(start: 2, end: 5, length: 30, id: 6, rooms: []),
             Hall(start: 4, end: 5, length: 36, id: 7, rooms: []),
             Hall(start: 5, end: 6, length: 25, id: 8, rooms: []),
             Hall(start: 4, end: 6, length: 25, id: 9, rooms: []),
             Hall(start: 6, end: 7, length: 25, id: 10, rooms: []),
]

var intersects = [Intersection(halls: [], id: 0),
                  Intersection(halls: [], id: 1),
                  Intersection(halls: [], id: 2),
                  Intersection(halls: [], id: 3),
                  Intersection(halls: [], id: 4),
                  Intersection(halls: [], id: 5),
                  Intersection(halls: [], id: 6),
                  Intersection(halls: [], id: 7),

]



var school = School(halls: halls, inters: intersects, rooms: rooms)

