//
////  CompassHeading.swift
////  Find My EP
////
////  Created by 64000774 on 4/27/22.
//
//
//import Foundation
//import Combine
//import CoreLocation
//
//class CompassHeading: NSObject, ObservableObject, CLLocationManagerDelegate {
//    var objectWillChange = PassthroughSubject<Void, Never>()
//    var degrees: Double = .zero {
//        didSet {
//            objectWillChange.send()
//        }
//    }
//
//    var latitude: Double = .zero {
//        didSet {
//            objectWillChange.send()
//        }
//    }
//
//    var longitude: Double = .zero {
//        didSet {
//            objectWillChange.send()
//        }
//    }
//
//    private let locationManager: CLLocationManager
//
//    override init() {
//        self.locationManager = CLLocationManager()
//        super.init()
//
//        self.locationManager.delegate = self
//        self.setup()
//    }
//
//    private func setup() {
//
//        self.locationManager.requestWhenInUseAuthorization()
//
//
//        if CLLocationManager.headingAvailable() && CLLocationManager.locationServicesEnabled() {
//            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            self.locationManager.startUpdatingLocation()
//            self.locationManager.startUpdatingHeading()
//            print(self.locationManager.location)
//
//        } else {
//            print("location services not enabled")
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
//        self.degrees = -1 * newHeading.trueHeading
//        self.latitude = (self.locationManager.location!.coordinate.latitude)
//        self.longitude = (self.locationManager.location!.coordinate.longitude)
//
//    }
//
//    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
//        self.locationManager.stopUpdatingHeading()
//        print(error)
//    }
//
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        let locationArray = locations as NSArray
//        let locationObj = locationArray.lastObject as! CLLocation
//        let coord = locationObj.coordinate
//        print(longitude)
//        print(latitude)
//        longitude = coord.longitude
//        latitude = coord.latitude
//    }
//}
