//
//  WeatherManger.swift
//  Clima
//
//  Created by THANSEEF on 14/02/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

// created a protocol to handle view controller
protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManger:WeatherManager,weather:WeatherModel)
    func didFailWithError(error:Error)
}

struct WeatherManager {
    let apiUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=998216288e37e2202bb056fac8750f68&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func urlFetcher(cityName : String){
        let urlString = "\(apiUrl)&q=\(cityName)"
        performeRequest(with: urlString)
    }
    
    func fetchWeatherLatLong(latitude: CLLocationDegrees,longitude: CLLocationDegrees){
        let urlString = "\(apiUrl)&lat=\(latitude)&lon=\(longitude)"
        performeRequest(with: urlString)
    }
    
    func performeRequest(with urlString : String){
        // 1. CREATE URL
        if let url = URL(string: urlString){
            // 2. CREATE A URLSESSION
            let session = URLSession(configuration: .default)
            // 3. GIVE THE SESSION TASK
            let task = session.dataTask(with: url) { (data, response, error ) in // closure
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print(error!)
                }
                
                if let safeData = data{
                    if let weather = self.jsonParse(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self,weather: weather)//updating delegete func
                    }
                }
            }
            
            // 4. START NEW TASK
            task.resume()
        }
    }
    
    func jsonParse(weatherData: Data) -> WeatherModel? {
        let decorder = JSONDecoder()
        do{
            let decodedData = try decorder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let locationName = decodedData.name
            let weatherDataModel = WeatherModel(temperature: temp, cityName: locationName, conditionId: id)
            return weatherDataModel
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
