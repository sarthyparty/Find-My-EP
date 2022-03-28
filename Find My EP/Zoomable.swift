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
    
    func makeUIView(context: Context) -> UIScrollView {
        // set up the UIScrollView
        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
        scrollView.maximumZoomScale = 15
        scrollView.minimumZoomScale = 1
        scrollView.bouncesZoom = true
        scrollView.bounces = true
        scrollView.bounds = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)//CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
                scrollView.zoom(to: CGRect(x: 100, y: 100, width: screenSize.width/4, height: screenSize.height/4), animated: true)
        
        // create a UIHostingController to hold our SwiftUI content
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        hostedView.contentScaleFactor = scrollView.minimumZoomScale
        hostedView.center = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        
        let gesture = UITapGestureRecognizer(target: context.coordinator,
                                             action: #selector(Coordinator.tapped))
        scrollView.addSubview(hostedView)
        hostedView.addGestureRecognizer(gesture)
        
//        scrollView.zoom(to: CGRect(x: 100, y: 100, width: screenSize.width/4, height: screenSize.height/4), animated: true)
        
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
        
        init(parent_: ZoomableScrollView, hostingController: UIHostingController<Content>) {
            self.parent = parent_
            self.hostingController = hostingController
        }
        
        func viewForZooming(in sv: UIScrollView) -> UIView? {
            return hostingController.view
        }
        
        func scrollViewDidZoom(_ sv: UIScrollView){
            self.parent.currentScale = sv.zoomScale
        }
        
        func scrollViewDidScroll(_ sv: UIScrollView){
            self.parent.currentOffset = sv.contentOffset
        }
        
        @objc func tapped(gesture:UITapGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            print(point)
        }
    }
}

import SwiftUI

struct UIScrollViewWrapper<Content: View>: UIViewControllerRepresentable {
    
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    func makeUIViewController(context: Context) -> UIScrollViewViewController {
        let vc = UIScrollViewViewController()
        vc.hostingController.rootView = AnyView(self.content())
        return vc
    }
    
    func updateUIViewController(_ viewController: UIScrollViewViewController, context: Context) {
        viewController.hostingController.rootView = AnyView(self.content())
    }
}

class UIScrollViewViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.isPagingEnabled = true
        return v
    }()
    
    var hostingController: UIHostingController<AnyView> = UIHostingController(rootView: AnyView(EmptyView()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.scrollView)
        self.pinEdges(of: self.scrollView, to: self.view)
        
        self.hostingController.willMove(toParent: self)
        self.scrollView.addSubview(self.hostingController.view)
        self.pinEdges(of: self.hostingController.view, to: self.scrollView)
        self.hostingController.didMove(toParent: self)
        
    }
    
    func pinEdges(of viewA: UIView, to viewB: UIView) {
        viewA.translatesAutoresizingMaskIntoConstraints = false
        viewB.addConstraints([
            viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
            viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor),
            viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
            viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
        ])
    }
    
}
