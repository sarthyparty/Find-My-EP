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
    @State var scale: CGFloat = 0.5
    @State var factor: CGFloat = 1.0
    @State private var percentage: CGFloat = .zero
    @State var translation = 0
    @State private var actualOffset = CGSize.zero
    @State private var offset = CGSize.zero
    @State private var prevOffset = CGSize.zero
    
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
        let _ = DragGesture(minimumDistance: 0).onChanged { value in
            dragLocation = value.location
        }.sequenced(before: tap)
        ZoomableScrollView {
            ZStack {
                Image("Map_GPS")
                    .resizable()
                    .background(Color.white)
                Path { path in
                    path.move(to: CGPoint(x: CGFloat(rooms[start].x)/414.0*screenWidth, y: (CGFloat(rooms[start].y-212)/896.0*screenHeight)))
                    if inters.count > 0 {
                        for i in 0...inters.count-1 {
                            path.addLine(to: CGPoint(x: CGFloat(intersects[inters[i]].x)/414.0*screenWidth, y: CGFloat(intersects[inters[i]].y-212)/896.0*screenHeight))
                            path.move(to: CGPoint(x: CGFloat(intersects[inters[i]].x)/414.0*screenWidth, y: CGFloat(intersects[inters[i]].y-212)/896.0*screenHeight))
                        }
                    }
                    path.addLine(to: CGPoint(x: CGFloat(rooms[end].x)/414.0*screenWidth, y: CGFloat(rooms[end].y-212)/896.0*screenHeight))
                    
                }
                .trim(from: 0, to: percentage)
                .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .animation(Animation.easeInOut(duration: 1.0), value: percentage)
                .onAppear(perform: {
                    withAnimation(.easeIn(duration: 2)) {
                        self.percentage = 1
                    }
                })
                
                //            Text("Screen width = \(screenWidth), screen height = \(screenHeight)")
                //                .background(Color.white)
            }
            
            
            .aspectRatio(contentMode: .fit)
        }
        
        
        //        .offset(x: offset.width, y: offset.height)
        //        .simultaneousGesture(
        //            DragGesture()
        //                .onChanged { gesture in
        //                    offset = CGSize(width: gesture.translation.width + prevOffset.width, height: gesture.translation.height + prevOffset.height)
        //                    actualOffset = CGSize(width: offset.width / self.scale, height: offset.height / self.scale)
        //                }
        //                .onEnded { _ in
        //                    prevOffset = offset
        //                }
        //        )
        //                .simultaneousGesture(
        //                    MagnificationGesture()
        //                        .onChanged() { value in
        //                            if value.magnitude * self.factor < 1 {
        //                                self.scale = 1
        //
        //                            } else {
        //                                let temp = value.magnitude * self.factor
        //                                let new_off = CGSize(width: actualOffset.width * self.scale, height: actualOffset.height * self.scale)
        //                                self.offset = new_off
        //                                self.scale = temp
        //                            }
        //                        }
        //                        .onEnded { value in
        //                            factor = scale
        //                            prevOffset = offset
        //                        }
        //                )
        //        .zoomable(scale: $scale, offset: $offset)
        
        
    }
    
}




