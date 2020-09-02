//
//  weatherManager.swift
//  Clima
//
//  Created by keshav-ujjainia on 29/05/1942 Saka.
//  Copyright © 1942 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol requiredMethods {
    func didupdateUI(cityname: String, temp: String)
}

struct weatherManager {
    let baseurl = "https://api.openweathermap.org/data/2.5/weather?"
    let apikey = "&appid=efadec35a46c4744f876b97f83743d68"
    
    var delegate: requiredMethods?

    func fetchweather(city: String){
        let url = "\(baseurl)q=\(city)\(apikey)&units=metric"
        print(url)
        performRequest(urlstring: url)
    }
    
    func fetchweather(lat: CLLocationDegrees, lon: CLLocationDegrees){
        let url = "\(baseurl)lat=\(lat)&lon=\(lon)\(apikey)&units=metric"
        print(url)
        performRequest(urlstring: url)
    }
    
     func performRequest(urlstring: String){
        
        if let url = URL(string: urlstring) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                }
                if let safedata = data {
//                    let datastring = String(data: safedata, encoding: .utf8)
//                    print(datastring)
                    if  let weather = self.parseJSON(weatherData: safedata) {
                        self.delegate?.didupdateUI(cityname: weather.cityName, temp: String(format: "%.2f", weather.temp))
                        print(weather.cityName)
                    }
       
                    
                    
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let datastring = try decoder.decode(WeatherData.self, from: weatherData)
            print(datastring.main.temp)
            let weather = WeatherModel(cityName: datastring.name, temp: datastring.main.temp)
            return weather

        } catch {
            print(error)
            return nil

        }
    }
}
