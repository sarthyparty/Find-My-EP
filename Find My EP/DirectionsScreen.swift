//
//  Map.swift
//  Find My EP
//
//  Created by 64000774 on 2/14/22.
//

import SwiftUI

struct DirectionsScreen: View {
    
    @State var retval: (Double, [Int], [Int], [Int], [CGPoint], [CGPoint], [Bool])
    
    var body: some View {
        let map1 = Map(floor: floors[0], inters: retval.1, start: retval.4[0], end: retval.5[0], mapImageHigh: "EPHS_first_high", mapImageLow: "EPHS_first_low")
        let map2 = Map(floor: floors[1], inters: retval.2, start: retval.4[1], end: retval.5[1], mapImageHigh: "EPHS_second_high", mapImageLow: "EPHS_second_low")
        let map3 = Map(floor: floors[2], inters: retval.3, start: retval.4[2], end: retval.5[2], mapImageHigh: "EPHS_third_high", mapImageLow: "EPHS_third_low")
        VStack(alignment: .leading) {
            if retval.6[0] {
                map1
            } else if retval.6[1] {
                map2
            } else {
                map3
            }
            Text(to_min(seconds: retval.0*0.72))
                .frame(maxWidth: .infinity, alignment: .center)
            HStack(alignment: .center, spacing: 0 ) {
                Spacer()
                ColorButton(text: "1", tochange: $retval.6[0], other1: $retval.6[1], other2: $retval.6[2])
                    .disabled(retval.1.isEmpty)
                ColorButton(text: "2", tochange: $retval.6[1], other1: $retval.6[0], other2: $retval.6[2])
                    .disabled(retval.2.isEmpty)
                ColorButton(text: "3", tochange: $retval.6[2], other1: $retval.6[1], other2: $retval.6[0])
                    .disabled(retval.3.isEmpty)
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


