//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Eldhose on 2024-10-22.
//

import Foundation
import Observation
import CoreLocation
@Observable
final class WeatherViewModel: ObservableObject {
    private var geoCoder = CLGeocoder()
    var locationName: String = ""
    private var weatherStore: WeatherStore
    //computed properties
    var displayWeather: WeatherResponse? {
        return weatherStore.weatherResponse
    }
    
    init(weatherStore: WeatherStore = WeatherStore()){
        self.weatherStore = weatherStore
        
    }
    
    func loadWeather(latitude: Double, longitude: Double){
        weatherStore.fetchWeather(latitude: latitude, longitude: longitude)
    }
    
    func reverseGeocode(latitude: Double, longitude: Double){
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { placemarks, error in
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            self.locationName = placemark?.locality ?? "Unknown City"
        }
    }
}
