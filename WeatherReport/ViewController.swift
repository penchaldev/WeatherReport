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
    
    var cityNames = [String]()
    var searchedCityName:String?
    let weatherReport = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData(){
        weatherReport.getUserDetails()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        citySearchBar.resignFirstResponder()
        if let searchedString = searchBar.text, !searchedString.isEmpty{
            self.searchedCityName = searchedString
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as! UITableViewCell
        cell.textLabel?.text = searchedCityName
        return cell
        
    }
}

