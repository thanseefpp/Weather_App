//
//  WeatherData.swift
//  Clima
//
//  Created by THANSEEF on 14/02/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherData : Decodable {
    let name : String
    let main : Main
    let weather : [Weather]
    let base : String
    let wind : Speed
}


struct Main : Decodable {
    let temp : Double
    let temp_min : Double
    let temp_max : Double
    let humidity : Double
}

struct Weather : Decodable {
    let id : Int
}

struct Speed : Decodable {
    let speed : Double
}


