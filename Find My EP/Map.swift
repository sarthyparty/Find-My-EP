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
    @State var scale: CGFloat = 5.0
    @State private var percentage: CGFloat = .zero
    @State private var offset: CGPoint = .zero
    
    @State var dragLocation: CGPoint?
    
    
    
    var body: some View {
        let map = ZStack {
            if scale > 4 {
                Image("EPHS")
                    .resizable()
                    .background(Color.white)
            } else {
                Image("EPHS_low")
                    .resizable()
                    .background(Color.white)
            }
            
            Path { path in
                path.move(to: CGPoint(x: CGFloat(rooms[start].x/428*screenWidth), y: (CGFloat((rooms[start].y-314)/926*screenHeight))))
                if inters.count > 0 {
                    for i in 0...inters.count-1 {
                        path.addLine(to: CGPoint(x: CGFloat(intersects[inters[i]].x/428*screenWidth), y: CGFloat((intersects[inters[i]].y-314)/926*screenHeight)))
                        path.move(to: CGPoint(x: CGFloat(intersects[inters[i]].x/428*screenWidth), y: CGFloat((intersects[inters[i]].y-314)/926*screenHeight)))
                    }
                }
                path.addLine(to: CGPoint(x: CGFloat(rooms[end].x/428*screenWidth), y: CGFloat((rooms[end].y-314)/926*screenHeight)))
                
            }
            .trim(from: 0, to: percentage)
            .stroke(.blue, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
            .animation(Animation.easeInOut(duration: 1.0), value: percentage)
            .onAppear(perform: {
                withAnimation(.easeIn(duration: 2)) {
                    self.percentage = 1
                }
            })
            
        }
        .aspectRatio(contentMode: .fit)
        ZoomableScrollView(content: map, currentScale: $scale, currentOffset: $offset, start: CGPoint(x: rooms[start].x, y: rooms[start].y))
        
        
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




