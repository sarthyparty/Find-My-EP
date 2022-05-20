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
        if !stair.allFloors {
            if start.floor + end.floor > 3 {
                continue
            }
        }
        
        if stair.name == "SW 6 (3)" {
            if (start.floor == 1 || end.floor == 1) && (start.floor == 2 || end.floor == 2) {
                continue
            }
        }
        
        if stair.name == "SW 6 (1)" {
            if (start.floor == 3 || end.floor == 3) && (start.floor == 2 || end.floor == 2) {
                continue
            }
        }
        let res1_start = startfloor.a_star_shortestPath(start: stair.inters[start.floor-1], end: startfloor.inters[startfloor.halls[start.hall].start])
        var start_res = startfloor.a_star_shortestPath(start: stair.inters[start.floor-1], end: startfloor.inters[startfloor.halls[start.hall].end])
        if res1_start.dist + start.startDist < start_res.dist + startfloor.halls[start.hall].length - start.startDist {
            start_res = res1_start
            start_res.dist = res1_start.dist + start.startDist + stair.dist[start.floor-1]
        } else {
            start_res.dist = start_res.dist + startfloor.halls[start.hall].length - start.startDist + stair.dist[start.floor-1]
        }
        
        
        let res1_end = endfloor.a_star_shortestPath(start: stair.inters[end.floor-1], end: endfloor.inters[endfloor.halls[end.hall].start])
        var end_res = endfloor.a_star_shortestPath(start: stair.inters[end.floor-1], end: endfloor.inters[endfloor.halls[end.hall].end])
        
        if res1_end.dist + end.startDist < end_res.dist + endfloor.halls[end.hall].length - end.startDist {
            end_res = res1_end
            end_res.dist = res1_end.dist + end.startDist + stair.dist[end.floor-1]
        } else {
            end_res.dist = end_res.dist + endfloor.halls[end.hall].length - end.startDist + stair.dist[end.floor-1]
        }
        
        print(min_stair)
        
        if end_res.dist + start_res.dist < min_start_floor.dist + min_end_floor.dist {
            min_start_floor = start_res
            min_end_floor = end_res
            min_stair = stair.id
            print(min_stair)
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
    Room(name: "South Entrance", startDist: 8.95, hall: 29, x: 215.61, y: 302.55),
//    Room(name: "Performing Arts Center Entrance Floor 1 (PAC)", startDist: 0, hall: 56, x: 407.51, y: 402.06),
    
    Room(name: "South Commons", startDist: 21.34, hall: 65, x: 215.61, y: 377.07),
    Room(name: "130", startDist: 10.42, hall: 0, x: 85.39, y: 364.49),
    Room(name: "129", startDist: 13.62, hall: 0, x: 88.59, y: 364.49),
    Room(name: "131", startDist: 9.69, hall: 1, x: 100.2, y: 374.18),
    Room(name: "128", startDist: 3.74, hall: 6, x: 103.94, y: 375.33),
    Room(name: "127", startDist: 3.74, hall: 6, x: 103.94, y: 375.33),
    Room(name: "126", startDist: 21.2, hall: 6, x: 121.4, y: 375.33),
    Room(name: "125", startDist: 21.2, hall: 6, x: 121.4, y: 375.33),
    Room(name: "124", startDist: 32.42, hall: 6, x: 132.62, y: 375.33),
    Room(name: "117", startDist: 9.3, hall: 8, x: 148.63, y: 384.63),
    Room(name: "116", startDist: 18.05, hall: 8, x: 148.63, y: 393.38),
    Room(name: "115", startDist: 20.31, hall: 8, x: 148.63, y: 395.64),
    Room(name: "114A", startDist: 22.85, hall: 8, x: 148.63, y: 398.18),
    Room(name: "114B", startDist: 25.55, hall: 8, x: 148.63, y: 400.88),
    Room(name: "132 Social Studies Resource Center (SSRC)", startDist: 12.18, hall: 3, x: 88.02, y: 395.18),
    Room(name: "133 Teacher Offices", startDist: 28.23, hall: 3, x: 71.97, y: 395.18),
    Room(name: "134", startDist: 1.34, hall: 5, x: 57.26, y: 389.39),
    Room(name: "135", startDist: 13.12, hall: 5, x: 45.48, y: 389.39),
    Room(name: "139", startDist: 41.6, hall: 3, x: 58.6, y: 395.18),
    Room(name: "138", startDist: 41.6, hall: 3, x: 58.6, y: 395.18),
    Room(name: "137", startDist: 16.0, hall: 5, x: 42.6, y: 389.39),
    Room(name: "136", startDist: 16.0, hall: 5, x: 42.6, y: 389.39),
    Room(name: "121", startDist: 2.65, hall: 12, x: 144.85, y: 333.64),
    Room(name: "120", startDist: 4.85, hall: 12, x: 147.05, y: 333.64),
    Room(name: "119", startDist: 4.85, hall: 12, x: 147.05, y: 335.22),
    Room(name: "122", startDist: 36.98, hall: 11, x: 142.2, y: 338.35),
    Room(name: "123", startDist: 17.61, hall: 11, x: 142.2, y: 357.72),
    Room(name: "118", startDist: 17.61, hall: 11, x: 142.2, y: 357.72),
    Room(name: "144 Weight Room", startDist: 24.0, hall: 13, x: 100.2, y: 434.12),
    Room(name: "143 Boys Locker Room", startDist: 42.51, hall: 13, x: 100.2, y: 452.63),
    Room(name: "142 Girls Locker Room", startDist: 29.13, hall: 13, x: 100.2, y: 439.25),
    Room(name: "145 Fitness Room", startDist: 12.45, hall: 13, x: 100.2, y: 422.57),
    Room(name: "146 Training", startDist: 31.23, hall: 9, x: 131.43, y: 410.12),
    Room(name: "147 Locker Room B", startDist: 8.61, hall: 15, x: 156.67, y: 418.73),
    Room(name: "151 Locker Room A", startDist: 8.61, hall: 15, x: 156.67, y: 418.73),
    Room(name: "148 Locker Room D", startDist: 29.35, hall: 15, x: 156.67, y: 439.47),
    Room(name: "150 Locker Room C", startDist: 29.35, hall: 15, x: 156.67, y: 439.47),
    Room(name: "170 Art Facs Health", startDist: 33.52, hall: 42, x: 277.73, y: 369.07),
    Room(name: "171", startDist: 8.54, hall: 36, x: 262.34, y: 361.18),
    Room(name: "169", startDist: 24.05, hall: 42, x: 287.38, y: 366.16),
    Room(name: "168", startDist: 10.2, hall: 42, x: 301.15, y: 367.63),
    Room(name: "167", startDist: 1.75, hall: 44, x: 313, y: 366.95),
    Room(name: "166", startDist: 22.36, hall: 44, x: 333.61, y: 366.95),
    Room(name: "165", startDist: 31.99, hall: 44, x: 343.24, y: 366.95),
    Room(name: "162", startDist: 48.32, hall: 42, x: 262.93, y: 369.07),
    Room(name: "163", startDist: 21.97, hall: 42, x: 289.28, y: 369.07),
    Room(name: "164", startDist: 10.05, hall: 42, x: 301.21, y: 369.07),
    Room(name: "West Side Deli", startDist: 10.24, hall: 45, x: 250.81, y: 379.31),
    Room(name: "101 Main Office", startDist: 12.64, hall: 68, x: 215.61, y: 324.14),
    Room(name: "100 Student Center South (SCS)", startDist: 16.57, hall: 32, x: 207.82, y: 327.32),
    Room(name: "104 Health", startDist: 8.82, hall: 69, x: 206.79, y: 338.54),
    Room(name: "106", startDist: 0, hall: 21, x: 183.24, y: 362.39),
    Room(name: "107 Educational Services", startDist: 4.99, hall: 18, x: 165.67, y: 371.83),
    Room(name: "112", startDist: 8.5, hall: 17, x: 160.69, y: 383.8),
    Room(name: "111", startDist: 8.0, hall: 17, x: 160.69, y: 383.2),
    Room(name: "113", startDist: 2.91, hall: 17, x: 160.69, y: 377.82),
    Room(name: "110", startDist: 1.52, hall: 17, x: 160.69, y: 375.95),
    Room(name: "109", startDist: 14.6, hall: 18, x: 174.11, y: 372.12),
    Room(name: "108", startDist: 3.5, hall: 19, x: 174.11, y: 369.81),
    Room(name: "154 South Commons Collab", startDist: 18.64, hall: 52, x: 208.19, y: 380.96),
    Room(name: "152 Wrestling Room", startDist: 22.96, hall: 53, x: 179.62, y: 410.87),
    Room(name: "155 Registration Office", startDist: 6.81, hall: 52, x: 208.19, y: 369.07),
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
    Intersection(halls: [], id: 11, x: 142.2, y: 333.64),
    Intersection(halls: [], id: 12, x: 157.27, y: 333.64),
    Intersection(halls: [], id: 13, x: 100.2, y: 453.83),
    Intersection(halls: [], id: 14, x: 156.67, y: 410.12),
    Intersection(halls: [], id: 15, x: 156.67, y: 456.30),
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
    Intersection(halls: [], id: 27, x: 215.61, y: 355.73),
    Intersection(halls: [], id: 28, x: 215.61, y: 342.46),
    Intersection(halls: [], id: 29, x: 221.53, y: 342.46),
    Intersection(halls: [], id: 30, x: 215.61, y: 311.50),
    Intersection(halls: [], id: 31, x: 215.61, y: 302.55),
    Intersection(halls: [], id: 32, x: 207.82, y: 311.50),
    Intersection(halls: [], id: 33, x: 207.82, y: 327.32),
    Intersection(halls: [], id: 34, x: 207.82, y: 307.32),
    Intersection(halls: [], id: 35, x: 245.89, y: 355.73),
    Intersection(halls: [], id: 36, x: 245.89, y: 361.03),
    Intersection(halls: [], id: 37, x: 245.89, y: 369.07),
    Intersection(halls: [], id: 38, x: 311.25, y: 369.07),
    Intersection(halls: [], id: 39, x: 311.25, y: 366.95),
    Intersection(halls: [], id: 40, x: 353.55, y: 366.95),
    Intersection(halls: [], id: 41, x: 250.81, y: 369.07),
    Intersection(halls: [], id: 42, x: 250.81, y: 392.55),
    Intersection(halls: [], id: 43, x: 215.61, y: 392.55),
    Intersection(halls: [], id: 44, x: 215.61, y: 297.85),
    Intersection(halls: [], id: 45, x: 208.75, y: 297.85),
    Intersection(halls: [], id: 46, x: 215.61, y: 410.12),
    Intersection(halls: [], id: 47, x: 209.03, y: 410.12),
    Intersection(halls: [], id: 48, x: 262.34, y: 369.07),
    Intersection(halls: [], id: 49, x: 262.34, y: 361.18),
    Intersection(halls: [], id: 50, x: 129.25, y: 333.64),
    Intersection(halls: [], id: 51, x: 160.69, y: 383.30),
    Intersection(halls: [], id: 52, x: 41.80, y: 373.73),
    Intersection(halls: [], id: 53, x: 134.02, y: 410.12),
    Intersection(halls: [], id: 54, x: 134.02, y: 400.93),
    Intersection(halls: [], id: 55, x: 204.52, y: 410.12),
    Intersection(halls: [], id: 56, x: 204.52, y: 401.40),
    Intersection(halls: [], id: 57, x: 336.32, y: 366.95),
    Intersection(halls: [], id: 58, x: 153.46, y: 410.12),
    Intersection(halls: [], id: 59, x: 153.46, y: 415.73),
    Intersection(halls: [], id: 60, x: 93.83, y: 410.12),
    Intersection(halls: [], id: 61, x: 215.61, y: 377.07),
    Intersection(halls: [], id: 62, x: 215.61, y: 338.54),
    Intersection(halls: [], id: 63, x: 206.79, y: 338.54),
    Intersection(halls: [], id: 64, x: 215.61, y: 327.32),
]

//  Hall(start: , end: , length: , id: ),
var halls = [
    Hall(start: 0, end: 1, length: 25.23, id: 0),
    Hall(start: 1, end: 2, length: 10.84, id: 1),
    Hall(start: 2, end: 3, length: 19.85, id: 2),
    Hall(start: 3, end: 4, length: 41.6, id: 3),
    Hall(start: 4, end: 5, length: 5.79, id: 4),
    Hall(start: 5, end: 6, length: 16.8, id: 5),
    Hall(start: 2, end: 7, length: 42.0, id: 6),
    Hall(start: 7, end: 8, length: 6.43, id: 7),
    Hall(start: 8, end: 9, length: 34.79, id: 8),
    Hall(start: 10, end: 53, length: 33.82, id: 9),
    Hall(start: 10, end: 3, length: 14.94, id: 10),
    Hall(start: 7, end: 11, length: 40.11, id: 11),
    Hall(start: 11, end: 12, length: 15.07, id: 12),
    Hall(start: 10, end: 13, length: 43.71, id: 13),
    Hall(start: 9, end: 58, length: 4.83, id: 14),
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
    Hall(start: 30, end: 31, length: 8.95, id: 29),
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
    Hall(start: 39, end: 57, length: 25.07, id: 44),
    Hall(start: 41, end: 42, length: 23.48, id: 45),
    Hall(start: 42, end: 43, length: 35.2, id: 46),
    Hall(start: 43, end: 44, length: 94.7, id: 47),
    Hall(start: 44, end: 46, length: 111.0, id: 48),
    Hall(start: 46, end: 47, length: 6.58, id: 49),
    Hall(start: 45, end: 47, length: 111.0, id: 50),
    Hall(start: 44, end: 45, length: 6.86, id: 51),
    Hall(start: 25, end: 45, length: 64.54, id: 52),
    Hall(start: 14, end: 55, length: 47.87, id: 53),
    Hall(start: 21, end: 22, length: 4.37, id: 54),
    Hall(start: 41, end: 48, length: 11.53, id: 55),
    Hall(start: 6, end: 52, length: 15.66, id: 56),
    Hall(start: 9, end: 53, length: 14.61, id: 57),
    Hall(start: 47, end: 55, length: 4.51, id: 58),
    Hall(start: 55, end: 56, length: 7.45, id: 59),
    Hall(start: 53, end: 54, length: 9.19, id: 60),
    Hall(start: 40, end: 57, length: 17.23, id: 61),
    Hall(start: 14, end: 58, length: 3.21, id: 62),
    Hall(start: 58, end: 59, length: 5.61, id: 63),
    Hall(start: 10, end: 60, length: 6.37, id: 64),
    Hall(start: 27, end: 61, length: 21.34, id: 65),
    Hall(start: 43, end: 61, length: 15.48, id: 66),
    Hall(start: 28, end: 62, length: 3.93, id: 67),
    Hall(start: 30, end: 62, length: 27.04, id: 68),
    Hall(start: 62, end: 63, length: 8.82, id: 69),
    Hall(start: 62, end: 64, length: 11.22, id: 70),
    Hall(start: 30, end: 64, length: 15.82, id: 71),
    Hall(start: 33, end: 64, length: 7.79, id: 72),
]

//  Room(name: "", startDist: , hall: , x: , y: ),
var rooms2 = [
    Room(name: "East Entrance", startDist: 0.0, hall: 131, x: 72.65, y: 419.88),
    Room(name: "Student Activities Entrance (Activity Center)", startDist: 11.43, hall: 141, x: 150.9, y: 496.7),
    Room(name: "North Entrance", startDist: 9.06, hall: 142, x: 208.26, y: 473.36),
    Room(name: "Performing Arts Center Entrance Floor 2 (PAC)", startDist: 30.17, hall: 144, x: 389.22, y: 455.23),
    
    Room(name: "East Commons", startDist: 0.0, hall: 101, x: 98.85, y: 374.24),
    Room(name: "220", startDist: 0.0, hall: 0, x: 41.93, y: 387.66),
    Room(name: "219", startDist: 0.0, hall: 0, x: 41.93, y: 387.66),
    Room(name: "218", startDist: 3.66, hall: 0, x: 45.59, y: 387.66),
    Room(name: "221", startDist: 3.66, hall: 0, x: 45.59, y: 387.66),
    Room(name: "217", startDist: 23.2, hall: 0, x: 65.13, y: 387.66),
    Room(name: "222", startDist: 23.2, hall: 0, x: 65.13, y: 387.66),
    Room(name: "214", startDist: 3.46, hall: 101, x: 102.31, y: 374.24),
    Room(name: "212", startDist: 21.62, hall: 101, x: 120.47, y: 374.24),
    Room(name: "215", startDist: 3.46, hall: 101, x: 102.31, y: 374.24),
    Room(name: "213", startDist: 21.62, hall: 101, x: 120.47, y: 374.24),
    Room(name: "211", startDist: 34.11, hall: 101, x: 132.96, y: 374.24),
    Room(name: "209", startDist: 3.48, hall: 102, x: 141.87, y: 336.45),
    Room(name: "210", startDist: 24.51, hall: 102, x: 141.87, y: 357.48),
    Room(name: "208", startDist: 20.74, hall: 102, x: 141.87, y: 353.71),
    Room(name: "206", startDist: 11.75, hall: 99, x: 143.99, y: 332.97),
    Room(name: "205", startDist: 9.23, hall: 99, x: 146.51, y: 332.97),
    Room(name: "203", startDist: 16.4, hall: 93, x: 190.59, y: 332.04),
    Room(name: "204", startDist: 1.11, hall: 104, x: 194.96, y: 333.5),
    Room(name: "201", startDist: 21.48, hall: 94, x: 206.92, y: 312.02),
    Room(name: "207", startDist: 9.17, hall: 99, x: 146.57, y: 332.97),
    Room(name: "200", startDist: 23.78, hall: 94, x: 206.92, y: 309.72),
    Room(name: "202 English Resource Center (ERC)", startDist: 5.51, hall: 89, x: 223.49, y: 343.74),
    Room(name: "270", startDist: 7.18, hall: 88, x: 229.0, y: 336.56),
    Room(name: "269", startDist: 4.02, hall: 85, x: 231.59, y: 347.45),
    Room(name: "268 Business & Marketing", startDist: 11.81, hall: 79, x: 249.38, y: 360.28),
    Room(name: "267", startDist: 18.88, hall: 78, x: 265.11, y: 360.28),
    Room(name: "266", startDist: 7.29, hall: 78, x: 276.7, y: 360.28),
    Room(name: "265", startDist: 21.27, hall: 73, x: 288.47, y: 360.28),
    Room(name: "264", startDist: 9.34, hall: 73, x: 300.4, y: 360.28),
    Room(name: "259", startDist: 11.83, hall: 73, x: 297.91, y: 360.28),
    Room(name: "258", startDist: 23.29, hall: 73, x: 286.45, y: 360.28),
    Room(name: "257", startDist: 19.19, hall: 74, x: 283.99, y: 379.47),
    Room(name: "263", startDist: 5.02, hall: 72, x: 321.37, y: 365.87),
    Room(name: "262", startDist: 16.24, hall: 72, x: 332.59, y: 365.87),
    Room(name: "227 Student Center East (SCE)", startDist: 0.0, hall: 16, x: 95.78, y: 435.67),
    Room(name: "227I Career Resource Center (CRC)", startDist: 25.86, hall: 16, x: 95.78, y: 461.53),
    Room(name: "261", startDist: 23.22, hall: 72, x: 339.57, y: 365.87),
    Room(name: "256", startDist: 18.97, hall: 75, x: 265.02, y: 379.47),
    Room(name: "255", startDist: 30.69, hall: 75, x: 253.3, y: 379.47),
    Room(name: "251", startDist: 0.0, hall: 68, x: 312.32, y: 382.92),
    Room(name: "254", startDist: 21.16, hall: 75, x: 262.83, y: 379.47),
    Room(name: "253", startDist: 19.32, hall: 75, x: 264.67, y: 379.47),
    Room(name: "252", startDist: 7.42, hall: 53, x: 276.67, y: 403.65),
    Room(name: "240", startDist: 6.33, hall: 38, x: 218.39, y: 429.47),
    Room(name: "239 Cookie Store", startDist: 2.92, hall: 48, x: 218.39, y: 420.22),
    Room(name: "241 Auditorium", startDist: 25.02, hall: 49, x: 243.41, y: 408.38),
    Room(name: "245 Choir", startDist: 11.67, hall: 55, x: 280.92, y: 418.65),
    Room(name: "244 Orchestra", startDist: 0.0, hall: 111, x: 273.98, y: 425.48),
    Room(name: "242", startDist: 13.71, hall: 57, x: 255.57, y: 441.26),
    Room(name: "243", startDist: 7.44, hall: 58, x: 269.25, y: 449.61),
    Room(name: "246 Band", startDist: 27.94, hall: 60, x: 300.01, y: 431.59),
    Room(name: "248 Stage", startDist: 0.0, hall: 62, x: 331.04, y: 442.17),
    Room(name: "248 Performing Arts Center (PAC)", startDist: 35.69, hall: 65, x: 366.73, y: 401.75),
    Room(name: "247 Wood Shop", startDist: 24.97, hall: 61, x: 324.98, y: 442.17),
    Room(name: "233 Small Gym", startDist: 16.67, hall: 114, x: 126.88, y: 425.05),
    Room(name: "235 Main Gym", startDist: 2.38, hall: 115, x: 156.37, y: 415.08),
    Room(name: "229 Dance Studio", startDist: 9.72, hall: 120, x: 107.48, y: 476.88),
    Room(name: "228 Activities Center", startDist: 17.48, hall: 27, x: 130.76, y: 501.31),
    Room(name: "Concessions", startDist: 11.26, hall: 24, x: 144.36, y: 471.51),
    Room(name: "230 Student Activities Office", startDist: 15.67, hall: 31, x: 172.12, y: 471.51),
    Room(name: "232 The Nest", startDist: 8.22, hall: 34, x: 194.05, y: 464.3),
    Room(name: "234", startDist: 23.64, hall: 40, x: 122.49, y: 408.38),
    Room(name: "East Side Deli", startDist: 0.0, hall: 124, x: 111.46, y: 406.07),
    Room(name: "Prairie Grounds Coffee", startDist: 15.59, hall: 2, x: 74.92, y: 372.07),
    Room(name: "New American Grille", startDist: 6.54, hall: 3, x: 74.92, y: 394.2),
    Room(name: "236 ACE", startDist: 3.64, hall: 127, x: 148.88, y: 404.74),
    Room(name: "237 Media Center", startDist: 6.32, hall: 118, x: 171.53, y: 402.06),
    Room(name: "224", startDist: 0.01, hall: 11, x: 98.85, y: 394.21),
]

//  Intersection(halls: [], id: , x: , y: ),
var intersects2 = [
    Intersection(halls: [], id: 0, x: 41.93, y: 387.66),
    Intersection(halls: [], id: 1, x: 74.92, y: 387.66),
    Intersection(halls: [], id: 2, x: 74.92, y: 372.07),
    Intersection(halls: [], id: 3, x: 74.92, y: 394.20),
    Intersection(halls: [], id: 4, x: 98.85, y: 387.66),
    Intersection(halls: [], id: 5, x: 98.85, y: 355.17),
    Intersection(halls: [], id: 6, x: 103.43, y: 355.17),
    Intersection(halls: [], id: 7, x: 98.85, y: 374.24),
    Intersection(halls: [], id: 8, x: 93.51, y: 394.20),
    Intersection(halls: [], id: 9, x: 98.85, y: 394.20),
    Intersection(halls: [], id: 10, x: 98.85, y: 408.38),
    Intersection(halls: [], id: 11, x: 99.92, y: 431.63),
    Intersection(halls: [], id: 12, x: 95.78, y: 435.67),
    Intersection(halls: [], id: 13, x: 95.78, y: 471.51),
    Intersection(halls: [], id: 14, x: 113.94, y: 471.51),
    Intersection(halls: [], id: 15, x: 133.10, y: 471.51),
    Intersection(halls: [], id: 16, x: 156.45, y: 471.51),
    Intersection(halls: [], id: 17, x: 133.10, y: 462.50),
    Intersection(halls: [], id: 18, x: 156.45, y: 462.50),
    Intersection(halls: [], id: 19, x: 156.45, y: 458.51),
    Intersection(halls: [], id: 20, x: 208.26, y: 464.30),
    Intersection(halls: [], id: 21, x: 208.26, y: 408.38),
    Intersection(halls: [], id: 22, x: 208.26, y: 423.14),
    Intersection(halls: [], id: 23, x: 214.28, y: 423.14),
    Intersection(halls: [], id: 24, x: 218.39, y: 423.14),
    Intersection(halls: [], id: 25, x: 218.39, y: 408.38),
    Intersection(halls: [], id: 26, x: 243.41, y: 408.38),
    Intersection(halls: [], id: 27, x: 208.26, y: 403.65),
    Intersection(halls: [], id: 28, x: 203.69, y: 408.38),
    Intersection(halls: [], id: 29, x: 156.37, y: 408.38),
    Intersection(halls: [], id: 30, x: 156.37, y: 412.70),
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
    Intersection(halls: [], id: 46, x: 309.74, y: 360.28),
    Intersection(halls: [], id: 47, x: 339.57, y: 365.87),
    Intersection(halls: [], id: 48, x: 283.99, y: 360.28),
    Intersection(halls: [], id: 49, x: 283.99, y: 379.47),
    Intersection(halls: [], id: 50, x: 243.51, y: 379.47),
    Intersection(halls: [], id: 51, x: 243.51, y: 360.28),
    Intersection(halls: [], id: 52, x: 243.51, y: 403.65),
    Intersection(halls: [], id: 53, x: 243.51, y: 367.16),
    Intersection(halls: [], id: 54, x: 238.50, y: 360.28),
    Intersection(halls: [], id: 55, x: 235.61, y: 347.45),
    Intersection(halls: [], id: 56, x: 229.00, y: 348.19),
    Intersection(halls: [], id: 57, x: 229.00, y: 336.56),
    Intersection(halls: [], id: 58, x: 229.00, y: 343.74),
    Intersection(halls: [], id: 59, x: 223.05, y: 343.74),
    Intersection(halls: [], id: 60, x: 208.26, y: 343.74),
    Intersection(halls: [], id: 61, x: 206.92, y: 333.50),
    Intersection(halls: [], id: 62, x: 206.92, y: 303.78),
    Intersection(halls: [], id: 63, x: 196.07, y: 333.50),
    Intersection(halls: [], id: 64, x: 132.92, y: 408.38),
    Intersection(halls: [], id: 65, x: 132.92, y: 403.74),
    Intersection(halls: [], id: 66, x: 182.55, y: 332.04),
    Intersection(halls: [], id: 67, x: 196.07, y: 332.04),
    Intersection(halls: [], id: 68, x: 155.74, y: 332.97),
    Intersection(halls: [], id: 69, x: 141.87, y: 332.97),
    Intersection(halls: [], id: 70, x: 133.37, y: 332.97),
    Intersection(halls: [], id: 71, x: 141.87, y: 374.24),
    Intersection(halls: [], id: 72, x: 155.97, y: 374.24),
    Intersection(halls: [], id: 73, x: 261.19, y: 360.28),
    Intersection(halls: [], id: 74, x: 221.78, y: 354.5),
    Intersection(halls: [], id: 75, x: 36.27, y: 373.34),
    Intersection(halls: [], id: 76, x: 98.85, y: 407.48),
    Intersection(halls: [], id: 77, x: 93.83, y: 407.48),
    Intersection(halls: [], id: 78, x: 142.8, y: 488.64),
    Intersection(halls: [], id: 79, x: 130.76, y: 501.31),
    Intersection(halls: [], id: 80, x: 99.38, y: 471.51),
    Intersection(halls: [], id: 81, x: 95.78, y: 466.76),
    Intersection(halls: [], id: 82, x: 99.38, y: 466.76),
    Intersection(halls: [], id: 83, x: 269.25, y: 418.65),
    Intersection(halls: [], id: 84, x: 185.83, y: 471.51),
    Intersection(halls: [], id: 85, x: 185.83, y: 464.3),
    Intersection(halls: [], id: 86, x: 218.39, y: 429.47),
    Intersection(halls: [], id: 87, x: 280.92, y: 418.65),
    Intersection(halls: [], id: 88, x: 235.11, y: 357.38),
    Intersection(halls: [], id: 89, x: 206.92, y: 343.74),
    Intersection(halls: [], id: 90, x: 273.98, y: 425.48),
    Intersection(halls: [], id: 91, x: 269.25, y: 425.48),
    Intersection(halls: [], id: 92, x: 126.88, y: 408.38),
    Intersection(halls: [], id: 93, x: 126.88, y: 425.05),
    Intersection(halls: [], id: 94, x: 156.37, y: 415.08),
    Intersection(halls: [], id: 95, x: 171.53, y: 408.38),
    Intersection(halls: [], id: 96, x: 171.53, y: 402.06),
    Intersection(halls: [], id: 97, x: 107.48, y: 476.88),
    Intersection(halls: [], id: 98, x: 111.46, y: 406.07),
    Intersection(halls: [], id: 99, x: 111.46, y: 408.38),
    Intersection(halls: [], id: 100, x: 148.88, y: 408.38),
    Intersection(halls: [], id: 101, x: 148.88, y: 404.74),
    Intersection(halls: [], id: 102, x: 208.26, y: 429.47),
    Intersection(halls: [], id: 103, x: 72.65, y: 419.88),
    Intersection(halls: [], id: 104, x: 77.88, y: 418.13),
    Intersection(halls: [], id: 105, x: 82.46, y: 418.13),
    Intersection(halls: [], id: 106, x: 95.78, y: 418.13),
    Intersection(halls: [], id: 107, x: 82.46, y: 411.03),
    Intersection(halls: [], id: 108, x: 82.46, y: 394.20),
    Intersection(halls: [], id: 109, x: 150.90, y: 496.70),
    Intersection(halls: [], id: 110, x: 208.26, y: 473.36),
    Intersection(halls: [], id: 111, x: 393.12, y: 401.75),
    Intersection(halls: [], id: 112, x: 396.36, y: 425.92),
    Intersection(halls: [], id: 113, x: 389.22, y: 455.23),
]

// Hall(start: , end: , length: , id: ),
var halls2 = [
    Hall(start: 0, end: 1, length: 32.99, id: 0),
    Hall(start: 0, end: 75, length: 15.4, id: 1),
    Hall(start: 1, end: 2, length: 15.59, id: 2),
    Hall(start: 1, end: 3, length: 6.54, id: 3),
    Hall(start: 1, end: 4, length: 23.93, id: 4),
    Hall(start: 4, end: 7, length: 13.42, id: 5),
    Hall(start: 7, end: 5, length: 19.07, id: 6),
    Hall(start: 5, end: 6, length: 4.58, id: 7),
    Hall(start: 3, end: 8, length: 18.59, id: 8),
    Hall(start: 4, end: 9, length: 6.54, id: 9),
    Hall(start: 8, end: 9, length: 5.34, id: 10),
    Hall(start: 9, end: 76, length: 13.28, id: 11),
    Hall(start: 76, end: 10, length: 0.9, id: 12),
    Hall(start: 76, end: 77, length: 5.02, id: 13),
    Hall(start: 10, end: 11, length: 23.27, id: 14),
    Hall(start: 11, end: 12, length: 5.78, id: 15),
    Hall(start: 12, end: 81, length: 31.09, id: 16),
    Hall(start: 81, end: 82, length: 3.6, id: 17),
    Hall(start: 81, end: 13, length: 4.75, id: 18),
    Hall(start: 13, end: 80, length: 3.6, id: 19),
    Hall(start: 80, end: 82, length: 4.75, id: 20),
    Hall(start: 80, end: 14, length: 14.56, id: 21),
    Hall(start: 14, end: 15, length: 19.16, id: 22),
    Hall(start: 15, end: 17, length: 9.01, id: 23),
    Hall(start: 15, end: 16, length: 23.35, id: 24),
    Hall(start: 16, end: 78, length: 21.9, id: 25),
    Hall(start: 15, end: 78, length: 19.69, id: 26),
    Hall(start: 78, end: 79, length: 17.48, id: 27),
    Hall(start: 17, end: 18, length: 23.35, id: 28),
    Hall(start: 16, end: 18, length: 9.01, id: 29),
    Hall(start: 18, end: 19, length: 3.99, id: 30),
    Hall(start: 16, end: 84, length: 29.38, id: 31),
    Hall(start: 18, end: 85, length: 29.44, id: 32),
    Hall(start: 84, end: 85, length: 7.21, id: 33),
    Hall(start: 85, end: 20, length: 22.43, id: 34),
    Hall(start: 20, end: 22, length: 41.16, id: 35),
    Hall(start: 22, end: 23, length: 6.02, id: 36),
    Hall(start: 23, end: 24, length: 4.11, id: 37),
    Hall(start: 24, end: 86, length: 6.33, id: 38),
    Hall(start: 21, end: 22, length: 14.76, id: 39),
    Hall(start: 10, end: 64, length: 34.07, id: 40),
    Hall(start: 64, end: 65, length: 4.64, id: 41),
    Hall(start: 64, end: 29, length: 23.45, id: 42),
    Hall(start: 29, end: 30, length: 4.32, id: 43),
    Hall(start: 29, end: 28, length: 47.32, id: 44),
    Hall(start: 28, end: 32, length: 7.49, id: 45),
    Hall(start: 28, end: 21, length: 4.57, id: 46),
    Hall(start: 21, end: 25, length: 10.13, id: 47),
    Hall(start: 24, end: 25, length: 14.76, id: 48),
    Hall(start: 25, end: 26, length: 25.02, id: 49),
    Hall(start: 21, end: 27, length: 4.73, id: 50),
    Hall(start: 27, end: 52, length: 35.25, id: 51),
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
    Hall(start: 38, end: 40, length: 40.42, id: 62),
    Hall(start: 31, end: 39, length: 15.67, id: 63),
    Hall(start: 39, end: 40, length: 15.48, id: 64),
    Hall(start: 40, end: 41, length: 69.55, id: 65),
    Hall(start: 39, end: 42, length: 18.83, id: 66),
    Hall(start: 42, end: 43, length: 3.24, id: 67),
    Hall(start: 43, end: 44, length: 17.05, id: 68),
    Hall(start: 44, end: 45, length: 4.03, id: 69),
    Hall(start: 46, end: 44, length: 6.16, id: 70),
    Hall(start: 46, end: 45, length: 8.66, id: 71),
    Hall(start: 45, end: 47, length: 23.22, id: 72),
    Hall(start: 46, end: 48, length: 25.75, id: 73),
    Hall(start: 48, end: 49, length: 19.19, id: 74),
    Hall(start: 49, end: 50, length: 40.48, id: 75),
    Hall(start: 50, end: 52, length: 24.18, id: 76),
    Hall(start: 50, end: 53, length: 12.31, id: 77),
    Hall(start: 48, end: 73, length: 22.8, id: 78),
    Hall(start: 73, end: 51, length: 17.68, id: 79),
    Hall(start: 51, end: 53, length: 6.88, id: 80),
    Hall(start: 51, end: 54, length: 5.01, id: 81),
    Hall(start: 54, end: 53, length: 8.51, id: 82),
    Hall(start: 54, end: 88, length: 4.46, id: 83),
    Hall(start: 88, end: 55, length: 9.94, id: 84),
    Hall(start: 55, end: 56, length: 6.65, id: 85),
    Hall(start: 88, end: 56, length: 11.04, id: 86),
    Hall(start: 56, end: 58, length: 4.45, id: 87),
    Hall(start: 58, end: 57, length: 7.18, id: 88),
    Hall(start: 58, end: 59, length: 5.95, id: 89),
    Hall(start: 59, end: 56, length: 7.43, id: 90),
    Hall(start: 56, end: 74, length: 9.59, id: 91),
    Hall(start: 59, end: 60, length: 14.79, id: 92),
    Hall(start: 61, end: 89, length: 10.24, id: 93),
    Hall(start: 61, end: 62, length: 29.72, id: 94),
    Hall(start: 61, end: 63, length: 10.85, id: 95),
    Hall(start: 89, end: 60, length: 1.34, id: 96),
    Hall(start: 67, end: 66, length: 13.52, id: 97),
    Hall(start: 66, end: 68, length: 26.83, id: 98),
    Hall(start: 68, end: 69, length: 13.87, id: 99),
    Hall(start: 69, end: 70, length: 8.5, id: 100),
    Hall(start: 7, end: 71, length: 43.02, id: 101),
    Hall(start: 69, end: 71, length: 41.27, id: 102),
    Hall(start: 71, end: 72, length: 14.1, id: 103),
    Hall(start: 63, end: 67, length: 1.46, id: 104),
    Hall(start: 59, end: 54, length: 22.63, id: 105),
    Hall(start: 56, end: 54, length: 15.38, id: 106),
    Hall(start: 27, end: 60, length: 59.91, id: 107),
    Hall(start: 59, end: 53, length: 31.1, id: 108),
    Hall(start: 83, end: 91, length: 6.83, id: 109),
    Hall(start: 34, end: 91, length: 16.69, id: 110),
    Hall(start: 90, end: 91, length: 4.73, id: 111),
    Hall(start: 10, end: 92, length: 28.03, id: 112),
    Hall(start: 64, end: 92, length: 6.04, id: 113),
    Hall(start: 92, end: 93, length: 16.67, id: 114),
    Hall(start: 30, end: 94, length: 2.38, id: 115),
    Hall(start: 29, end: 95, length: 15.16, id: 116),
    Hall(start: 28, end: 95, length: 32.16, id: 117),
    Hall(start: 95, end: 96, length: 6.32, id: 118),
    Hall(start: 14, end: 97, length: 8.4, id: 119),
    Hall(start: 80, end: 97, length: 9.72, id: 120),
    Hall(start: 16, end: 79, length: 39.34, id: 121),
    Hall(start: 10, end: 99, length: 12.61, id: 122),
    Hall(start: 92, end: 99, length: 15.42, id: 123),
    Hall(start: 98, end: 99, length: 2.31, id: 124),
    Hall(start: 64, end: 100, length: 16.37, id: 125),
    Hall(start: 29, end: 100, length: 8.33, id: 126),
    Hall(start: 100, end: 101, length: 3.64, id: 127),
    Hall(start: 22, end: 102, length: 6.33, id: 128),
    Hall(start: 20, end: 102, length: 34.83, id: 129),
    Hall(start: 86, end: 102, length: 10.13, id: 130),
    Hall(start: 103, end: 104, length: 5.52, id: 131),
    Hall(start: 104, end: 105, length: 4.58, id: 132),
    Hall(start: 105, end: 106, length: 13.32, id: 133),
    Hall(start: 12, end: 106, length: 17.54, id: 134),
    Hall(start: 10, end: 106, length: 10.22, id: 135),
    Hall(start: 105, end: 107, length: 7.1, id: 136),
    Hall(start: 77, end: 107, length: 11.91, id: 137),
    Hall(start: 107, end: 108, length: 16.83, id: 138),
    Hall(start: 3, end: 108, length: 7.54, id: 139),
    Hall(start: 8, end: 108, length: 11.05, id: 140),
    Hall(start: 78, end: 109, length: 11.43, id: 141),
    Hall(start: 20, end: 110, length: 9.06, id: 142),
    Hall(start: 111, end: 112, length: 24.39, id: 143),
    Hall(start: 112, end: 113, length: 30.17, id: 144),
    Hall(start: 40, end: 111, length: 62.08, id: 145),
    Hall(start: 41, end: 111, length: 7.47, id: 146),
]
// Room(name: "", startDist: , hall: , x: , y: ),
var rooms3 = [
    Room(name: "313 Math Resource Center (MRC)", startDist: 5.43, hall: 1, x: 86.51, y: 384.78),
    Room(name: "314", startDist: 9.66, hall: 0, x: 48.14, y: 390.21),
    Room(name: "315", startDist: 0.0, hall: 0, x: 38.48, y: 390.21),
    Room(name: "316", startDist: 0.0, hall: 0, x: 38.48, y: 390.21),
    Room(name: "317", startDist: 6.01, hall: 0, x: 44.49, y: 390.21),
    Room(name: "318", startDist: 9.66, hall: 0, x: 48.14, y: 390.21),
    Room(name: "319", startDist: 28.65, hall: 0, x: 67.13, y: 390.21),
    Room(name: "320", startDist: 33.04, hall: 0, x: 71.52, y: 390.21),
    Room(name: "320", startDist: 33.04, hall: 0, x: 71.52, y: 390.21),
    Room(name: "312", startDist: 6.04, hall: 10, x: 107.1, y: 376.19),
    Room(name: "323", startDist: 6.04, hall: 10, x: 107.1, y: 376.19),
    Room(name: "311", startDist: 21.12, hall: 10, x: 122.18, y: 376.19),
    Room(name: "324", startDist: 33.39, hall: 10, x: 134.45, y: 376.19),
    Room(name: "310", startDist: 17.28, hall: 11, x: 143.08, y: 358.91),
    Room(name: "306", startDist: 18.31, hall: 11, x: 143.08, y: 357.88),
    Room(name: "309", startDist: 36.03, hall: 11, x: 143.08, y: 340.16),
    Room(name: "307", startDist: 36.97, hall: 11, x: 143.08, y: 339.22),
    Room(name: "308", startDist: 40.19, hall: 11, x: 143.08, y: 336),
    Room(name: "322", startDist: 6.55, hall: 7, x: 101.06, y: 396.76),
    Room(name: "321", startDist: 22.24, hall: 8, x: 123.3, y: 411.59),
    Room(name: "305", startDist: 7.19, hall: 14, x: 167.94, y: 376.19),
    Room(name: "325", startDist: 3.16, hall: 25, x: 160.75, y: 379.35),
    Room(name: "326", startDist: 14.9, hall: 25, x: 160.75, y: 391.09),
    Room(name: "327", startDist: 26.3, hall: 25, x: 160.75, y: 402.49),
    Room(name: "328 World Language Dept", startDist: 14.51, hall: 14, x: 175.26, y: 376.19),
    Room(name: "304", startDist: 11.39, hall: 15, x: 195.7, y: 364.8),
    Room(name: "303", startDist: 22.45, hall: 15, x: 195.7, y: 353.74),
    Room(name: "302", startDist: 31.07, hall: 15, x: 195.7, y: 345.12),
    Room(name: "301", startDist: 31.07, hall: 15, x: 195.7, y: 345.12),
    Room(name: "300A", startDist: 15.67, hall: 32, x: 206.76, y: 330.06),
    Room(name: "300", startDist: 12.65, hall: 34, x: 206.76, y: 315.2),
    Room(name: "349", startDist: 3.61, hall: 33, x: 210.37, y: 327.85),
    Room(name: "348", startDist: 19.9, hall: 17, x: 226.66, y: 345.73),
    Room(name: "329", startDist: 10.9, hall: 17, x: 217.66, y: 345.73),
    Room(name: "347", startDist: 31.43, hall: 17, x: 238.19, y: 345.73),
    Room(name: "346", startDist: 4.83, hall: 18, x: 238.19, y: 350.56),
    Room(name: "330", startDist: 8.43, hall: 19, x: 238.19, y: 371.31),
    Room(name: "331", startDist: 10.86, hall: 19, x: 238.19, y: 373.74),
    Room(name: "332", startDist: 12.06, hall: 30, x: 238.19, y: 394.27),
    Room(name: "345", startDist: 12.12, hall: 24, x: 250.31, y: 362.88),
    Room(name: "333", startDist: 13.21, hall: 21, x: 251.4, y: 382.21),
    Room(name: "334", startDist: 13.21, hall: 21, x: 251.4, y: 382.21),
    Room(name: "344 Science Resource Center (SRC)", startDist: 14.21, hall: 21, x: 252.4, y: 382.21),
    Room(name: "335", startDist: 25.67, hall: 21, x: 263.86, y: 382.21),
    Room(name: "335A", startDist: 27.98, hall: 21, x: 266.17, y: 382.21),
    Room(name: "343", startDist: 12.12, hall: 26, x: 284.8, y: 370.38),
    Room(name: "342", startDist: 23.95, hall: 26, x: 296.63, y: 370.38),
    Room(name: "341", startDist: 26.29, hall: 26, x: 298.97, y: 370.38),
    Room(name: "336", startDist: 18.47, hall: 26, x: 291.15, y: 370.38),
    Room(name: "340", startDist: 0.0, hall: 28, x: 310.56, y: 368.41),
    Room(name: "339", startDist: 11.68, hall: 28, x: 322.24, y: 368.41),
    Room(name: "337", startDist: 9.75, hall: 28, x: 320.31, y: 368.41),
    Room(name: "338", startDist: 26.95, hall: 28, x: 337.51, y: 368.41),
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
    Intersection(halls: [], id: 12, x: 157.17, y: 376.19),
    Intersection(halls: [], id: 13, x: 160.75, y: 376.19),
    Intersection(halls: [], id: 14, x: 143.08, y: 336),
    Intersection(halls: [], id: 15, x: 134.48, y: 336),
    Intersection(halls: [], id: 16, x: 195.7, y: 376.19),
    Intersection(halls: [], id: 17, x: 160.75, y: 415.55),
    Intersection(halls: [], id: 18, x: 195.7, y: 345.73),
    Intersection(halls: [], id: 19, x: 206.76, y: 345.73),
    Intersection(halls: [], id: 20, x: 238.19, y: 345.73),
    Intersection(halls: [], id: 21, x: 238.19, y: 362.88),
    Intersection(halls: [], id: 22, x: 238.19, y: 382.21),
    Intersection(halls: [], id: 23, x: 238.19, y: 397.05),
    Intersection(halls: [], id: 24, x: 206.60, y: 397.05),
    Intersection(halls: [], id: 25, x: 206.60, y: 402.65),
    Intersection(halls: [], id: 26, x: 272.68, y: 362.88),
    Intersection(halls: [], id: 27, x: 272.68, y: 370.38),
    Intersection(halls: [], id: 28, x: 272.68, y: 381.9),
    Intersection(halls: [], id: 29, x: 307.76, y: 370.38),
    Intersection(halls: [], id: 30, x: 310.56, y: 368.41),
    Intersection(halls: [], id: 31, x: 337.507, y: 368.41),
    Intersection(halls: [], id: 32, x: 206.76, y: 327.85),
    Intersection(halls: [], id: 33, x: 210.37, y: 327.85),
    Intersection(halls: [], id: 34, x: 206.76, y: 315.2),
    Intersection(halls: [], id: 35, x: 260.25, y: 362.88),
    Intersection(halls: [], id: 36, x: 38.48, y: 378.47),
]

//  Hall(start: , end: , length: , id: ),
var halls3 = [
    Hall(start: 0, end: 1, length: 48.03, id: 0),
    Hall(start: 1, end: 2, length: 5.43, id: 1),
    Hall(start: 1, end: 3, length: 10.0, id: 2),
    Hall(start: 3, end: 4, length: 4.55, id: 3),
    Hall(start: 4, end: 5, length: 14.02, id: 4),
    Hall(start: 5, end: 6, length: 19.14, id: 5),
    Hall(start: 6, end: 7, length: 4.42, id: 6),
    Hall(start: 4, end: 8, length: 21.38, id: 7),
    Hall(start: 8, end: 9, length: 34.45, id: 8),
    Hall(start: 9, end: 10, length: 5.76, id: 9),
    Hall(start: 5, end: 11, length: 42.02, id: 10),
    Hall(start: 11, end: 14, length: 40.19, id: 11),
    Hall(start: 14, end: 15, length: 8.6, id: 12),
    Hall(start: 11, end: 12, length: 14.09, id: 13),
    Hall(start: 13, end: 16, length: 34.95, id: 14),
    Hall(start: 16, end: 18, length: 30.46, id: 15),
    Hall(start: 18, end: 19, length: 11.06, id: 16),
    Hall(start: 19, end: 20, length: 31.43, id: 17),
    Hall(start: 20, end: 21, length: 17.15, id: 18),
    Hall(start: 21, end: 22, length: 19.33, id: 19),
    Hall(start: 23, end: 24, length: 28.17, id: 20),
    Hall(start: 22, end: 28, length: 34.49, id: 21),
    Hall(start: 27, end: 28, length: 11.52, id: 22),
    Hall(start: 26, end: 27, length: 7.5, id: 23),
    Hall(start: 21, end: 35, length: 22.06, id: 24),
    Hall(start: 13, end: 17, length: 39.36, id: 25),
    Hall(start: 27, end: 29, length: 35.08, id: 26),
    Hall(start: 29, end: 30, length: 3.42, id: 27),
    Hall(start: 30, end: 31, length: 26.95, id: 28),
    Hall(start: 24, end: 25, length: 5.6, id: 29),
    Hall(start: 22, end: 23, length: 14.84, id: 30),
    Hall(start: 12, end: 13, length: 3.58, id: 31),
    Hall(start: 19, end: 32, length: 17.88, id: 32),
    Hall(start: 32, end: 33, length: 3.61, id: 33),
    Hall(start: 32, end: 34, length: 12.65, id: 34),
    Hall(start: 26, end: 35, length: 12.43, id: 35),
    Hall(start: 0, end: 36, length: 11.74, id: 36),

]

var floor1 = Floor(halls: halls, inters: intersects, rooms: rooms)
var floor2 = Floor(halls: halls2, inters: intersects2, rooms: rooms2)
var floor3 = Floor(halls: halls3, inters: intersects3, rooms: rooms3)

var floors = [floor1, floor2, floor3]

//  Stair(name: "", dist: [], x: [], y: [], allFloors: true, inters: [floor1.inters[], floor2.inters[], floor3.inters[]], id: )
var stairs = [
    Stair(name: "SW 5", dist: [14.99, 7.38, 7.11], x: [100.20, 103.43, 105.48], y: [349.50, 347.79, 349.94], allFloors: true, inters: [floor1.inters[1], floor2.inters[6], floor3.inters[7]], id: 0),
    Stair(name: "SW 17", dist: [5.26, 4.963, 7.11], x: [262.34, 261.19, 260.25], y: [356.04, 355.26, 358.1], allFloors: true, inters: [floor1.inters[49], floor2.inters[73], floor3.inters[35]], id: 1),
    Stair(name: "SW 4", dist: [5.11, 5.11, 5.11], x: [129.25, 133.37, 134.48], y: [328.88, 328.88, 328.88], allFloors: true, inters: [floor1.inters[50], floor2.inters[70], floor3.inters[15]], id: 2),
    Stair(name: "SW 1", dist: [0, 4, 11.25], x: [207.82, 207.35, 206.76], y: [307.32, 299.25, 304.24], allFloors: true, inters: [floor1.inters[34], floor2.inters[62], floor3.inters[34]], id: 3),
    Stair(name: "SW 6 (3)", dist: [5.8, 4.45, 11.25], x: [95.54, 93.51, 96.51], y: [410.12, 400.49, 400.3], allFloors: true, inters: [floor1.inters[10], floor2.inters[77], floor3.inters[3]], id: 4),
    Stair(name: "SW 6 (1)", dist: [5.8, 4.45, 6.36], x: [95.54, 93.51, 96.51], y: [410.12, 400.49, 400.3], allFloors: true, inters: [floor1.inters[10], floor2.inters[8], floor3.inters[3]], id: 5),
    Stair(name: "SW 7", dist: [10.47, 5.79, 3.71], x: [30.97, 28.82, 33.52], y: [373.73, 373.34, 378.47], allFloors: true, inters: [floor1.inters[52], floor2.inters[75], floor3.inters[36]], id: 6),
    Stair(name: "SW 3", dist: [2.55, 2.93, 2.80], x: [154.05, 155.97, 157.17], y: [371.78, 371.25, 372.83], allFloors: true, inters: [floor1.inters[16], floor2.inters[72], floor3.inters[12]], id: 7),
    Stair(name: "SW 15", dist: [1.84, 1.56, 4.68], x: [202.77, 201.71, 201.99], y: [401.40, 400.89, 402.65], allFloors: true, inters: [floor1.inters[56], floor2.inters[32], floor3.inters[25]], id: 8),
    Stair(name: "SW 16", dist: [3.17, 2.26, 0], x: [215.61, 214.28, 0], y: [414.73, 415.88, 0], allFloors: false, inters: [floor1.inters[46], floor2.inters[23], floor3.inters[0]], id: 9),
    Stair(name: "SW 18", dist: [3.21, 3.21, 3.21], x: [336.32, 339.57, 337.507], y: [361.03, 360.78, 363.08], allFloors: true, inters: [floor1.inters[57], floor2.inters[47], floor3.inters[31]], id: 10),
    Stair(name: "SW 13", dist: [1.47, 4.01, 9.26], x: [150.56, 149.16, 150.53], y: [415.73, 412.70, 415.55], allFloors: true, inters: [floor1.inters[59], floor2.inters[30], floor3.inters[17]], id: 11),
    Stair(name: "SW 14", dist: [3.40, 3.24, 2.96], x: [128.44, 127.29, 128.60], y: [400.93, 403.74, 405.83], allFloors: true, inters: [floor1.inters[54], floor2.inters[65], floor3.inters[10]], id: 12),
    Stair(name: "SW 12", dist: [2.31, 3.18, 0], x: [152.37, 150.00, 0], y: [456.30, 458.51, 0], allFloors: false, inters: [floor1.inters[15], floor2.inters[19], floor3.inters[0]], id: 13),
    Stair(name: "SW 8", dist: [4.18, 2.84, 0], x: [100.2, 99.38, 0], y: [459.88, 462.77, 0], allFloors: false, inters: [floor1.inters[13], floor2.inters[82], floor3.inters[0]], id: 14),
    Stair(name: "SW 2", dist: [3.61, 0, 0], x: [221.53, 220.78, 0], y: [350.56, 350.09, 0], allFloors: false, inters: [floor1.inters[29], floor2.inters[74], floor3.inters[0]], id: 15),

]

