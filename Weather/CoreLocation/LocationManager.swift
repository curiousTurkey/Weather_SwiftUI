//
//  LocationManager.swift
//  Weather
//
//  Created by Eldhose on 2024-10-22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var location = CLLocationManager()
    
    @Published var userLocation: CLLocation? = nil
    @Published var locationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        self.location.delegate = self
        self.location.desiredAccuracy = kCLLocationAccuracyBest
        self.requestLocation()
    }
    
    func requestLocation() {
        print("Here")
        self.location.requestAlwaysAuthorization()
        self.location.requestWhenInUseAuthorization()
        self.location.startUpdatingLocation()
       
    }
    //CLLocationManagerDelegate to handle location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else { return }
        self.userLocation = location
        self.location.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        self.locationStatus = status
        switch status {
        case .authorizedAlways, .authorizedWhenInUse : self.location.startUpdatingLocation()
            break
        default : self.location.stopUpdatingLocation()
        }
    }
}
