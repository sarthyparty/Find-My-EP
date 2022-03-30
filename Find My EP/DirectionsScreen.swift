//
//  Map.swift
//  Find My EP
//
//  Created by 64000774 on 2/14/22.
//

import SwiftUI

struct DirectionsScreen: View {
    
    var stuff: (Double, [Hall], [Int])
    var start: Int
    var end: Int
    
    
    var body: some View {
        return VStack(alignment: .leading) {
            Map(inters: stuff.2, start: start, end: end)
            Text("Time: " + to_min(seconds: stuff.0*0.64))
                .frame(maxWidth: .infinity, alignment: .center)
            
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
