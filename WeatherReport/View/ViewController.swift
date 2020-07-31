//
//  ViewController.swift
//  WeatherReport
//
//  Created by Penchal on 29/07/20.
//  Copyright © 2020 senix.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    
    @IBOutlet weak var weatherReportTable: UITableView!
    @IBOutlet weak var citySearchBar: UISearchBar!
    
    //Top Indian Cities
    
    var cityNames = ["Agra","Ahmedabad","Allahabad","Amritsar","Bengaluru","Bhopal","Chennai","Coimbatore","Cuttack","Delhi","Faridabad","Guntur","Gurgaon","Guwahati","Hyderabad","Indore","Jaipur","Jammu","Kanpur","Kochi","Kolkata","Lucknow","Mangalore","Meerut","Mumbai","Mysore","Nagpur","Nashik","Noida","Patna","Pimpri","Pune","Raipur","Ranchi","Srinagar","Surat","Thane","Thiruvananthapuram","Vadodara","Varanasi","Vijayawada","Visakhapatnam"]
    
    var filteredCityNames = [String]()
    
    
    var searchedCityName:String?
    var isSearching:Bool = false
    let weatherReport = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //SearchBar Delegate methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let input = searchBar.text{
            isSearching = true
        } else {
            isSearching = false
        }
        filteredCityNames = cityNames.filter({ (aCity) -> Bool in
            aCity.lowercased().hasPrefix(searchBar.text?.lowercased() ?? "".lowercased())
        })
        weatherReportTable.reloadData()
    }
    
    
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           citySearchBar.resignFirstResponder()
           if let searchedString = searchBar.text, !searchedString.isEmpty{
               self.searchedCityName = searchedString
           }
       }
    
    //TableView delegate and DataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return filteredCityNames.count
        } else {
            return cityNames.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as! WeatherTableViewCell
        if isSearching{
            cell.cityName.text = filteredCityNames[indexPath.row]
        } else {
            cell.cityName.text = cityNames[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCityName:String = ""
        if isSearching{
            let selectedCityName = filteredCityNames[indexPath.row]
            print("Seleted City Name: \(selectedCityName)")
        } else {
            let selectedCityName = cityNames[indexPath.row]
            print("Seleted City Name: \(selectedCityName)")
        }

        weatherReport.getLocationWeatherReport(location: selectedCityName) { (weatherObject) in
            print("Fetched Location Weather Report")
            print(weatherObject)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let DetailedReportVC = storyboard.instantiateViewController(withIdentifier: "DetailedReport") as? DetailedReport{
            present(DetailedReportVC, animated:true, completion: nil)
        }
        
        
        
        
        //Transfer Data
    }
}


