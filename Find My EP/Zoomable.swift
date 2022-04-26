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
        scrollView.minimumZoomScale = 6
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
//        scrollView.setZoomScale(6, animated: true)
        
        scrollView.zoom(to: CGRect(x: (start.x-23)/428*screenWidth, y: (start.y-10)/926*screenHeight, width: 40/428*screenWidth, height: 40/926*screenHeight), animated: true)
        
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
    
    func setInitialZoom() {
        
        
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
        
//        func scrollView(_ sv: UIScrollView){
//            self.parent.currentScale = sv.zoomScale
//        }
        
        func scrollViewDidZoom(_ sv:UIScrollView) {
            self.parent.currentScale = sv.zoomScale
        }
        
    
        func scrollViewDidScroll(_ sv: UIScrollView){
//            sv.setValue(0.10, forKeyPath: "contentOffsetAnimationDuration")
//            if sv.contentOffset.y <= scaleFac * Double(parent.currentScale * 267.1 - 203.2) {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: scaleFac * Double(parent.currentScale * 270.2 + 9.5) ), animated: true)
//            }
//            else if sv.contentOffset.y >= scaleFac * Double(parent.currentScale * 510.7 - 357.0) {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: scaleFac * Double(parent.currentScale * 512.5 - 641.4)), animated: true)
//            }

//            if sv.contentOffset.y <= forceminy {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: miny * parent.currentScale / 6 ), animated: true)
//            }
//            else if sv.contentOffset.y >= forcemaxy {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: maxy * parent.currentScale / 6), animated: true)
//            }

         //self.parent.currentOffset = sv.contentOffset
        }
        
//        func scrollViewWillEndDragging(_ sv: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//            if sv.contentOffset.y <= 1625 && sv.contentOffset.x <= 0 {
//                targetContentOffset.pointee = CGPoint(x: 0, y: 1625)
//            }
//
//            else if sv.contentOffset.y <= 1625 && sv.contentOffset.x >= 0 && sv.contentOffset.x <= 1875 {
//                targetContentOffset.pointee = CGPoint(x: targetContentOffset.pointee.x, y: 1625)
//            }
//
//            else if sv.contentOffset.y >= 2434 && sv.contentOffset.x >= 1875 {
//                targetContentOffset.pointee = CGPoint(x: 1875, y: 2434)
//            }
//
//            else if sv.contentOffset.y >= 2434 && sv.contentOffset.x <= 1875 && sv.contentOffset.x >= 0 {
//                targetContentOffset.pointee = CGPoint(x: targetContentOffset.pointee.x, y: 2434)
//            }
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

        
        
        
        
        
        
//        func scrollViewWillBeginDecelerating(_ sv: UIScrollView) {
//            if sv.contentOffset.y <= miny * parent.currentScale / 6 && sv.contentOffset.x <= 0 {
//                sv.setContentOffset(CGPoint(x: 0, y: miny * parent.currentScale / 6), animated: true)
//            }
//
//            else if sv.contentOffset.y <= miny * parent.currentScale / 6 && sv.contentOffset.x >= 0 && sv.contentOffset.x <= screenSize.width * parent.currentScale {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: miny * parent.currentScale / 6), animated: true)
//            }
//
//            else if sv.contentOffset.y >= maxy * parent.currentScale / 6 && sv.contentOffset.x >= screenSize.width * parent.currentScale {
//                sv.setContentOffset(CGPoint(x: screenSize.width * parent.currentScale, y: maxy * parent.currentScale / 6), animated: true)
//            }
//
//            else if sv.contentOffset.y >= maxy * parent.currentScale / 6 && sv.contentOffset.x <= screenSize.width * parent.currentScale && sv.contentOffset.x >= 0 {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: maxy * parent.currentScale / 6), animated: true)
//            }
//            self.parent.currentOffset = sv.contentOffset
//        }

//        func scrollViewWillBeginDecelerating(_ sv: UIScrollView) {
//            if sv.contentOffset.y <= 1625 && sv.contentOffset.x <= 0 {
//                sv.setContentOffset(CGPoint(x: 0, y: 1625), animated: true)
//            }
//
//            else if sv.contentOffset.y <= 1625 && sv.contentOffset.x >= 0 && sv.contentOffset.x <= (1875/1875*screenSize.width) {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: 1625), animated: true)
//            }
//
//            else if sv.contentOffset.y >= 2434 && sv.contentOffset.x >= (1875/1875*screenSize.width) {
//                sv.setContentOffset(CGPoint(x: (1875/1875*screenSize.width), y: 2434), animated: true)
//            }
//
//            else if sv.contentOffset.y >= 2434 && sv.contentOffset.x <= (1875/1875*screenSize.width) && sv.contentOffset.x >= 0 {
//                sv.setContentOffset(CGPoint(x: sv.contentOffset.x, y: 2434), animated: true)
//            }
//            self.parent.currentOffset = sv.contentOffset
//        }
        
//        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//            if targetContentOffset.pointee.y <= 1625 {
//                print("above")
//                targetContentOffset.pointee = CGPoint(x: targetContentOffset.pointee.x, y: 1625)
//            }
//            else if targetContentOffset.pointee.y >= 2434{
//                print("under")
//                targetContentOffset.pointee = CGPoint(x: targetContentOffset.pointee.x, y: 2434)
//            }
//
//        }
        
        @objc func tapped(gesture:UITapGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            print(point)
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


