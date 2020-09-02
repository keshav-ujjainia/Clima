//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, requiredMethods {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    var WeatherManager = weatherManager()
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        

        
        
        // Do any additional setup after loading the view.
    }
    
    func didupdateUI(cityname: String, temp: String){
        DispatchQueue.main.async {
            self.temperatureLabel.text = temp
            self.cityLabel.text = cityname
        }
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        WeatherManager.fetchweather(city: textfield.text!)
    }
    
    @IBAction func navigation(_ sender: UIButton) {
        WeatherManager.fetchweather(lat: (locationManager.location?.coordinate.latitude)!, lon: (locationManager.location?.coordinate.longitude)!)
        
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("gotcha")
            print(lat)
            print(lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

