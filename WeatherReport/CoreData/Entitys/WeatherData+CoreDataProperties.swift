//
//  WeatherData+CoreDataProperties.swift
//  WeatherReport
//
//  Created by Penchal on 31/07/20.
//  Copyright © 2020 senix.com. All rights reserved.
//

import Foundation
import CoreData


extension WeatherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherData> {
        return NSFetchRequest<WeatherData>(entityName: "WeatherData")
    }

    @NSManaged public var location: String?
    @NSManaged public var temperature: String?
    @NSManaged public var weather: String?
    @NSManaged public var weatherDescription: String?
    @NSManaged public var windSpeed: String?
    @NSManaged public var humidity: String?
    @NSManaged public var icon: String?

}
