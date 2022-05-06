//
//  Zoomable.swift
//  Find My EP
//
//  Created by 64000774 on 3/1/22.
//
 
import UIKit
import SwiftUI
 
 
struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    var content: Content
    @Binding var currentScale: CGFloat
    @Binding var currentOffset: CGPoint
    var scrollView = UIScrollView()
    var start: CGPoint
    
    func makeUIView(context: Context) -> UIScrollView {
        // set up the UIScrollView
        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
        scrollView.maximumZoomScale = 15
        scrollView.minimumZoomScale = 5
        scrollView.bouncesZoom = true
        scrollView.bounces = true
        //scrollView.clipsToBounds = true
        scrollView.bounds = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.maxY)//CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        // create a UIHostingController to hold our SwiftUI content
        //scrollView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - 400)
        
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        //CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        hostedView.contentScaleFactor = scrollView.minimumZoomScale
        hostedView.center = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        
        /*let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
         rect = rect.union(view.frame)
         }
         scrollView.contentSize = contentRect.size */
        
        let gesture = UITapGestureRecognizer(target: context.coordinator,
                                             action: #selector(Coordinator.tapped))
        scrollView.addSubview(hostedView)
        hostedView.addGestureRecognizer(gesture)
        
        scrollView.zoom(to: CGRect(x: (start.x-23)/428*screenWidth, y: (start.y-10)/926*screenHeight, width: 40/428*screenWidth, height: 40/926*screenHeight), animated: true)
        
        //scrollView.setZoomScale(scrollView.minimumZoomScale, animated: false)
        
        return scrollView
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent_: self, hostingController: UIHostingController(rootView: self.content))
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // update the hosting controller's SwiftUI content
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UIScrollViewDelegate, UIGestureRecognizerDelegate {
        var hostingController: UIHostingController<Content>
        var parent: ZoomableScrollView
        var scaleFac: CGFloat
        var scaleZoomLower: CGFloat
        var scaleZoomHigher: CGFloat
        
        var scaleZoomForceLower: CGFloat
        var scaleZoomForceHigher: CGFloat
        
        var miny: CGFloat
        var maxy: CGFloat
        var forceminy: CGFloat
        var forcemaxy: CGFloat
        
        var prevTap = CGPoint(x: 0, y: 0)
        
        var isZooming = false
        
        init(parent_: ZoomableScrollView, hostingController: UIHostingController<Content>) {
            self.parent = parent_
            self.hostingController = hostingController
            scaleFac = Double(screenSize.height) / 812.0
            scaleZoomLower = Double(parent.currentScale * 270.2 + 9.5)
            scaleZoomHigher = Double(parent.currentScale * 512.5 - 641.4)
            self.miny = 1625 //* screenSize.height / 812.0
            self.maxy = 2434 //* screenSize.height / 812.0
            self.forceminy = 1400 //* screenSize.height / 812.0
            self.forcemaxy = 2600 //*  screenSize.height / 812.0
            scaleZoomForceLower = Double(parent.currentScale * 267.1 - 203.2)
            scaleZoomForceHigher = Double(parent.currentScale * 510.7 - 357.0)
        }
        
        func viewForZooming(in sv: UIScrollView) -> UIView? {
            return hostingController.view
        }
        
        
        func scrollViewDidZoom(_ sv:UIScrollView) {
            self.isZooming = true
            self.parent.currentScale = sv.zoomScale
        }
        
        func scrollViewDidEndZooming(_ sv: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
            self.isZooming = false
 
            let forceLower = scaleFac * Double(sv.zoomScale * 247.8 - 235.5)
            let forceHigher = scaleFac * Double(sv.zoomScale * 532.3 - 315.0)
 
            let lowerBound = scaleFac * Double(sv.zoomScale * 250 + 37.54)
            let higherBound = scaleFac * Double(sv.zoomScale * 540 - 572.1)
 
 
            sv.setValue(0.15, forKeyPath: "contentOffsetAnimationDuration")
            if sv.contentOffset.y <= forceLower {
                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: lowerBound), animated: true)
            }
            else if sv.contentOffset.y >= forceHigher {
                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: higherBound), animated: true)
            }
 
        }
 
        func scrollViewDidScroll(_ sv: UIScrollView){
 
            if self.isZooming {
                return
            }
            let forceLower = scaleFac * Double(sv.zoomScale * 247.8 - 235.5)
            let forceHigher = scaleFac * Double(sv.zoomScale * 532.3 - 315.0)
 
            let lowerBound = scaleFac * Double(sv.zoomScale * 250 + 37.54)
            let higherBound = scaleFac * Double(sv.zoomScale * 540 - 572.1)
 
 
            sv.setValue(0.15, forKeyPath: "contentOffsetAnimationDuration")
            if sv.contentOffset.y <= forceLower {
                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: lowerBound), animated: true)
            }
            else if sv.contentOffset.y >= forceHigher {
                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: higherBound), animated: true)
            }
 
        }
        
//        func scrollViewDidEndZooming(_ sv: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
//            self.isZooming = false
//
//            let forceLower = scaleFac * Double(sv.zoomScale * 267.1 - 203.2)
//            let forceHigher = scaleFac * Double(sv.zoomScale * 510.7 - 357.0)
//
//            let lowerBound = scaleFac * Double(sv.zoomScale * 270.2 + 9.5)
//            let higherBound = scaleFac * Double(sv.zoomScale * 512.5 - 641.4)
//
//
//            sv.setValue(0.15, forKeyPath: "contentOffsetAnimationDuration")
//            if sv.contentOffset.y <= forceLower {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: lowerBound), animated: true)
//            }
//            else if sv.contentOffset.y >= forceHigher {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: higherBound), animated: true)
//            }
//
//        }
        
        
//        func scrollViewDidScroll(_ sv: UIScrollView) {
//
//            self.parent.currentOffset = sv.contentOffset
//
//        }
    
//        func scrollViewDidScroll(_ sv: UIScrollView){
//
//            if self.isZooming {
//                return
//            }
//            let forceLower = scaleFac * Double(sv.zoomScale * 267.1 - 203.2)
//            let forceHigher = scaleFac * Double(sv.zoomScale * 510.7 - 357.0)
//
//            let lowerBound = scaleFac * Double(sv.zoomScale * 270.2 + 9.5)
//            let higherBound = scaleFac * Double(sv.zoomScale * 512.5 - 641.4)
//
//
//            sv.setValue(0.15, forKeyPath: "contentOffsetAnimationDuration")
//            if sv.contentOffset.y <= forceLower {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: lowerBound), animated: true)
//            }
//            else if sv.contentOffset.y >= forceHigher {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: higherBound), animated: true)
//            }
//
//        }
        
        
        
        
        
//        func scrollViewWillBeginDecelerating(_ sv: UIScrollView) {
//            if sv.contentOffset.y <= Double(parent.currentScale * 270.2 + 9.5) * scaleFac && sv.contentOffset.x <= 0 {
//                sv.setContentOffset(CGPoint(x: 0, y: scaleFac * Double(parent.currentScale * 270.2 + 9.5)), animated: true)
//            }
//
//            else if sv.contentOffset.y <= scaleFac * Double(parent.currentScale * 270.2 + 9.5) && sv.contentOffset.x >= 0 && sv.contentOffset.x <= screenSize.width * (parent.currentScale-1) {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: scaleFac * Double(parent.currentScale * 270.2 + 9.5)), animated: true)
//            }
//
//            else if sv.contentOffset.y <= scaleFac * Double(parent.currentScale * 270.2 + 9.5) && sv.contentOffset.x >= screenSize.width * (parent.currentScale-1) {
//                sv.setContentOffset(CGPoint(x: screenSize.width * (parent.currentScale-1), y: scaleFac * Double(parent.currentScale * 270.2 + 9.5)), animated: true)
//            }
//
//            else if sv.contentOffset.y >= scaleFac * Double(parent.currentScale * 512.5 - 641.4) && sv.contentOffset.x <= 0 {
//                sv.setContentOffset(CGPoint(x: 0, y: scaleFac * Double(parent.currentScale * 512.5 - 641.4)), animated: true)
//            }
//
//            else if sv.contentOffset.y >= scaleFac * Double(parent.currentScale * 512.5 - 641.4) && sv.contentOffset.x >= screenSize.width * (parent.currentScale-1) {
//                sv.setContentOffset(CGPoint(x: screenSize.width * (parent.currentScale-1), y: scaleFac * Double(parent.currentScale * 512.5 - 641.4)), animated: true)
//            }
//
//            else if sv.contentOffset.y >= scaleFac * Double(parent.currentScale * 512.5 - 641.4) && sv.contentOffset.x <= screenSize.width * (parent.currentScale-1) && sv.contentOffset.x >= 0 {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: scaleFac * Double(parent.currentScale * 512.5 - 641.4)), animated: true)
//            }
//            self.parent.currentOffset = sv.contentOffset
//        }
 
        
        
        
        
        
 
        
        @objc func tapped(gesture:UITapGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            
            print("\(point) \(dist(x1: point.x, y1: point.y, x2: prevTap.x, y2: prevTap.y))")
            prevTap = point
            //print(self.parent.currentOffset)
            //print(screenSize)
            //print(maxy)
            //print(miny)
            //print(forceminy)
            //print(forcemaxy)
            //print(parent.currentScale)
        }
    }
}
