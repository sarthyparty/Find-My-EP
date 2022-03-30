//
//  Logic.swift
//  Find My EP
//
//  Created by 64000774 on 2/3/22.
//

import Foundation

func dist(x1: Double, y1: Double, x2: Double, y2: Double) -> Double {
    return sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1))
}

struct Room: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var startDist: Double
    var hall: Int
    var x: Double
    var y: Double
}

struct Intersection {
    var halls: [Hall]
    var id: Int
    var x: Double
    var y: Double
}

struct Hall {
    var start: Int
    var end: Int
    var length: Double
    var id: Int
    var rooms: [Room] = []
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
    
    func findPath(start: Room, end: Room) -> (dist: Double, halls: [Hall], inters: [Int]) {
        // if rooms are
        if start.hall == end.hall {
            return (abs(start.startDist - end.startDist),[],[])
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
        let dist3 = res3.dist + (startHall.length - start.startDist) + end.startDist
        let dist4 = res4.dist + (startHall.length - start.startDist) + (endHall.length - end.startDist)
        
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
    
    func shortestPath(start: Intersection, end: Intersection, visited: [Int]) -> (inters: [Int], hallways: [Hall], dist: Double) {
        var visits = visited
        if (start.id == end.id) {
            if (visits.isEmpty) {
                visits.append(start.id)
            }
            return (visits,[],0);
        }
        
        if (visits.isEmpty) {
            visits.append(start.id)
        }
        var ret_hallways: [Hall] = []
        var ret_inters: [Int] = []
        var minDist = 1000000000000.0
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

var rooms = [
    Room(name: "130 Classroom", startDist: 8.71, hall: 0, x: 106.96, y: 378.5),
    Room(name: "129 Classroom", startDist: 11.38, hall: 0, x: 109.63, y: 378.5),
    Room(name: "131 Computer Lab", startDist: 8.08, hall: 1, x: 119.33, y: 386.58),
    Room(name: "128 Classroom", startDist: 3.13, hall: 6, x: 122.46, y: 387.54),
    Room(name: "127 Classroom", startDist: 3.13, hall: 6, x: 122.46, y: 387.54),
    Room(name: "126 Classroom", startDist: 17.71, hall: 6, x: 137.04, y: 387.54),
    Room(name: "125 Classroom", startDist: 17.71, hall: 6, x: 137.04, y: 387.54),
    Room(name: "124 Classroom", startDist: 27.09, hall: 6, x: 146.42, y: 387.54),
    Room(name: "117 Classroom", startDist: 7.75, hall: 8, x: 159.79, y: 395.29),
    Room(name: "116 Resource", startDist: 15.04, hall: 8, x: 159.79, y: 402.58),
    Room(name: "115 Classroom", startDist: 16.92, hall: 8, x: 159.79, y: 404.46),
    Room(name: "114A Classroom", startDist: 19.04, hall: 8, x: 159.79, y: 406.58),
    Room(name: "114B Classroom", startDist: 21.29, hall: 8, x: 159.79, y: 408.83),
    Room(name: "132 Student Resource", startDist: 10.17, hall: 3, x: 109.16, y: 404.08),
    Room(name: "133 Offices", startDist: 23.58, hall: 3, x: 95.75, y: 404.08),
    Room(name: "134 Classroom", startDist: 1.12, hall: 5, x: 83.46, y: 399.25),
    Room(name: "135 Classroom", startDist: 10.96, hall: 5, x: 73.62, y: 399.25),
    Room(name: "139 Flex", startDist: 34.75, hall: 3, x: 84.58, y: 404.08),
    Room(name: "138 Classroom", startDist: 34.75, hall: 3, x: 84.58, y: 404.08),
    Room(name: "137 Classroom", startDist: 13.37, hall: 5, x: 71.21, y: 399.25),
    Room(name: "136 Lab", startDist: 13.37, hall: 5, x: 71.21, y: 399.25),
    Room(name: "121 Classroom", startDist: 2.4, hall: 12, x: 156.63, y: 354.11),
    Room(name: "120 Classroom", startDist: 4.05, hall: 12, x: 158.47, y: 354.11),
    Room(name: "119 Classroom", startDist: 4.05, hall: 12, x: 158.47, y: 354.11),
    Room(name: "122 Classroom", startDist: 28.82, hall: 11, x: 154.42, y: 356.72),
    Room(name: "123 Classroom", startDist: 12.68, hall: 11, x: 154.42, y: 372.86),
    Room(name: "118 Classroom", startDist: 12.68, hall: 11, x: 154.42, y: 372.86),
    
]

var intersects = [Intersection(halls: [], id: 0, x: 98.25, y: 378.5),
                  Intersection(halls: [], id: 1, x: 119.33, y: 378.5),
                  Intersection(halls: [], id: 2, x: 119.33, y: 387.54),
                  Intersection(halls: [], id: 3, x: 119.33, y: 404.08),
                  Intersection(halls: [], id: 4, x: 84.58, y: 404.08),
                  Intersection(halls: [], id: 5, x: 84.58, y: 399.25),
                  Intersection(halls: [], id: 6, x: 70.54, y: 399.25),
                  Intersection(halls: [], id: 7, x: 154.42, y: 387.54),
                  Intersection(halls: [], id: 8, x: 159.79, y: 387.54),
                  Intersection(halls: [], id: 9, x: 159.79, y: 415.08),
                  Intersection(halls: [], id: 10, x: 119.33, y: 415.08),
                  Intersection(halls: [], id: 11, x: 154.42, y: 354.11),
                  Intersection(halls: [], id: 12, x: 167.01, y: 354.11),
                  
                  
]


var halls = [
    Hall(start: 0, end: 1, length: 21.08, id: 0),
    Hall(start: 1, end: 2, length: 9.04, id: 1),
    Hall(start: 2, end: 3, length: 16.54, id: 2),
    Hall(start: 3, end: 4, length: 34.75, id: 3),
    Hall(start: 4, end: 5, length: 4.83, id: 4),
    Hall(start: 5, end: 6, length: 14.04, id: 5),
    Hall(start: 2, end: 7, length: 35.09, id: 6),
    Hall(start: 7, end: 8, length: 5.37, id: 7),
    Hall(start: 8, end: 9, length: 27.54, id: 8),
    Hall(start: 9, end: 10, length: 40.46, id: 9),
    Hall(start: 10, end: 3, length: 11.0, id: 10),
    Hall(start: 7, end: 11, length: 31.43, id: 11),
    Hall(start: 11, end: 12, length: 12.59, id: 12),
    
]



var roomsToIDs = [String: Int]()






var school = School(halls: halls, inters: intersects, rooms: rooms)

