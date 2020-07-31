//
//  APIManager.swift
//  WeatherReport
//
//  Created by Penchal on 29/07/20.
//  Copyright © 2020 senix.com. All rights reserved.
//

import UIKit

class APIManager {
    let apiKey = "e181a0a14e563ab781303d7d190ebb90"
    func getLocationWeatherReport(location:String, completionHandler:@escaping(WeatherInfo) -> Void){
//        let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=e181a0a14e563ab781303d7d190ebb90"

        let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(location)&APPID=e181a0a14e563ab781303d7d190ebb90"

        let url = URL(string: baseUrl)
        let urlRequest = URLRequest(url: url!)
        
        let session = URLSession.shared
        
        //Fetching data
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil{
                print("Got error for API Call \(String(describing: error))")
            }
//            print(data)
            guard let data = data else {return}
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherInfo.self, from: data)
                    completionHandler(weatherResponse)
            }catch{
                print("Error occured while parsing the data\(error)")
            }
        }
        task.resume()
    }
}
