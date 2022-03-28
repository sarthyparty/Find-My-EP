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
            Text("Distance: " + String(stuff.0))
                .frame(maxWidth: .infinity, alignment: .center)
            Text(list_to_string(lst: stuff.2))
                .frame(maxWidth: .infinity, alignment: .center)
            
        }
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
