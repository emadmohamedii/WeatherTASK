//
//  LocationManager.swift
//  SHTask
//
//  Created by Emad Habib on 26/03/2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    static let shared = LocationManager()
    
    var location: CLLocation?
    var locationHandler: ((CLLocation)->()?)? = nil
    
    private override init() {
        super.init()
        
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    static func requestGPS() {
        LocationManager.shared.manager.requestAlwaysAuthorization()
        LocationManager.shared.manager.requestLocation()
        LocationManager.shared.manager.startUpdatingLocation()
    }
}

extension LocationManager {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last
        if let location = locations.last {
            self.locationHandler?(location)
        }
        print("location", location ?? "")
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function, "status", status)
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            self.manager.startUpdatingLocation()
        }
        // check the authorization status changes here
    }
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(#function)
        if (error as? CLError)?.code == .denied {
            manager.stopUpdatingLocation()
            manager.stopMonitoringSignificantLocationChanges()
        }
    }
}
