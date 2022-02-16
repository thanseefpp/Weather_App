//
//  WeatherModel.swift
//  Clima
//
//  Created by THANSEEF on 14/02/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel {
    let temperature : Double
    let cityName : String
    let conditionId : Int
    
    // Using Computed Property.
    var getConditionName : String {
        switch conditionId{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
            
        }
    }
    
    var convertTempIntoString : String {
        String(format: "%.1f", temperature)
    }
}
