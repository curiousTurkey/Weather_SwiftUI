//
//  WeatherStore.swift
//  Weather
//
//  Created by Eldhose on 2024-10-22.
//

import Foundation
import Observation


@Observable
final class WeatherStore {
    var weatherResponse: WeatherResponse?
    
    func fetchWeather(latitude: Double, longitude: Double) {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&daily=temperature_2m_max,weather_code") else {
            return
        }
        
        let apiFetchTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
            print("\(data)")
            do {
                let decoder = JSONDecoder()
                let decodedWeatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self.weatherResponse = decodedWeatherResponse
                }
            } catch {
                print("Error decoding weather data: \(error.localizedDescription)")
            }
        }
        
        apiFetchTask.resume()
    }
    
}
