//
//  WeatherManager.swift
//  weathery
//
//  Created by Mrityunjay Kumar on 01/08/23.
//

import Foundation

class WeatherManager {
    
    func fetchWeather(placeName: String){
        print("fetchweather method called. fetching weather for placename : \(placeName)")
        
        // creating URL
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(placeName)&appid=dcd8d1e523617d0b8e3a2b418d370538") {
            
            // creating session
            let session = URLSession(configuration: .default)
            
            // creating / assigning task
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
//                    let dataString = String(data: safeData, encoding: .utf8)!
//                    print("DataString - \(dataString)")
                    
                    self.parseJson(data: safeData)
                }
                
            } // clousers ended here named completion handler
            
            task.resume()
        }
    }
    
    func parseJson(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            print(decodedData)
        }catch{
            print(error)
        }
        print(data)
    }
    
}
