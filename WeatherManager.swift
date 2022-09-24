//
//  WeatherManager.swift
//  Clima
//
//  Created by Minhax on 27/03/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(weather : WeatherModel)
}
class WeatherManager  {
    var delegate : WeatherManagerDelegate?
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=02f943ab7b5840579d4d763fe687ec76&units=metric"
    func fetchWeather(city : String) {
        let urlString = weatherUrl+"&q="+city
        performRequest(urlString: urlString)
    }
    func fetchWeather(latitude: CLLocationDegrees, longitude :  CLLocationDegrees){
        let urlString = weatherUrl+"&lat=\(latitude)"+"&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handle(data:responce:error:))
            task.resume()
        }
    }
    func handle (data : Data?,responce : URLResponse?,error : Error?){
        if error != nil{
            print (error!)
            return
        }
        print(responce!)
        if let safeData = data {
            if let weather = parseJson(weatherData: safeData)
            {
                delegate?.didUpdateWeather(weather: weather)
            }
        }
    }
    func parseJson(weatherData : Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weather  = WeatherModel(conditionID: decodedData.weather[0].id, cityName: decodedData.name, temperature: decodedData.main.temp)
            return weather
        }catch{
            print(error)
            return nil
        }
    }
    
}
