//
//  Zoomable.swift
//  Find My EP
//
//  Created by 64000774 on 3/1/22.
//

import UIKit
import SwiftUI



struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    private var content: Content
    private var scrollView: UIScrollView
    private var zoomedYet: Bool
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
        self.scrollView = UIScrollView()
        zoomedYet = false

    }
    
    func makeUIView(context: Context) -> UIScrollView {
        // set up the UIScrollView
        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
        scrollView.maximumZoomScale = 15
        scrollView.minimumZoomScale = 1
        scrollView.bouncesZoom = true
        scrollView.bounces = true
        scrollView.bounds = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)//CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
//        scrollView.zoomScale = 1
//        scrollView.zoom(to: CGRect(x: 100, y: 100, width: screenSize.width/4, height: screenSize.height/4), animated: true)
        
        // create a UIHostingController to hold our SwiftUI content
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        hostedView.contentScaleFactor = scrollView.minimumZoomScale
        hostedView.center = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        scrollView.addSubview(hostedView)
        
        return scrollView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: self.content))
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // update the hosting controller's SwiftUI content
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    func setInitialZoom() {
        scrollView.zoom(to: CGRect(x: 100, y: 100, width: screenSize.width/4, height: screenSize.height/4), animated: true)

    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>
        
        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
    }
}
