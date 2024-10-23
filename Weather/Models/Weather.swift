import Foundation

struct WeatherResponse: Codable {
    let latitude: Double
    let longitude: Double
    let daily: Daily
    let dailyUnits: DailyUnits
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude, daily
        case dailyUnits = "daily_units"
    }
}

struct Daily: Codable {
    let time: [String]
    let temperature2mMax: [Double]
    let weatherCode: [Int]
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2mMax = "temperature_2m_max"
        case weatherCode = "weather_code"
    }
}

struct DailyUnits: Codable {
    let time: String
    let temperature2mMax: String
    let weatherCode: String
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2mMax = "temperature_2m_max"
        case weatherCode = "weather_code"
    }
}
