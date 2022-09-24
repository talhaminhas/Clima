//
//  WeatherData.swift
//  Clima
//
//  Created by Minhax on 27/03/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
struct WeatherData: Decodable {
    let name : String
    let main : Main
    let weather : [Weather]
}
struct Main : Decodable{
    let temp : Double
}
struct Weather:Decodable {
    let id :Int
    let description : String
}
