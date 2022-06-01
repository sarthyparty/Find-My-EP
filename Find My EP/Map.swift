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
    var floor: Floor
    var inters: [Int]
    var start: CGPoint
    var end: CGPoint
    var mapImageHigh: String
    var mapImageLow: String
    @State var scale: CGFloat = 5.0
    @State private var percentage: CGFloat = .zero
    @State private var offset: CGPoint = .zero
    
    
    @State var dragLocation: CGPoint?
    
    func fixX(x: Double) -> CGFloat {
        return CGFloat(x/428*screenWidth)
    }
    
    func fixY(y: Double) -> CGFloat {
        if screenHeight < 812 {
            return CGFloat((y-287.616)/760*screenHeight)
        }
        
        return CGFloat((y-287.616)/926*screenHeight)
        
        
    }
    
    
    
    var body: some View {
        let map = ZStack {
            Image(mapImageHigh)
                .resizable()
                .background(Color.white)
//            if scale > 4 {
//                Image(mapImageHigh)
//                    .resizable()
//                    .background(Color.white)
//            } else {
//                Image(mapImageLow)
//                    .resizable()
//                    .background(Color.white)
//            }
//
            Path { path in
                
                path.move(to: CGPoint(x: fixX(x: start.x), y: fixY(y: start.y)))
                if inters.count > 0 {
                    for i in inters {
                        path.addLine(to: CGPoint(x: fixX(x: floor.inters[i].x), y: fixY(y: floor.inters[i].y)))
                        path.move(to: CGPoint(x: fixX(x: floor.inters[i].x), y: fixY(y: floor.inters[i].y)))
                    }
                }
                path.addLine(to: CGPoint(x: fixX(x: end.x), y: fixY(y: end.y)))
                
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
        ZoomableScrollView(content: map, currentScale: $scale, currentOffset: $offset, start: CGPoint(x: start.x, y: start.y), rect: createRectangle(floor: floor, inters: inters, start: start, end: end))
        
        
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


func createRectangle(floor: Floor, inters: [Int], start: CGPoint, end: CGPoint) -> CGRect {
    var minx = start.x
    var miny = start.y
    var maxx = start.x
    var maxy = start.y
    
    for i in inters {
        if floor.inters[i].x < minx {
            minx = floor.inters[i].x
        }
        if floor.inters[i].y < miny {
            miny = floor.inters[i].y
        }
        if floor.inters[i].x > maxx {
            maxx = floor.inters[i].x
        }
        if floor.inters[i].y > maxy {
            maxy = floor.inters[i].x
        }
    }
    
    if end.x < minx {
        minx = end.x
    }
    if end.y < miny {
        miny = end.y
    }
    if end.x > maxx {
        maxx = end.x
    }
    if end.y > maxy {
        maxy = end.y
    }
    
    minx-=10
    miny-=10
    maxx+=10
    maxy+=10
    
    return CGRect(x: minx/428*screenWidth, y: miny/926*screenHeight, width: (maxx-minx)/428*screenWidth, height: (maxy-miny)/926*screenHeight)
    
    
}

