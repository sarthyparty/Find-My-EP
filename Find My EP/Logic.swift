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
    var floor = 1
}

class Intersection {
    var halls: [Hall]
    var id: Int
    var x: Double
    var y: Double
    var f = 0.0
    var g = 0.0
    var h = 0.0
    var parent: Intersection? = nil
    
    init(halls: [Hall], id: Int, x: Double, y: Double) {
        self.halls = halls
        self.id = id
        self.x = x
        self.y = y
    }
}

struct Hall {
    var start: Int
    var end: Int
    var length: Double
    var id: Int
    var rooms: [Room] = []
}

struct Stair {
    var dist: Double
    var x: Double
    var y: Double
    var isFull: Bool
    var inter: Intersection
}

class Floor {
    var halls: [Hall]
    var inters: [Intersection]
    var rooms: [Room]
    
    init(halls: [Hall], inters: [Intersection], rooms: [Room]) {
        self.halls = halls
        self.inters = inters
        self.rooms = rooms
    }
    
    func findPath(start: Room, end: Room) -> (dist: Double, inters: [Int]) {
        // if rooms are
        if start.hall == end.hall {
            return (abs(start.startDist - end.startDist),[])
        }
        
        let startHall = self.halls[start.hall]
        let endHall = self.halls[end.hall]
        
//        // startHall start to endHall start
//        let res1 = shortestPath(start: inters[startHall.start], end: inters[endHall.start], visited: [])
//
//        // startHall start to endHall end
//        let res2 = shortestPath(start: inters[startHall.start], end: inters[endHall.end], visited: [])
//
//        // startHall end to endHall start
//        let res3 = shortestPath(start: inters[startHall.end], end: inters[endHall.start], visited: [])
//
//        // startHall end to endHall end
//        let res4 = shortestPath(start: inters[startHall.end], end: inters[endHall.end], visited: [])
        
        // startHall start to endHall start
        let res1 = a_star_shortestPath(start: inters[startHall.start], end: inters[endHall.start])

        // startHall start to endHall end
        let res2 = a_star_shortestPath(start: inters[startHall.start], end: inters[endHall.end])

        // startHall end to endHall start
        let res3 = a_star_shortestPath(start: inters[startHall.end], end: inters[endHall.start])

        // startHall end to endHall end
        let res4 = a_star_shortestPath(start: inters[startHall.end], end: inters[endHall.end])
        
        let dist1 = res1.dist + start.startDist + end.startDist
        let dist2 = res2.dist + start.startDist + (endHall.length - end.startDist)
        let dist3 = res3.dist + (startHall.length - start.startDist) + end.startDist
        let dist4 = res4.dist + (startHall.length - start.startDist) + (endHall.length - end.startDist)
        
        if dist1 <= dist2 && dist1 <= dist3 && dist1 <= dist4 {
            print(res1.inters)
            return (dist1, res1.inters)
        } else if dist2 <= dist1 && dist2 <= dist3 && dist2 <= dist4 {
            print(res2.inters)
            return (dist2, res2.inters)
        } else if dist3 <= dist1 && dist3 <= dist2 && dist3 <= dist4 {
            print(res3.inters)
            return (dist3, res3.inters)
        } else {
            print(res4.inters)
            return (dist4, res4.inters)
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
    
    func a_star_shortestPath(start: Intersection, end: Intersection) -> (dist: Double, inters: [Int]) {
        var open = [Intersection]()
        var closed = Array(repeating: false, count: intersects.count)
        open.append(start)
        
        while !open.isEmpty {
            var min = 0
            for i in 0...(open.count-1) {
                if open[i].f < open[min].f {
                    min = i
                }
            }
            var curr = open[min]
            closed[open[min].id] = true
            open.remove(at: min)
            
            if curr.id == end.id {
                var path: [Int] = [Int]()
                
                let dist = curr.g
                
                path.append(curr.id)
                
                while curr.parent != nil {
                    curr = curr.parent!
                    path.append(curr.id)
                }
                
                return (dist, path.reversed())
                
            }
            
            for hall in curr.halls {
                var child = 0
                if hall.start == curr.id {
                    child = hall.end
                } else {
                    child = hall.start
                }
                
                var found = false
                
                if closed[child] {
                    continue
                }
                
                for inter in open {
                    if inter.id == child {
                        found = true
                        break
                    }
                }
                
                if found {
                    continue
                }
                
                var node = Intersection(halls: intersects[child].halls, id: child, x: intersects[child].x, y: intersects[child].y)
                
                node.h = dist(x1: intersects[child].x, y1: intersects[child].y, x2: end.x, y2: end.y)
                node.g = hall.length + curr.g
                node.f = node.h + node.g
                node.parent = curr
                
                open.append(node)
                
                
            }
            
            
            
            
            
            
        }
        return (0.0, [])
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

func findPath(start: Room, end: Room) -> (dist: Double, inters_start: [Int], inters_end: [Int],  floor_start: Int, floor_end: Int, stair: Int) {
    var startfloor = floor3
    var endfloor = floor3
    
    if start.floor == 1 {
        startfloor = floor1
    } else if start.floor == 2{
        let startfloor = floor2
    }
    
    if end.floor == 1 {
        endfloor = floor1
    } else if end.floor == 2{
        let endfloor = floor2
    }
    
    for stair in stairs {
        let res1_start = startfloor.a_star_shortestPath(start: stair.inter, end: startfloor.inters[startfloor.halls[start.hall].start])
        let res2_start = startfloor.a_star_shortestPath(start: stair.inter, end: startfloor.inters[startfloor.halls[start.hall].end])
        
        let res1_end = endfloor.a_star_shortestPath(start: stair.inter, end: endfloor.inters[endfloor.halls[end.hall].start])
        let res2_end = endfloor.a_star_shortestPath(start: stair.inter, end: endfloor.inters[endfloor.halls[end.hall].end])
    }
    
    
    return (0, [], [], 1, 2, 0)
}



// Room(name: "", startDist: , hall: , x: , y: )
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
    Room(name: "144 Weight Room", startDist: 24.95, hall: 13, x: 119.33, y: 436.53),
    Room(name: "143 Boys Locker", startDist: 39.87, hall: 13, x: 119.33, y: 451.95),
    Room(name: "142 Girls Locker", startDist: 27.22, hall: 13, x: 119.33, y: 440.80),
    Room(name: "145 Fitness Center", startDist: 13.76, hall: 13, x: 119.33, y: 426.90),
    Room(name: "146 Training", startDist: 26.09, hall: 9, x: 145.42 , y: 416.53),
    Room(name: "147 Boys Locker", startDist: 10.12, hall: 15, x: 166.51, y: 423.70),
    Room(name: "151 Girls Locker", startDist: 10.12, hall: 15, x: 166.51, y: 423.70),
    Room(name: "148 Boys Locker", startDist: 27.41, hall: 15, x: 166.51, y: 440.99),
    Room(name: "150 Girls Locker", startDist: 27.41, hall: 15, x: 166.51, y: 440.99),
    Room(name: "151A Office", startDist: 7.97, hall: 15, x: 166.51, y: 421.55),
    
]

// Intersection(halls: [], id: , x: , y: )
var intersects = [
    Intersection(halls: [], id: 0, x: 98.25, y: 378.5),
    Intersection(halls: [], id: 1, x: 119.33, y: 378.5),
    Intersection(halls: [], id: 2, x: 119.33, y: 387.54),
    Intersection(halls: [], id: 3, x: 119.33, y: 404.08),
    Intersection(halls: [], id: 4, x: 84.58, y: 404.08),
    Intersection(halls: [], id: 5, x: 84.58, y: 399.25),
    Intersection(halls: [], id: 6, x: 70.54, y: 399.25),
    Intersection(halls: [], id: 7, x: 154.42, y: 387.54),
    Intersection(halls: [], id: 8, x: 159.79, y: 387.54),
    Intersection(halls: [], id: 9, x: 159.79, y: 416.53),
    Intersection(halls: [], id: 10, x: 119.33, y: 416.53),
    Intersection(halls: [], id: 11, x: 154.42, y: 354.11),
    Intersection(halls: [], id: 12, x: 167.01, y: 354.11),
    Intersection(halls: [], id: 13, x: 119.33, y: 452.95),
    Intersection(halls: [], id: 14, x: 166.51, y: 416.53),
    Intersection(halls: [], id: 15, x: 166.51 , y: 458.06),
    
]

// Hall(start: , end: , length: , id: )
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
    Hall(start: 10, end: 13, length: 39.87, id: 13),
    Hall(start: 9, end: 14, length: 6.72, id: 14),
    Hall(start: 14, end: 15, length: 42.98, id: 15),
    
]

//var halls2 = [
//
//]
//
//var intersects2 = [
//
//]
//
//var rooms2 = [
//
//]


var roomsToIDs = [String: Int]()

var rooms2 = [
    Room(name: "220 Classroom", startDist: 0, hall: 0, x: 70.65, y: 399.06),
    Room(name: "219 Science Lab", startDist: 0, hall: 0, x: 70.65, y: 399.06),
    Room(name: "218 Classroom", startDist: 3.06, hall: 0, x: 73.71, y: 399.06),
    Room(name: "221 Classroom", startDist: 3.06, hall: 0, x: 73.71, y: 399.06),
    Room(name: "217 Classroom", startDist: 19.38, hall: 0, x: 90.03, y: 399.06),
    Room(name: "222 Classroom", startDist: 19.38, hall: 0, x: 90.03, y: 399.06),
]

// Intersection(halls: [], id: , x: , y: ),
var inters2 = [
    Intersection(halls: [], id: 0, x: 70.65, y: 399.06),
    Intersection(halls: [], id: 1, x: 99.38, y: 399.06),
    Intersection(halls: [], id: 2, x: 99.38, y: 386.07),
    Intersection(halls: [], id: 3, x: 99.38, y: 404.51),
    Intersection(halls: [], id: 4, x: 106.48, y: 399.06),
    Intersection(halls: [], id: 5, x: 106.48, y: 393.04),
    Intersection(halls: [], id: 6, x: 118.85, y: 393.04),
    Intersection(halls: [], id: 7, x: 118.85, y: 387.72),
    Intersection(halls: [], id: 8, x: 118.85, y: 416.22),
]

// Hall(start: , end: , length: , id: ),
var halls2 = [
    Hall(start: 0, end: 1, length: 28.73, id: 0),
    Hall(start: 1, end: 4, length: 7.10, id: 1),
    Hall(start: 1, end: 2, length: 12.99, id: 2),
    Hall(start: 1, end: 3, length: 5.45, id: 3),
    Hall(start: 4, end: 5, length: 6.02, id: 4),
    Hall(start: 5, end: 6, length: 12.37, id: 5),
    Hall(start: 6, end: 7, length: 5.32, id: 6),
    Hall(start: 6, end: 8, length: 23.18, id: 7),
]




var school = Floor(halls: halls, inters: intersects, rooms: rooms)

var floor1 = Floor(halls: halls, inters: intersects, rooms: rooms)
var floor2 = Floor(halls: halls, inters: intersects, rooms: rooms)
var floor3 = Floor(halls: halls, inters: intersects, rooms: rooms)


var stairs = [
    Stair(dist: 0, x: 0, y: 0, isFull: false, inter: floor3.inters[0])
]
