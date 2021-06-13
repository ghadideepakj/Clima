//
//  WeatherManager.swift
//  Clima
//
//  Created by Veekay Infotech on 21/02/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager:WeatherManager,  weather: WeatherModel)
    func didFailWithError(error: Error) 
}

struct WeatherManager {
    
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=371cfcf69c8d1fe9e2002781a3e35a22"
    
    var delegate : WeatherManagerDelegate?
    
    mutating func fetchWeather(cityName : String) {
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        //print(urlString)
        performRequest(with: urlString)
    }
    
    mutating func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        //1.  Create a URL
        if let url = URL(string: urlString){
        
        //2.  Create a URLsession
            let session = URLSession(configuration: .default)
            
        //3.  Give the session a task
            let task = session.dataTask(with: url) { (data, responce, error) in
                
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    
                    let dataString = String(data: safeData, encoding: .utf8)
                    print(dataString!)
                    
                    if let weather = self.parseJSON(safeData)
                    {self.delegate?.didUpdateWeather(self, weather : weather)}
                    
                    
                   // self.parseJSON(weatherData: safeData)
                }

            }
            
        //4.  Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        
        let decoder = JSONDecoder()
        do
        {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let parsewWeather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return parsewWeather
            }catch{
            print(error)
                
                self.delegate?.didFailWithError(error: error)
                return nil
            }
    
    }
    
}
