//
//  Map.swift
//  Find My EP
//
//  Created by 64000774 on 2/23/22.
//

import SwiftUI

var screenSize: CGRect = UIScreen.main.bounds
var screenWidth = screenSize.width
var screenHeight = screenSize.height

struct Map: View {
    var inters: [Int]
    var start: Int
    var end: Int
    @State var scale: CGFloat = 1.0
    @State var factor: CGFloat = 1.0
    @State private var percentage: CGFloat = .zero
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
                path.move(to: CGPoint(x: CGFloat(rooms[start].x)/414.0*screenWidth, y: (CGFloat(rooms[start].y-212)/896.0*screenHeight)))
                for i in 0...inters.count-1 {
                    path.addLine(to: CGPoint(x: CGFloat(intersects[inters[i]].x)/414.0*screenWidth, y: CGFloat(intersects[inters[i]].y-212)/896.0*screenHeight))
                    path.move(to: CGPoint(x: CGFloat(intersects[inters[i]].x)/414.0*screenWidth, y: CGFloat(intersects[inters[i]].y-212)/896.0*screenHeight))
                }
                path.addLine(to: CGPoint(x: CGFloat(rooms[end].x)/414.0*screenWidth, y: CGFloat(rooms[end].y-212)/896.0*screenHeight))
                
            }
            .trim(from: 0, to: percentage)
            .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .animation(.easeInOut(duration: 4))
            .onAppear {
                withAnimation(.linear(duration: 4)) {
                    self.percentage = 1.0
                }
            }
//            Text("Screen width = \(screenWidth), screen height = \(screenHeight)")
//                .background(Color.white)
        }
        .scaleEffect(scale)
        .gesture(magnification)
        .aspectRatio(contentMode: .fit)
    }
    
}


