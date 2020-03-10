//
//  WeatherData.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 2/13/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import Foundation
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
