//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation // importing location lib.

class WeatherViewController: UIViewController {
    
    // UITextFieldDelegate it's a protocol to control text field views
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    var weatherManager = WeatherManager()
    let locationManger = CLLocationManager() // creating obj to this class.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.delegate = self // to get access delegate
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestLocation() // or use startUpdatingLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self // when screen load all delegated items will be loaded (interact with text field)
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManger.requestLocation()
    }
}

//MARK: - UiTextField Delegate

// here expanding the view controller feature using extention
extension WeatherViewController : UITextFieldDelegate {
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //this function used to execute when user press keybord go button
        searchTextField.endEditing(true) // this will hide the keyboard one you hit the button
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { //this function will execute if the user press go button without typing anything
        if textField.text != ""{
            return true
        }else{
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // this func is used to execute when the textfield end
        if let userinputCity = searchTextField.text{
            weatherManager.urlFetcher(cityName: userinputCity)
        }
        searchTextField.text = "" // this will make text field empty
    }
    
}

//MARK: - weather manager controlling.

extension WeatherViewController : WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManger:WeatherManager,weather: WeatherModel) {
        DispatchQueue.main.async { // this will use when you call a network using functions for more info google it.
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.convertTempIntoString
            self.conditionImageView.image = UIImage(systemName: weather.getConditionName)
        }
        
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}


//MARK: - Location protocols handler.

extension WeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManger.stopUpdatingLocation() // once the device got the location then updating location need to stop.
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            
            weatherManager.fetchWeatherLatLong(latitude: lat,longitude: long)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("My error method : \(error)")
    }
}
