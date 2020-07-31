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
    
    var cityNames = cityNamesArray
    var filteredCityNames = [String]()
    
    
    var searchedCityName:String?
    var isSearching:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //SearchBar Delegate methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != nil{
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
        let cell = tableView.dequeueReusableCell(withIdentifier:tableCell) as! WeatherTableViewCell
        if isSearching{
            cell.cityName.text = filteredCityNames[indexPath.row]
        } else {
            cell.cityName.text = cityNames[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedCityName:String = ""
        if isSearching {
             selectedCityName = filteredCityNames[indexPath.row]
            print("Seleted City Name: \(selectedCityName)")
        } else {
            selectedCityName = cityNames[indexPath.row]
            print("Seleted City Name: \(selectedCityName)")
        }
        
        let detailView = storyboard?.instantiateViewController(identifier: keyDetailReportVC) as! DetailedReport
        
        detailView.selectedCityName = selectedCityName
        self.navigationController?.pushViewController(detailView, animated: true)
        
    }
}


