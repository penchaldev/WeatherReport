//
//  DetailedReport.swift
//  WeatherReport
//
//  Created by Penchal on 30/07/20.
//  Copyright © 2020 senix.com. All rights reserved.
//

import UIKit

class DetailedReport: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var selectedLocation: UILabel!
    @IBOutlet weak var selectedLocationTemp: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    var locationReport:WeatherInfo?
    
    var selectedCityName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Reachability.isConnectedToNetwork() {
            serverCalls()
        }else {
           fetchDataFromDatabase()
        }
    }
    
    func serverCalls() {
        showActivityIndicator(progressLabel: "Fetching Data")
        WRNetworkManager.getServiceCall(location: selectedCityName) { (weatherObject) in
            self.locationReport = weatherObject
            print("Fetched Location Weather Report: \(weatherObject)")
            self.hideActivityIndicator()
            self.displayWeatherReport()
        }
        
    }
    func displayWeatherReport() {
        DispatchQueue.main.async {
            
            self.selectedLocation.text = self.locationReport?.name
            let weatherIconID:String = self.locationReport?.weather[0].icon ?? ""
            self.weatherIcon.image = UIImage(named:weatherIconID)
            self.weatherCondition.text = "Weather: \(self.locationReport?.weather[0].main ?? "")"
            self.weatherDescription.text = self.locationReport?.weather[0].weatherDescription ?? ""
            
            if let temperature = self.locationReport?.main.temp {
                self.selectedLocationTemp.text = " \(Int(temperature - 273.15)) C"
            }
            if let windSpeed = self.locationReport?.wind.speed {
                self.windSpeed.text = "WindSpeed: \(windSpeed) km/h"
            }
            if let humidity = self.locationReport?.main.humidity {
                self.humidity.text = "Humidity:\(humidity) %"
            }
            
            var whetherModel = WeatherDataModel()
            whetherModel.location           = self.selectedLocation.text
            whetherModel.temperature        = self.selectedLocationTemp.text
            
            whetherModel.weather            = self.weatherCondition.text
            whetherModel.weatherDescription = self.weatherDescription.text
            whetherModel.windSpeed          = self.windSpeed.text
            whetherModel.humidity           = self.humidity.text
            whetherModel.icon               = weatherIconID
            CoreDataHelper.saveDataAndUpdateData(userData: whetherModel)
        }
    }
    
    func fetchDataFromDatabase() {
        
        if let dataInfo = CoreDataHelper.fetchWhetherData(location: selectedCityName) {
            
            print("offlineData:\(dataInfo)")
            self.selectedLocation.text            = dataInfo.location
            self.selectedLocationTemp.text        = dataInfo.temperature
            self.weatherCondition.text            = dataInfo.weather
            self.weatherDescription.text          = dataInfo.weatherDescription
            self.windSpeed.text                   = dataInfo.windSpeed
            self.humidity.text                    = dataInfo.humidity
            self.weatherIcon.image                = UIImage(named:dataInfo.icon!)
        }else {
            print("Offline data not available For Location: \(selectedCityName)")
        }
        
    }
}

   
