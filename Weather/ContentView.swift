//
//  ContentView.swift
//  Weather
//
//  Created by Eldhose on 2024-10-22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var location = LocationManager()
    @State private var isNight: Bool = false
    @State private var latitude: Double = 0.0 // Change to @State
    @State private var longitude: Double = 0.0 // Change to @State
    var body: some View {
        ZStack{
            //no more than 10 views in ZStack or parent , nested views doesn't count
            //Color(.blue).ignoresSafeArea(.all)
            BackgroundView(isNight: $isNight)
            //set background
            //VStack
            VStack{
                LocationView(
                    locationName: "\(String(format: "%.1f", latitude)), \(String(format: "%.1f", longitude))"
                )
                MainWeatherStatusView(
                    imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: viewModel.displayWeather?.daily.temperature2mMax[0] ?? 0
                )
                
                HStack(spacing: 20) {
                    WeatherDayView(dayOfWeek: "Tue", imageName: "cloud.rain.fill", temperature: 79)
                    WeatherDayView(dayOfWeek: "Wed", imageName: "cloud.sleet.fill", temperature: 75)
                    WeatherDayView(dayOfWeek: "Thu", imageName: "cloud.rain.fill", temperature: 73)
                    WeatherDayView(dayOfWeek: "Fri", imageName: "wind", temperature: 71)
                    WeatherDayView(dayOfWeek: "Sat", imageName: "snow", temperature: 29)
                }
                Spacer()
                Button {
                    //action: what button does
                    isNight.toggle()
                } label: {
                    ButtonLabel(label: "Change day time", textColor: .blue, backgroundColor: .white)
                }.padding(.bottom, 30)
                
                Button {
                    latitude = location.userLocation?.coordinate.latitude ?? 0.0
                    longitude = location.userLocation?.coordinate.longitude ?? 0.0
                    viewModel.loadWeather(latitude: latitude, longitude: longitude)
                } label: {
                    ButtonLabel(label: "Get weather", textColor: .blue, backgroundColor: .white)
                }
                
                Spacer()
            }
        }.onAppear{
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    var dayOfWeek:String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack{
            Text(dayOfWeek)
                .font(.system(size: 28))
                .foregroundStyle(.white)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable().aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            Text("\(temperature)°C")
                .font(.system(size: 20))
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding(.bottom, 10)
        }
    }
}

struct BackgroundView: View {
    //
//    var topColor: Color
//    var bottomColor: Color
    //
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
            startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}

struct LocationView: View {
    //
    var locationName: String
    //
    var body: some View {
        Text(locationName)
            .font(.system(size: 32, weight: .medium, design: .default)).padding(.top, 30)
            .foregroundStyle(.white)
    }
}
struct MainWeatherStatusView: View {
    var imageName: String
    var temperature: Double
    
    var body: some View {
        VStack(spacing: 0){
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("\(String(format: "%.1f", temperature))°C").font(.system(size: 45, weight: .medium))
                .foregroundStyle(.white)
                .padding()
        }.padding(.bottom, 60)
    }
}
