//
//  Map.swift
//  Find My EP
//
//  Created by 64000774 on 2/14/22.
//

import SwiftUI

struct DirectionsScreen: View {
    
    var stuff: (Double, [Int])
    var start: Int
    var end: Int
    @State var first = true
    @State var second = false
    @State var third = false
    
    var body: some View {
        let map1 = Map(inters: stuff.1, start: start, end: end)
        let map2 = Map(inters: stuff.1, start: end, end: end)
        let map3 = Map(inters: stuff.1, start: end, end: start)
        VStack(alignment: .leading) {
            if first {
                map1
            } else if second {
                map2
            } else {
                map3
            }
            Text("Time: " + to_min(seconds: stuff.0*0.64))
                .frame(maxWidth: .infinity, alignment: .center)
            HStack {
                Button(action: {
                    first = true
                    second = false
                    third = false
                }, label: {
                    Text("1")
                })
                Button(action: {
                    first = false
                    second = true
                    third = false
                }, label: {
                    Text("2")
                })
                Button(action: {
                    first = false
                    second = false
                    third = true
                }, label: {
                    Text("3")
                })
            }
            
        }
    }
    
    func to_min(seconds: Double) -> String {
        let time = Int(seconds)
        let min = time/60
        let sec = time % 60 * 60 / 100
        return "Approximate Time: \(min) Minutes and \(sec) Seconds"
    }
    
    func list_to_string(lst: [Int]) -> String {
        var str = "Intersections: "
        for num in lst {
            str.append(String(num) + ", ")
        }
        return str
    }
    
    //    struct DirectionsScreen_Previews: PreviewProvider {
    //        static var previews: some View {
    //            DirectionsScreen(stuff: school.findPath(start: rooms[0], end: rooms[3]), start: 0, end: 3)
    //        }
    //    }
}
