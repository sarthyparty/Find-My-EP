//
//  Map.swift
//  Find My EP
//
//  Created by 64000774 on 2/23/22.
//

import SwiftUI

struct Map: View {
    var inters: [Int]
    var start: Int
    var end: Int
    @State var scale: CGFloat = 1.5
    @State var factor: CGFloat = 1.5
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged() { value in
                if value.magnitude * self.factor < 1 {
                    self.scale = 1
                    
                } else {
                    self.scale = value.magnitude * self.factor
                }
            }
            .onEnded { value in
                factor = scale
            }
    }
    
    @State var tapLocation: CGPoint?
    
    @State var dragLocation: CGPoint?
    
    var locString : String {
        guard let loc = tapLocation else { return "Tap" }
        return "\(Int(loc.x)), \(Int(loc.y))"
    }
    
    var body: some View {
        let tap = TapGesture().onEnded { tapLocation = dragLocation }
        let drag = DragGesture(minimumDistance: 0).onChanged { value in
            dragLocation = value.location
        }.sequenced(before: tap)
        return ZStack {
            Image("Map_GPS")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.white)
            Path { path in
                path.move(to: CGPoint(x: rooms[start].x-25, y: rooms[start].y-100))
                for i in 0...inters.count-1 {
                    path.addLine(to: CGPoint(x: intersects[inters[i]].x-25, y: intersects[inters[i]].y-100))
                    path.move(to: CGPoint(x: intersects[inters[i]].x-25, y: intersects[inters[i]].y-100))
                }
                path.addLine(to: CGPoint(x: rooms[end].x-25, y: rooms[end].y-100))
                
            }
            .stroke(.blue, lineWidth: 5)
            Text(locString)
                .background(Color.white)
        }
        .scaleEffect(scale)
        .gesture(magnification)
    }
    
}
