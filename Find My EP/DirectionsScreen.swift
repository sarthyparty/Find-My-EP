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
            HStack(alignment: .center, spacing: 0 ) {
                Spacer()
                ColorButton(text: "1", tochange: $first, other1: $second, other2: $third)
                ColorButton(text: "2", tochange: $second, other1: $first, other2: $third)
                ColorButton(text: "3", tochange: $third, other1: $second, other2: $first)
                Spacer()
                
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
    
    struct ColorButton: View {
        var text: String
        @Binding var tochange: Bool
        @Binding var other1: Bool
        @Binding var other2: Bool
        var body: some View {
            Button(action: {
                tochange = true
                other1 = false
                other2 = false
            }, label: {
                Text(text) .bold().font(.system(size: 30))
                    .padding(10)
                    .foregroundColor(tochange ? Color.red : Color.black)
                //                    .background(tochange ? Color.green : Color.red)
                //                    .border(Color.black, width: 0.50)
                //                    .cornerRadius(20)
                
                
            })
        }
    }
}


