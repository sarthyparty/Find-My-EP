//
//  Logic.swift
//  Find My EP
//
//  Created by 64000774 on 2/3/22.
//

import Foundation
import CoreGraphics

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
    var name: String
    var dist: [Double]
    var x: [Double]
    var y: [Double]
    var allFloors: Bool
    var inters: [Intersection]
    var id: Int
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
            return (dist1, res1.inters)
        } else if dist2 <= dist1 && dist2 <= dist3 && dist2 <= dist4 {
            return (dist2, res2.inters)
        } else if dist3 <= dist1 && dist3 <= dist2 && dist3 <= dist4 {
            return (dist3, res3.inters)
        } else {
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
        var closed = Array(repeating: false, count: inters.count)
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
                
                var node = Intersection(halls: inters[child].halls, id: child, x: inters[child].x, y: inters[child].y)
                node.h = dist(x1: inters[child].x, y1: inters[child].y, x2: end.x, y2: end.y)
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


func findPath(start: Room, end: Room) -> (dist: Double, inters_1: [Int], inters_2: [Int], inters_3: [Int], starts: [CGPoint], ends: [CGPoint], floors: [Bool]) {
    
    if start.floor == end.floor {
        let res = floors[start.floor - 1].findPath(start: start, end: end)
        var lst: [[Int]] = [[], [], []]
        var starts: [CGPoint] = [CGPoint(), CGPoint(), CGPoint()]
        var ends: [CGPoint] = [CGPoint(), CGPoint(), CGPoint()]
        var active_floor: [Bool] = [false, false, false]
        lst[start.floor - 1] = res.inters
        starts[start.floor - 1] = CGPoint(x: start.x, y: start.y)
        ends[start.floor - 1] = CGPoint(x: end.x, y: end.y)
        active_floor[start.floor - 1] = true
        return (res.dist, lst[0], lst[1], lst[2], starts, ends, active_floor)
    }
    
    var startfloor = floor3
    var endfloor = floor3

    if start.floor == 1 {
        startfloor = floor1
    } else if start.floor == 2{
        startfloor = floor2
    }

    if end.floor == 1 {
        endfloor = floor1
    } else if end.floor == 2{
        endfloor = floor2
    }
    

    var min_start_floor = startfloor.a_star_shortestPath(start: stairs[0].inters[start.floor-1], end: startfloor.inters[startfloor.halls[start.hall].start])
    min_start_floor.dist += start.startDist
    var min_end_floor = endfloor.a_star_shortestPath(start: stairs[0].inters[end.floor-1], end: endfloor.inters[endfloor.halls[end.hall].start])
    min_end_floor.dist += end.startDist
    var min_stair = 0


    for stair in stairs {
        let res1_start = startfloor.a_star_shortestPath(start: stair.inters[start.floor-1], end: startfloor.inters[startfloor.halls[start.hall].start])
        var start_res = startfloor.a_star_shortestPath(start: stair.inters[start.floor-1], end: startfloor.inters[startfloor.halls[start.hall].end])
        if res1_start.dist + start.startDist < start_res.dist + startfloor.halls[start.hall].length - start.startDist {
            start_res = res1_start
            start_res.dist = res1_start.dist + start.startDist
        } else {
            start_res.dist = start_res.dist + startfloor.halls[start.hall].length - start.startDist
        }
        

        let res1_end = endfloor.a_star_shortestPath(start: stair.inters[end.floor-1], end: endfloor.inters[endfloor.halls[end.hall].start])
        var end_res = endfloor.a_star_shortestPath(start: stair.inters[end.floor-1], end: endfloor.inters[endfloor.halls[end.hall].end])
        
        if res1_end.dist + end.startDist < end_res.dist + endfloor.halls[end.hall].length - end.startDist {
            end_res = res1_end
            end_res.dist = res1_end.dist + end.startDist
        } else {
            end_res.dist = end_res.dist + endfloor.halls[end.hall].length - end.startDist
        }
        

        if end_res.dist + start_res.dist < min_start_floor.dist + min_end_floor.dist {
            min_start_floor = start_res
            min_end_floor = end_res
            min_stair = stair.id
        }
    }
    
    min_start_floor.inters = min_start_floor.inters.reversed()

    var firstfloorpath: [Int] = []
    var secondfloorpath: [Int] = []
    var thirdfloorpath: [Int] = []
    var starts: [CGPoint] = [CGPoint(), CGPoint(), CGPoint()]
    var ends: [CGPoint] = [CGPoint(), CGPoint(), CGPoint()]
    var active_floor: [Bool] = [false, false, false]
    
    if start.floor == 1 {
        starts[0] = CGPoint(x: start.x, y: start.y)
        ends[0] = CGPoint(x: stairs[min_stair].x[0], y: stairs[min_stair].y[0])
        firstfloorpath = min_start_floor.inters
    } else if start.floor == 2 {
        starts[1] = CGPoint(x: start.x, y: start.y)
        ends[1] = CGPoint(x: stairs[min_stair].x[1], y: stairs[min_stair].y[1])
        secondfloorpath = min_start_floor.inters
    } else {
        starts[2] = CGPoint(x: start.x, y: start.y)
        ends[2] = CGPoint(x: stairs[min_stair].x[2], y: stairs[min_stair].y[2])
        thirdfloorpath = min_start_floor.inters
    }

    if end.floor == 1 {
        ends[0] = CGPoint(x: end.x, y: end.y)
        starts[0] = CGPoint(x: stairs[min_stair].x[0], y: stairs[min_stair].y[0])
        firstfloorpath = min_end_floor.inters
    } else if end.floor == 2 {
        ends[1] = CGPoint(x: end.x, y: end.y)
        starts[1] = CGPoint(x: stairs[min_stair].x[1], y: stairs[min_stair].y[1])
        secondfloorpath = min_end_floor.inters
    } else {
        ends[2] = CGPoint(x: end.x, y: end.y)
        starts[2] = CGPoint(x: stairs[min_stair].x[2], y: stairs[min_stair].y[2])
        thirdfloorpath = min_end_floor.inters
    }
    
    active_floor[start.floor - 1] = true
    
    return (min_start_floor.dist + min_end_floor.dist + (18/0.72) * Double(abs(start.floor - end.floor))
, firstfloorpath, secondfloorpath, thirdfloorpath, starts, ends, active_floor)
}



var roomsToIDs = [String: Room]()

//  Room(name: "", startDist: , hall: , x: , y: )
var rooms = [
    Room(name: "130 Classroom", startDist: 10.43, hall: 0, x: 85.39, y: 364.49),
    Room(name: "129 Classroom", startDist: 13.62, hall: 0, x: 88.59, y: 364.49),
    Room(name: "131 Computer Lab", startDist: 9.7, hall: 1, x: 100.2, y: 374.18),
    Room(name: "128 Classroom", startDist: 3.75, hall: 6, x: 103.94, y: 375.33),
    Room(name: "127 Classroom", startDist: 3.75, hall: 6, x: 103.94, y: 375.33),
    Room(name: "126 Classroom", startDist: 21.2, hall: 6, x: 121.4, y: 375.33),
    Room(name: "125 Classroom", startDist: 21.2, hall: 6, x: 121.4, y: 375.33),
    Room(name: "124 Classroom", startDist: 32.43, hall: 6, x: 132.62, y: 375.33),
    Room(name: "117 Classroom", startDist: 9.3, hall: 8, x: 148.63, y: 384.63),
    Room(name: "116 Resource", startDist: 18.05, hall: 8, x: 148.63, y: 393.38),
    Room(name: "115 Classroom", startDist: 20.3, hall: 8, x: 148.63, y: 395.64),
    Room(name: "114A Classroom", startDist: 22.85, hall: 8, x: 148.63, y: 398.18),
    Room(name: "114B Classroom", startDist: 25.55, hall: 8, x: 148.63, y: 400.88),
    Room(name: "132 Student Resource", startDist: 12.17, hall: 3, x: 88.02, y: 395.18),
    Room(name: "133 Offices", startDist: 28.23, hall: 3, x: 71.97, y: 395.18),
    Room(name: "134 Classroom", startDist: 1.34, hall: 5, x: 57.26, y: 389.39),
    Room(name: "135 Classroom", startDist: 13.12, hall: 5, x: 45.48, y: 389.39),
    Room(name: "139 Flex", startDist: 41.6, hall: 3, x: 58.6, y: 395.18),
    Room(name: "138 Classroom", startDist: 41.6, hall: 3, x: 58.6, y: 395.18),
    Room(name: "137 Classroom", startDist: 16.0, hall: 5, x: 42.6, y: 389.39),
    Room(name: "136 Lab", startDist: 16.0, hall: 5, x: 42.6, y: 389.39),
    Room(name: "121 Classroom", startDist: 2.65, hall: 12, x: 144.85, y: 335.22),
    Room(name: "120 Classroom", startDist: 4.85, hall: 12, x: 147.05, y: 335.22),
    Room(name: "119 Classroom", startDist: 4.85, hall: 12, x: 147.05, y: 335.22),
    Room(name: "122 Classroom", startDist: 36.98, hall: 11, x: 142.2, y: 338.35),
    Room(name: "123 Classroom", startDist: 17.62, hall: 11, x: 142.2, y: 357.72),
    Room(name: "118 Classroom", startDist: 17.62, hall: 11, x: 142.2, y: 357.72),
    Room(name: "144 Weight Room", startDist: 24.0, hall: 13, x: 100.2, y: 434.12),
    Room(name: "143 Boys Locker", startDist: 42.5, hall: 13, x: 100.2, y: 452.63),
    Room(name: "142 Girls Locker", startDist: 29.12, hall: 13, x: 100.2, y: 439.25),
    Room(name: "145 Fitness Center", startDist: 12.44, hall: 13, x: 100.2, y: 422.57),
    Room(name: "146 Training", startDist: 17.2, hall: 9, x: 131.43, y: 410.12),
    Room(name: "147 Boys Locker", startDist: 8.6, hall: 15, x: 156.67, y: 418.73),
    Room(name: "151 Girls Locker", startDist: 8.6, hall: 15, x: 156.67, y: 418.73),
    Room(name: "148 Boys Locker", startDist: 29.35, hall: 15, x: 156.67, y: 439.47),
    Room(name: "150 Girls Locker", startDist: 29.35, hall: 15, x: 156.67, y: 439.47),
    Room(name: "151A Office", startDist: 6.02, hall: 15, x: 156.67, y: 416.15),
]

//  Intersection(halls: [], id: , x: , y: )
var intersects = [
    Intersection(halls: [], id: 0, x: 74.97, y: 364.49),
    Intersection(halls: [], id: 1, x: 100.2, y: 364.49),
    Intersection(halls: [], id: 2, x: 100.2, y: 375.33),
    Intersection(halls: [], id: 3, x: 100.2, y: 395.18),
    Intersection(halls: [], id: 4, x: 58.6, y: 395.18),
    Intersection(halls: [], id: 5, x: 58.6, y: 389.39),
    Intersection(halls: [], id: 6, x: 41.8, y: 389.39),
    Intersection(halls: [], id: 7, x: 142.2, y: 375.33),
    Intersection(halls: [], id: 8, x: 148.63, y: 375.33),
    Intersection(halls: [], id: 9, x: 148.63, y: 410.12),
    Intersection(halls: [], id: 10, x: 100.2, y: 410.12),
    Intersection(halls: [], id: 11, x: 142.2, y: 335.22),
    Intersection(halls: [], id: 12, x: 157.27, y: 335.22),
    Intersection(halls: [], id: 13, x: 100.2, y: 453.83),
    Intersection(halls: [], id: 14, x: 156.67, y: 410.12),
    Intersection(halls: [], id: 15, x: 156.67, y: 459.96),
    
    Intersection(halls: [], id: 16, x: 154.05, y: 375.33),
    Intersection(halls: [], id: 17, x: 160.69, y: 375.33),
    Intersection(halls: [], id: 18, x: 160.69, y: 372.12),
    Intersection(halls: [], id: 19, x: 174.11, y: 372.12),
    Intersection(halls: [], id: 20, x: 174.11, y: 366.76),
    Intersection(halls: [], id: 21, x: 183.24, y: 366.76),
    Intersection(halls: [], id: 22, x: 183.24, y: 362.39),
    Intersection(halls: [], id: 23, x: 196.14, y: 362.39),
    Intersection(halls: [], id: 24, x: 196.14, y: 355.98),
    Intersection(halls: [], id: 25, x: 208.19, y: 362.39),
    Intersection(halls: [], id: 26, x: 208.19, y: 355.73),
    Intersection(halls: [], id: 27, x: 214.86, y: 355.73),
    Intersection(halls: [], id: 28, x: 214.86, y: 342.46),
    Intersection(halls: [], id: 29, x: 221.53, y: 342.46),
    Intersection(halls: [], id: 30, x: 214.86, y: 311.50),
    Intersection(halls: [], id: 31, x: 214.86, y: 305.36),
    Intersection(halls: [], id: 32, x: 207.82, y: 311.50),
    Intersection(halls: [], id: 33, x: 207.82, y: 327.32),
    Intersection(halls: [], id: 34, x: 207.82, y: 307.32),
    Intersection(halls: [], id: 35, x: 245.89, y: 355.73),
    Intersection(halls: [], id: 36, x: 245.89, y: 361.03),
    Intersection(halls: [], id: 37, x: 245.89, y: 369.07),
    Intersection(halls: [], id: 38, x: 311.25, y: 369.07),
    Intersection(halls: [], id: 39, x: 311.25, y: 366.07),
    Intersection(halls: [], id: 40, x: 353.55, y: 366.07),
    Intersection(halls: [], id: 41, x: 250.81, y: 369.07),
    Intersection(halls: [], id: 42, x: 250.81, y: 392.55),
    Intersection(halls: [], id: 43, x: 215.61, y: 392.55),
    Intersection(halls: [], id: 44, x: 215.61, y: 297.85),
    Intersection(halls: [], id: 45, x: 208.75, y: 297.85),
    Intersection(halls: [], id: 46, x: 215.61, y: 408.85),
    Intersection(halls: [], id: 47, x: 209.03, y: 408.85),
    Intersection(halls: [], id: 48, x: 262.34, y: 369.07),
    Intersection(halls: [], id: 49, x: 262.34, y: 361.18),
    Intersection(halls: [], id: 50, x: 129.25, y: 335.22),
    Intersection(halls: [], id: 51, x: 160.69, y: 383.30),
    
    
    

    
    
]

//  Hall(start: , end: , length: , id: )
var halls = [
    Hall(start: 0, end: 1, length: 25.23, id: 0),
    Hall(start: 1, end: 2, length: 10.85, id: 1),
    Hall(start: 2, end: 3, length: 19.85, id: 2),
    Hall(start: 3, end: 4, length: 41.6, id: 3),
    Hall(start: 4, end: 5, length: 5.8, id: 4),
    Hall(start: 5, end: 6, length: 16.81, id: 5),
    Hall(start: 2, end: 7, length: 42.0, id: 6),
    Hall(start: 7, end: 8, length: 6.43, id: 7),
    Hall(start: 8, end: 9, length: 34.79, id: 8),
    Hall(start: 9, end: 10, length: 48.43, id: 9),
    Hall(start: 10, end: 3, length: 14.94, id: 10),
    Hall(start: 7, end: 11, length: 40.12, id: 11),
    Hall(start: 11, end: 12, length: 15.07, id: 12),
    Hall(start: 10, end: 13, length: 43.7, id: 13),
    Hall(start: 9, end: 14, length: 8.04, id: 14),
    Hall(start: 14, end: 15, length: 49.84, id: 15),
    Hall(start: 11, end: 50, length: 12.95, id: 16),
    Hall(start: 17, end: 51, length: 7.97, id: 17),
    Hall(start: 18, end: 19, length: 13.42, id: 18),
    Hall(start: 19, end: 20, length: 5.36, id: 19),
    Hall(start: 20, end: 21, length: 9.13, id: 20),
    Hall(start: 22, end: 23, length: 12.9, id: 21),
    Hall(start: 23, end: 24, length: 6.41, id: 22),
    Hall(start: 23, end: 25, length: 12.05, id: 23),
    Hall(start: 25, end: 26, length: 6.66, id: 24),
    Hall(start: 26, end: 27, length: 6.67, id: 25),
    Hall(start: 27, end: 28, length: 13.27, id: 26),
    Hall(start: 28, end: 29, length: 6.67, id: 27),
    Hall(start: 28, end: 30, length: 30.96, id: 28),
    Hall(start: 30, end: 31, length: 6.14, id: 29),
    Hall(start: 30, end: 32, length: 7.04, id: 30),
    Hall(start: 32, end: 34, length: 4.18, id: 31),
    Hall(start: 32, end: 33, length: 15.82, id: 32),
    Hall(start: 27, end: 35, length: 31.03, id: 33),
    Hall(start: 35, end: 36, length: 5.3, id: 34),
    Hall(start: 36, end: 49, length: 16.45, id: 35),
    Hall(start: 48, end: 49, length: 7.89, id: 36),
    Hall(start: 37, end: 41, length: 4.92, id: 37),
    Hall(start: 8, end: 16, length: 5.42, id: 38),
    Hall(start: 16, end: 17, length: 6.64, id: 39),
    Hall(start: 17, end: 18, length: 3.21, id: 40),
    Hall(start: 36, end: 37, length: 8.04, id: 41),
    Hall(start: 38, end: 48, length: 48.91, id: 42),
    Hall(start: 38, end: 39, length: 3.0, id: 43),
    Hall(start: 39, end: 40, length: 42.3, id: 44),
    Hall(start: 41, end: 42, length: 23.48, id: 45),
    Hall(start: 42, end: 43, length: 35.2, id: 46),
    Hall(start: 43, end: 44, length: 94.7, id: 47),
    Hall(start: 44, end: 46, length: 111.0, id: 48),
    Hall(start: 46, end: 47, length: 6.58, id: 49),
    Hall(start: 45, end: 47, length: 111.0, id: 50),
    Hall(start: 44, end: 45, length: 6.86, id: 51),
    Hall(start: 25, end: 45, length: 64.54, id: 52),
    Hall(start: 14, end: 47, length: 52.38, id: 53),
    Hall(start: 21, end: 22, length: 4.37, id: 54),
    Hall(start: 41, end: 48, length: 11.53, id: 55),
    
    
]

//  Room(name: "", startDist: , hall: , x: , y: ),
var rooms2 = [
    Room(name: "220", startDist: 57.99, hall: 0, x: 41.93, y: 387.66),
    Room(name: "219", startDist: 57.99, hall: 0, x: 41.93, y: 387.66),
    Room(name: "218", startDist: 54.33, hall: 0, x: 45.59, y: 387.66),
    Room(name: "221", startDist: 54.33, hall: 0, x: 45.59, y: 387.66),
    Room(name: "217", startDist: 34.8, hall: 0, x: 65.13, y: 387.66),
    Room(name: "222", startDist: 34.8, hall: 0, x: 65.13, y: 387.66),
    Room(name: "214", startDist: 2.39, hall: 101, x: 102.31, y: 374.24),
    Room(name: "212", startDist: 20.55, hall: 101, x: 120.47, y: 374.24),
    Room(name: "215", startDist: 2.39, hall: 101, x: 102.31, y: 374.24),
    Room(name: "213", startDist: 20.55, hall: 101, x: 120.47, y: 374.24),
    Room(name: "211", startDist: 33.04, hall: 101, x: 132.96, y: 374.24),
    Room(name: "209", startDist: 3.48, hall: 102, x: 141.87, y: 336.45),
    Room(name: "210", startDist: 24.51, hall: 102, x: 141.87, y: 357.48),
    Room(name: "208", startDist: 20.74, hall: 102, x: 141.87, y: 353.71),
    Room(name: "206", startDist: 11.75, hall: 99, x: 143.99, y: 332.97),
    Room(name: "205", startDist: 9.23, hall: 99, x: 146.51, y: 332.97),
    Room(name: "203", startDist: 4.37, hall: 93, x: 190.59, y: 332.04),
    Room(name: "204", startDist: 0, hall: 104, x: 194.96, y: 333.50),
    Room(name: "201", startDist: 21.48, hall: 94, x: 207.35, y: 312.02),
    Room(name: "207", startDist: 9.17, hall: 99, x: 146.57, y: 332.97),
    Room(name: "200", startDist: 23.78, hall: 94, x: 207.35, y: 309.72),
    Room(name: "202 English Resource Center", startDist: 6.24, hall: 89, x: 223.49, y: 343.74),
    Room(name: "270", startDist: 7.18, hall: 88, x: 229.73, y: 336.56),
    Room(name: "269", startDist: 4.02, hall: 85, x: 231.59, y: 347.45),
    Room(name: "268 Business & Marketing", startDist: 11.81, hall: 79, x: 249.38, y: 377.39),
    Room(name: "267", startDist: 18.88, hall: 78, x: 265.11, y: 377.39),
    Room(name: "266", startDist: 7.29, hall: 78, x: 276.70, y: 377.39),
    Room(name: "265", startDist: 21.27, hall: 73, x: 288.47, y: 377.39),
    Room(name: "264", startDist: 9.34, hall: 73, x: 300.40, y: 377.39),
    Room(name: "259", startDist: 11.83, hall: 73, x: 297.91, y: 377.39),
    Room(name: "258", startDist: 23.29, hall: 73, x: 286.45, y: 377.39),
    Room(name: "257", startDist: 2.09, hall: 74, x: 283.99, y: 379.47),
    Room(name: "263", startDist: 5.02, hall: 72, x: 321.37, y: 365.87),
    Room(name: "262", startDist: 6.24, hall: 72, x: 332.59, y: 365.87),
    Room(name: "227 Student Center East", startDist: 0, hall: 16, x: 95.78, y: 435.67),
    Room(name: "227I Career Resource Center", startDist: 25.86, hall: 16, x: 95.78, y: 461.53),
]

//  Intersection(halls: [], id: , x: , y: ),
var intersects2 = [
    Intersection(halls: [], id: 0, x: 41.93, y: 387.66),
    Intersection(halls: [], id: 1, x: 76.32, y: 387.66),
    Intersection(halls: [], id: 2, x: 76.32, y: 372.07),
    Intersection(halls: [], id: 3, x: 76.32, y: 394.2),
    Intersection(halls: [], id: 4, x: 99.92, y: 387.66),
    Intersection(halls: [], id: 5, x: 99.92, y: 355.17),
    Intersection(halls: [], id: 6, x: 103.43, y: 355.17),
    Intersection(halls: [], id: 7, x: 99.92, y: 374.24),
    Intersection(halls: [], id: 8, x: 93.51, y: 394.2),
    Intersection(halls: [], id: 9, x: 99.92, y: 394.2),
    Intersection(halls: [], id: 10, x: 99.92, y: 409.61),
    Intersection(halls: [], id: 11, x: 99.92, y: 431.63),
    Intersection(halls: [], id: 12, x: 95.78, y: 435.67),
    Intersection(halls: [], id: 13, x: 95.78, y: 471.51),
    Intersection(halls: [], id: 14, x: 113.94, y: 471.51),
    Intersection(halls: [], id: 15, x: 133.1, y: 471.51),
    Intersection(halls: [], id: 16, x: 156.45, y: 471.51),
    Intersection(halls: [], id: 17, x: 133.1, y: 462.5),
    Intersection(halls: [], id: 18, x: 156.45, y: 462.5),
    Intersection(halls: [], id: 19, x: 156.45, y: 458.51),
    Intersection(halls: [], id: 20, x: 209.44, y: 464.3),
    Intersection(halls: [], id: 21, x: 209.44, y: 409.61),
    Intersection(halls: [], id: 22, x: 209.44, y: 423.14),
    Intersection(halls: [], id: 23, x: 214.28, y: 423.14),
    Intersection(halls: [], id: 24, x: 218.39, y: 423.14),
    Intersection(halls: [], id: 25, x: 218.39, y: 409.61),
    Intersection(halls: [], id: 26, x: 243.41, y: 409.61),
    Intersection(halls: [], id: 27, x: 209.44, y: 403.65),
    Intersection(halls: [], id: 28, x: 203.69, y: 409.61),
    Intersection(halls: [], id: 29, x: 156.37, y: 409.61),
    Intersection(halls: [], id: 30, x: 156.37, y: 412.7),
    Intersection(halls: [], id: 31, x: 300.01, y: 403.65),
    Intersection(halls: [], id: 32, x: 203.69, y: 400.89),
    Intersection(halls: [], id: 33, x: 269.25, y: 403.65),
    Intersection(halls: [], id: 34, x: 269.25, y: 442.17),
    Intersection(halls: [], id: 35, x: 255.57, y: 441.26),
    Intersection(halls: [], id: 36, x: 269.25, y: 449.61),
    Intersection(halls: [], id: 37, x: 300.01, y: 442.17),
    Intersection(halls: [], id: 38, x: 331.04, y: 442.17),
    Intersection(halls: [], id: 39, x: 315.56, y: 401.75),
    Intersection(halls: [], id: 40, x: 331.04, y: 401.75),
    Intersection(halls: [], id: 41, x: 400.59, y: 401.75),
    Intersection(halls: [], id: 42, x: 315.56, y: 382.92),
    Intersection(halls: [], id: 43, x: 312.32, y: 382.92),
    Intersection(halls: [], id: 44, x: 312.32, y: 365.87),
    Intersection(halls: [], id: 45, x: 316.35, y: 365.87),
    Intersection(halls: [], id: 46, x: 309.74, y: 377.39),
    Intersection(halls: [], id: 47, x: 339.57, y: 365.87),
    Intersection(halls: [], id: 48, x: 283.99, y: 377.39),
    Intersection(halls: [], id: 49, x: 283.99, y: 379.47),
    Intersection(halls: [], id: 50, x: 243.51, y: 379.47),
    Intersection(halls: [], id: 51, x: 243.51, y: 377.39),
    Intersection(halls: [], id: 52, x: 243.51, y: 403.65),
    Intersection(halls: [], id: 53, x: 243.51, y: 366.29),
    Intersection(halls: [], id: 54, x: 237.96, y: 377.39),
    Intersection(halls: [], id: 55, x: 235.61, y: 347.45),
    Intersection(halls: [], id: 56, x: 229.73, y: 347.45),
    Intersection(halls: [], id: 57, x: 229.73, y: 336.56),
    Intersection(halls: [], id: 58, x: 229.73, y: 343.74),
    Intersection(halls: [], id: 59, x: 223.05, y: 343.74),
    Intersection(halls: [], id: 60, x: 209.44, y: 343.74),
    Intersection(halls: [], id: 61, x: 207.35, y: 333.5),
    Intersection(halls: [], id: 62, x: 207.35, y: 303.78),
    Intersection(halls: [], id: 63, x: 194.96, y: 333.5),
    Intersection(halls: [], id: 64, x: 132.92, y: 409.61),
    Intersection(halls: [], id: 65, x: 132.92, y: 403.74),
    Intersection(halls: [], id: 66, x: 182.55, y: 332.04),
    Intersection(halls: [], id: 67, x: 194.96, y: 332.04),
    Intersection(halls: [], id: 68, x: 155.74, y: 332.97),
    Intersection(halls: [], id: 69, x: 141.87, y: 332.97),
    Intersection(halls: [], id: 70, x: 133.37, y: 332.97),
    Intersection(halls: [], id: 71, x: 141.87, y: 374.24),
    Intersection(halls: [], id: 72, x: 156.97, y: 374.24),
    Intersection(halls: [], id: 73, x: 261.19, y: 377.39),
    Intersection(halls: [], id: 74, x: 221.78, y: 354.5),
    Intersection(halls: [], id: 75, x: 36.27, y: 373.34),
    Intersection(halls: [], id: 76, x: 99.92, y: 407.48),
    Intersection(halls: [], id: 77, x: 93.83, y: 407.48),
    Intersection(halls: [], id: 78, x: 142.8, y: 488.64),
    Intersection(halls: [], id: 79, x: 130.76, y: 501.31),
    Intersection(halls: [], id: 80, x: 100.44, y: 471.51),
    Intersection(halls: [], id: 81, x: 95.78, y: 466.76),
    Intersection(halls: [], id: 82, x: 100.44, y: 466.76),
    Intersection(halls: [], id: 83, x: 269.25, y: 418.65),
    Intersection(halls: [], id: 84, x: 185.83, y: 471.51),
    Intersection(halls: [], id: 85, x: 185.83, y: 464.3),
    Intersection(halls: [], id: 86, x: 218.39, y: 428.71),
    Intersection(halls: [], id: 87, x: 280.92, y: 418.65),
    Intersection(halls: [], id: 88, x: 235.35, y: 355.21),
]

// Hall(start: , end: , length: , id: ),
var halls2 = [
    Hall(start: 0, end: 1, length: 34.39, id: 0),
    Hall(start: 0, end: 75, length: 15.39, id: 1),
    Hall(start: 1, end: 2, length: 15.59, id: 2),
    Hall(start: 1, end: 3, length: 6.54, id: 3),
    Hall(start: 1, end: 4, length: 23.6, id: 4),
    Hall(start: 4, end: 7, length: 13.42, id: 5),
    Hall(start: 7, end: 5, length: 19.07, id: 6),
    Hall(start: 5, end: 6, length: 4.36, id: 7),
    Hall(start: 3, end: 8, length: 17.19, id: 8),
    Hall(start: 4, end: 9, length: 6.54, id: 9),
    Hall(start: 8, end: 9, length: 6.42, id: 10),
    Hall(start: 9, end: 76, length: 13.28, id: 11),
    Hall(start: 76, end: 10, length: 2.12, id: 12),
    Hall(start: 76, end: 77, length: 6.09, id: 13),
    Hall(start: 10, end: 11, length: 22.02, id: 14),
    Hall(start: 11, end: 12, length: 5.79, id: 15),
    Hall(start: 12, end: 81, length: 31.09, id: 16),
    Hall(start: 81, end: 82, length: 4.66, id: 17),
    Hall(start: 81, end: 13, length: 4.75, id: 18),
    Hall(start: 13, end: 80, length: 4.66, id: 19),
    Hall(start: 80, end: 82, length: 4.75, id: 20),
    Hall(start: 80, end: 14, length: 13.5, id: 21),
    Hall(start: 14, end: 15, length: 19.16, id: 22),
    Hall(start: 15, end: 17, length: 9.01, id: 23),
    Hall(start: 15, end: 16, length: 23.34, id: 24),
    Hall(start: 16, end: 78, length: 21.9, id: 25),
    Hall(start: 15, end: 78, length: 19.68, id: 26),
    Hall(start: 78, end: 79, length: 17.48, id: 27),
    Hall(start: 17, end: 18, length: 23.34, id: 28),
    Hall(start: 16, end: 18, length: 9.01, id: 29),
    Hall(start: 18, end: 19, length: 4.0, id: 30),
    Hall(start: 16, end: 84, length: 29.39, id: 31),
    Hall(start: 18, end: 85, length: 29.44, id: 32),
    Hall(start: 84, end: 85, length: 7.21, id: 33),
    Hall(start: 85, end: 20, length: 23.6, id: 34),
    Hall(start: 20, end: 22, length: 41.16, id: 35),
    Hall(start: 22, end: 23, length: 4.85, id: 36),
    Hall(start: 23, end: 24, length: 4.11, id: 37),
    Hall(start: 24, end: 86, length: 5.57, id: 38),
    Hall(start: 21, end: 22, length: 13.54, id: 39),
    Hall(start: 10, end: 64, length: 33.0, id: 40),
    Hall(start: 64, end: 65, length: 5.87, id: 41),
    Hall(start: 64, end: 29, length: 23.45, id: 42),
    Hall(start: 29, end: 30, length: 3.1, id: 43),
    Hall(start: 29, end: 28, length: 47.32, id: 44),
    Hall(start: 28, end: 32, length: 8.71, id: 45),
    Hall(start: 28, end: 21, length: 5.75, id: 46),
    Hall(start: 21, end: 25, length: 8.95, id: 47),
    Hall(start: 24, end: 25, length: 13.54, id: 48),
    Hall(start: 25, end: 26, length: 25.02, id: 49),
    Hall(start: 21, end: 27, length: 5.95, id: 50),
    Hall(start: 27, end: 52, length: 34.08, id: 51),
    Hall(start: 52, end: 33, length: 25.74, id: 52),
    Hall(start: 33, end: 31, length: 30.76, id: 53),
    Hall(start: 33, end: 83, length: 15.0, id: 54),
    Hall(start: 83, end: 87, length: 11.67, id: 55),
    Hall(start: 83, end: 34, length: 23.52, id: 56),
    Hall(start: 34, end: 35, length: 13.71, id: 57),
    Hall(start: 34, end: 36, length: 7.44, id: 58),
    Hall(start: 34, end: 37, length: 30.76, id: 59),
    Hall(start: 31, end: 37, length: 38.52, id: 60),
    Hall(start: 37, end: 38, length: 31.03, id: 61),
    Hall(start: 38, end: 40, length: 40.43, id: 62),
    Hall(start: 31, end: 39, length: 15.67, id: 63),
    Hall(start: 39, end: 40, length: 15.48, id: 64),
    Hall(start: 40, end: 41, length: 69.55, id: 65),
    Hall(start: 39, end: 42, length: 18.83, id: 66),
    Hall(start: 42, end: 43, length: 3.24, id: 67),
    Hall(start: 43, end: 44, length: 17.05, id: 68),
    Hall(start: 44, end: 45, length: 4.03, id: 69),
    Hall(start: 46, end: 44, length: 11.8, id: 70),
    Hall(start: 46, end: 45, length: 13.28, id: 71),
    Hall(start: 45, end: 47, length: 23.22, id: 72),
    Hall(start: 46, end: 48, length: 25.76, id: 73),
    Hall(start: 48, end: 49, length: 2.09, id: 74),
    Hall(start: 49, end: 50, length: 40.47, id: 75),
    Hall(start: 50, end: 52, length: 24.18, id: 76),
    Hall(start: 50, end: 53, length: 13.19, id: 77),
    Hall(start: 48, end: 73, length: 22.79, id: 78),
    Hall(start: 73, end: 51, length: 17.68, id: 79),
    Hall(start: 51, end: 53, length: 11.1, id: 80),
    Hall(start: 51, end: 54, length: 5.55, id: 81),
    Hall(start: 54, end: 53, length: 12.41, id: 82),
    Hall(start: 54, end: 88, length: 22.33, id: 83),
    Hall(start: 88, end: 55, length: 7.77, id: 84),
    Hall(start: 55, end: 56, length: 5.89, id: 85),
    Hall(start: 88, end: 56, length: 9.59, id: 86),
    Hall(start: 56, end: 58, length: 3.71, id: 87),
    Hall(start: 58, end: 57, length: 7.18, id: 88),
    Hall(start: 58, end: 59, length: 6.68, id: 89),
    Hall(start: 59, end: 56, length: 7.64, id: 90),
    Hall(start: 56, end: 74, length: 10.63, id: 91),
    Hall(start: 59, end: 60, length: 13.61, id: 92),
    Hall(start: 60, end: 61, length: 10.45, id: 93),
    Hall(start: 61, end: 62, length: 29.72, id: 94),
    Hall(start: 61, end: 63, length: 12.39, id: 95),
    Hall(start: 61, end: 67, length: 12.48, id: 96),
    Hall(start: 67, end: 66, length: 12.41, id: 97),
    Hall(start: 66, end: 68, length: 26.83, id: 98),
    Hall(start: 68, end: 69, length: 13.87, id: 99),
    Hall(start: 69, end: 70, length: 8.5, id: 100),
    Hall(start: 7, end: 71, length: 41.94, id: 101),
    Hall(start: 69, end: 71, length: 41.27, id: 102),
    Hall(start: 71, end: 72, length: 15.11, id: 103),
    Hall(start: 63, end: 67, length: 1.46, id: 104),
]

// Room(name: "", startDist: , hall: , x: , y: ),
var rooms3 = [
    Room(name: "313 Math Resource Center", startDist: 5.42, hall: 1, x: 86.51, y: 384.78),
    Room(name: "314", startDist: 9.66, hall: 0, x: 48.14, y: 390.21),
    Room(name: "315", startDist: 0.0, hall: 0, x: 38.48, y: 390.21),
    Room(name: "316", startDist: 0.0, hall: 0, x: 38.48, y: 390.21),
    Room(name: "317", startDist: 6.01, hall: 0, x: 44.49, y: 390.21),
    Room(name: "318", startDist: 9.66, hall: 0, x: 48.14, y: 390.21),
    Room(name: "319", startDist: 28.64, hall: 0, x: 67.13, y: 390.21),
    Room(name: "320", startDist: 33.04, hall: 0, x: 71.52, y: 390.21),
    Room(name: "320", startDist: 33.04, hall: 0, x: 71.52, y: 390.21),
    Room(name: "312", startDist: 6.04, hall: 10, x: 107.1, y: 376.19),
    Room(name: "323", startDist: 6.04, hall: 10, x: 107.1, y: 376.19),
    Room(name: "311", startDist: 21.12, hall: 10, x: 122.18, y: 376.19),
    Room(name: "324", startDist: 33.39, hall: 10, x: 134.45, y: 376.19),
    Room(name: "310", startDist: 16.82, hall: 11, x: 143.08, y: 358.91),
    Room(name: "306", startDist: 17.35, hall: 11, x: 143.08, y: 357.88),
    Room(name: "309", startDist: 35.73, hall: 11, x: 143.08, y: 340.156),
    Room(name: "307", startDist: 36.63, hall: 11, x: 143.08, y: 339.22),
    Room(name: "308", startDist: 39.4, hall: 11, x: 143.08, y: 336),
    Room(name: "322", startDist: 6.73, hall: 7, x: 101.06, y: 396.76),
    Room(name: "321", startDist: 17.28, hall: 8, x: 123.3, y: 411.59),
    Room(name: "305", startDist: 21.6, hall: 14, x: 167.94, y: 376.19),
    Room(name: "325", startDist: 2.62, hall: 25, x: 160.75, y: 379.346),
    Room(name: "326", startDist: 14.4, hall: 25, x: 160.75, y: 391.09),
    Room(name: "327", startDist: 26.26, hall: 25, x: 160.75, y: 402.49),
    Room(name: "328 World Language Dept", startDist: 14.2, hall: 14, x: 175.265, y: 376.19),
]

// Intersection(halls: [], id: , x: , y: ),
var intersects3 = [
    Intersection(halls: [], id: 0, x: 38.48, y: 390.21),
    Intersection(halls: [], id: 1, x: 86.51, y: 390.21),
    Intersection(halls: [], id: 2, x: 86.51, y: 384.78),
    Intersection(halls: [], id: 3, x: 96.51, y: 390.21),
    Intersection(halls: [], id: 4, x: 101.06, y: 390.21),
    Intersection(halls: [], id: 5, x: 101.06, y: 376.19),
    Intersection(halls: [], id: 6, x: 101.06, y: 357.05),
    Intersection(halls: [], id: 7, x: 105.48, y: 357.05),
    Intersection(halls: [], id: 8, x: 101.06, y: 411.59),
    Intersection(halls: [], id: 9, x: 135.51, y: 411.59),
    Intersection(halls: [], id: 10, x: 135.51, y: 405.83),
    Intersection(halls: [], id: 11, x: 143.08, y: 376.19),
    Intersection(halls: [], id: 12, x: 159.34, y: 376.19),
    Intersection(halls: [], id: 13, x: 160.75, y: 376.19),
    Intersection(halls: [], id: 14, x: 143.08, y: 336),
    Intersection(halls: [], id: 15, x: 134.48, y: 336),
    Intersection(halls: [], id: 16, x: 198.23, y: 376.19),
    Intersection(halls: [], id: 17, x: 160.75, y: 415.55),
    Intersection(halls: [], id: 18, x: 198.23, y: 345.12),
    Intersection(halls: [], id: 19, x: 211.4, y: 345.12),
    Intersection(halls: [], id: 20, x: 241.37, y: 345.12),
    Intersection(halls: [], id: 21, x: 241.37, y: 362.88),
    Intersection(halls: [], id: 22, x: 241.37, y: 382.21),
    Intersection(halls: [], id: 23, x: 241.37, y: 397.05),
    Intersection(halls: [], id: 24, x: 210.02, y: 397.05),
    Intersection(halls: [], id: 25, x: 210.02, y: 402.65),
    Intersection(halls: [], id: 26, x: 276.21, y: 362.88),
    Intersection(halls: [], id: 27, x: 276.21, y: 370.38),
    Intersection(halls: [], id: 28, x: 276.21, y: 381.9),
    Intersection(halls: [], id: 29, x: 314.02, y: 370.38),
    Intersection(halls: [], id: 30, x: 316.1, y: 368.41),
    Intersection(halls: [], id: 31, x: 341.73, y: 368.41),

]

//  Hall(start: , end: , length: , id: ),
var halls3 = [
    Hall(start: 0, end: 1, length: 49.41, id: 0),
    Hall(start: 1, end: 2, length: 5.42, id: 1),
    Hall(start: 1, end: 3, length: 8.62, id: 2),
    Hall(start: 3, end: 4, length: 6.19, id: 3),
    Hall(start: 4, end: 5, length: 14.02, id: 4),
    Hall(start: 5, end: 6, length: 19.14, id: 5),
    Hall(start: 6, end: 7, length: 4.48, id: 6),
    Hall(start: 4, end: 8, length: 21.38, id: 7),
    Hall(start: 8, end: 9, length: 32.81, id: 8),
    Hall(start: 9, end: 10, length: 5.76, id: 9),
    Hall(start: 5, end: 11, length: 42.13, id: 10),
    Hall(start: 11, end: 14, length: 41.35, id: 11),
    Hall(start: 14, end: 15, length: 8.99, id: 12),
    Hall(start: 11, end: 12, length: 14.51, id: 13),
    Hall(start: 13, end: 16, length: 35.17, id: 14),
    Hall(start: 16, end: 18, length: 31.07, id: 15),
    Hall(start: 18, end: 19, length: 13.17, id: 16),
    Hall(start: 19, end: 20, length: 29.97, id: 17),
    Hall(start: 20, end: 21, length: 17.76, id: 18),
    Hall(start: 21, end: 22, length: 19.33, id: 19),
    Hall(start: 23, end: 24, length: 31.35, id: 20),
    Hall(start: 22, end: 28, length: 34.83, id: 21),
    Hall(start: 27, end: 28, length: 11.52, id: 22),
    Hall(start: 26, end: 27, length: 7.5, id: 23),
    Hall(start: 21, end: 26, length: 34.83, id: 24),
    Hall(start: 13, end: 17, length: 39.36, id: 25),
    Hall(start: 27, end: 29, length: 37.81, id: 26),
    Hall(start: 29, end: 30, length: 2.87, id: 27),
    Hall(start: 30, end: 31, length: 25.63, id: 28),
    Hall(start: 24, end: 25, length: 5.6, id: 29),
    Hall(start: 22, end: 23, length: 14.83, id: 30),
    Hall(start: 12, end: 13, length: 3.87, id: 31),
]

var floor1 = Floor(halls: halls, inters: intersects, rooms: rooms)
var floor2 = Floor(halls: halls2, inters: intersects2, rooms: rooms2)
var floor3 = Floor(halls: halls3, inters: intersects3, rooms: rooms3)

var floors = [floor1, floor2, floor3]

//  Stair(dist: [], x: , y: , allFloors: true, inter: [floor1.inters[0], floor2.inters[], floor3.inters[]], id: )
var stairs = [
    Stair(name: "SW 5", dist: [14.99, 7.38, 7.11], x: [100.20, 103.43, 105.48], y: [349.50, 347.79, 349.94], allFloors: true, inters: [floor1.inters[1], floor2.inters[6], floor3.inters[7]], id: 0)
]
