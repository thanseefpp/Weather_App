//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    // UITextFieldDelegate it's a protocol to control text field views
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self // when screen load all delegated items will be loaded (interact with text field)
    }
    
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
    
    func textFieldDidEndEditing(_ textField: UITextField) { // this func is used to execute when the textfield end
        searchTextField.text = "" // this will make text field empty
    }
    
    
}

