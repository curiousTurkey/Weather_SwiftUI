//
//  WeatherButton.swift
//  Weather
//
//  Created by Eldhose on 2024-10-22.
//

import SwiftUI

struct ButtonLabel: View {
    var label: String
    var textColor: Color
    var backgroundColor: Color
    var body: some View {
        Text(label)
            .frame(width: 280, height: 50)
            .font(.system(size: 20, weight: .semibold))
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(10)
    }
}
