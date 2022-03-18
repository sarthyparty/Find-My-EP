//
//  PanGesture.swift
//  Find My EP
//
//  Created by 64000774 on 3/4/22.
//

import SwiftUI

extension View {
    func addPinchZoom() -> some View {
        return PinchZoomContext {
            self
        }
    }
    
}

struct PinchZoomContext<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: @escaping()->Content) {
        self.content = content()
    }
    
    @State var offset: CGPoint = .zero
    @State var scale: CGFloat = 1
    
    @State var prevOffset: CGPoint = .zero
    @State var prevScale: CGFloat = 1
    
    @State var scalePosition: CGPoint = .zero
    
    @State var prevScalePosition: CGPoint = .zero
    
    var body: some View {
        content
        
            .offset(x: offset.x + prevOffset.x, y: offset.y + prevOffset.y)
            .overlay(
                GeometryReader{proxy in
                    let size = proxy.size
                    
                    ZoomGesture(size: size, scale: $scale, offset: $offset, scalePosition: $scalePosition, prevScale: $prevScale, prevOffset: $prevOffset, prevScalePosition: $prevScalePosition)
                    
                }
            )
        
            .scaleEffect(scale, anchor: .init(x: scalePosition.x + prevScalePosition.x, y: scalePosition.y + prevScalePosition.y))
        
    }
}

struct ZoomGesture: UIViewRepresentable {
    
    var size: CGSize
    
    @Binding var scale: CGFloat
    @Binding var offset: CGPoint
    
    @Binding var scalePosition: CGPoint
    
    @Binding var prevScale: CGFloat
    @Binding var prevOffset: CGPoint
    
    @Binding var prevScalePosition: CGPoint
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let Pinchgesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(sender:)))
        
        view.addGestureRecognizer(Pinchgesture)
        
        let Pangesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(sender:)))
        
        Pangesture.delegate = context.coordinator
        
//        view.addGestureRecognizer(Pangesture)
        view.addGestureRecognizer(Pinchgesture)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        
        var parent: ZoomGesture
        
        init(parent: ZoomGesture) {
            self.parent = parent
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        @objc
        func handlePinch(sender: UIPinchGestureRecognizer) {
            
            
            if sender.state == .began {
                parent.scale = sender.scale * parent.prevScale

                
                let scalePoint = CGPoint(x: sender.location(in: sender.view).x / sender.view!.frame.size.width, y: sender.location(in: sender.view).y / sender.view!.frame.size.height)
//                parent.offset = CGPoint(x: (screenWidth/2 - scalePoint.x)/parent.scale, y: (screenHeight/2 - scalePoint.y)/parent.scale)
                parent.scalePosition = scalePoint
                
                
            } else if sender.state == .changed {
                
                parent.scale = sender.scale * parent.prevScale
                
            } else {
//                parent.scale = 1
//                parent.scalePosition = .zero
                
                parent.prevScale = parent.scale
            }
        }
        
        @objc
       func handlePan(sender: UIPanGestureRecognizer) {
           
           sender.maximumNumberOfTouches = 2
           
           if sender.state == .began || sender.state == .changed && parent.scale > 0 {
               if let view = sender.view {
                   let translation = sender.translation(in: view)
                   parent.offset = translation
               }
           } else {
               parent.offset = .zero
               parent.scalePosition = .zero
           }
       }
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
