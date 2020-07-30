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
    func getUserDetails(){
        //let baseURL = "https://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=e181a0a14e563ab781303d7d190ebb90"
        let baseUrl = "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02"
        
        let url = URL(string: baseUrl)
        let urlRequest = URLRequest(url: url!)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil{
                print("Got error for API Call \(String(describing: error))")
            }
            print(data)
            guard let data = data else {return}
            do {
                let welcome = try? JSONDecoder().decode(Welcome.self, from: data)
                if let wecomeResponse = welcome{
                    print(wecomeResponse)
                }
            }catch{
                print("Error occured while parsing the data\(error)")
            }
        }
        task.resume()
    }
}
