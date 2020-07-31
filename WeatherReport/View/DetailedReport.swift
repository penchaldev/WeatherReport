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
    
    
    var location:String = ""
    var locationTemp:Double = 0
    var iconID:String = ""
    var wrCondition:String = ""
    var wrDescription:String = ""
    var airSpeed:Int = 0
    var humidityValue:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWeatherReport()
    }
        
    func displayWeatherReport(){
        selectedLocation.text = location
        selectedLocationTemp.text = String(locationTemp)
        weatherIcon.image = UIImage(named:iconID)
        weatherCondition.text = wrCondition
        weatherDescription.text = wrDescription
        windSpeed.text = String(airSpeed)
        humidity.text = String(humidityValue)
    }
}
