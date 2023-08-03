//
//  ViewController.swift
//  weathery
//
//  Created by Mrityunjay Kumar on 31/07/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var textField: UITextField!
    
    var weatherManager = WeatherManager()
    
    let coreLocation = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        coreLocation.delegate = self
        
        coreLocation.requestWhenInUseAuthorization()
        coreLocation.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations : \(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        print(textField.text!)
        textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherManager.fetchWeather(placeName: textField.text!)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            textField.placeholder = "Please enter a place name"
            return false
        }
        
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldReturn(_ abcd: UITextField) -> Bool {
        abcd.endEditing(true)
        return true
    }
}

