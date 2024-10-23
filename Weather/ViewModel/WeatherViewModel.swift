//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Eldhose on 2024-10-22.
//

import Foundation
import Observation

@Observable
final class WeatherViewModel: ObservableObject {
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
}
