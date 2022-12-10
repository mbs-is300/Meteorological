//
//  search_ViewController.swift
//  NCM
//
//  Created by Meshal Alsallami on 05/12/2022.
//

import UIKit

class search_ViewController: UIViewController {
    
    // MARK: - Static Variables
    static var user_ID = 0

    // MARK: - Classes

    let weather = Weather.self

    
    var cities = [Cities]()
    
    // MARK: - Arrays

    var citiesData:[String] = Array()
    var filteredData:[String] = Array()
    
    var latData:[Double] =  Array()
    var seleced_lat_array:[Double] = Array()

    var lonData:[Double] =  Array()
    var seleced_lon_array:[Double] = Array()


    var cityID: [Int] = Array()
    var seleced_cityID: [Int] = Array()

    
    var regionID: [Int] = Array()
    var seleced_regionID: [Int] = Array()

    
    var nameAR: [String] = Array()
    var seleced_nameAR: [String] = Array()

    
    var nameEN: [String] = Array()
    var seleced_nnameEN: [String] = Array()

    

    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        let viewController = Utilities.vc(to: "create_city_ViewController")
        create_city_ViewController.user_ID = search_ViewController.user_ID

        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "search_TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "search_TableViewCell")
        tableView.backgroundColor = .white
        getAllCities()


        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44.0

        searchBar.delegate = self
    }
    
    func getAllCities() {

        
        let service = Cities_Service(baseUrl: "https://raw.githubusercontent.com/homaily/Saudi-Arabia-Regions-Cities-and-Districts/master/json/")
        
        service.getAll(endPoint: "cities.json")
        
        service.completionHandler { [weak self] (data, status, message) in
            if status {
                guard let self = self else {return}
                guard let cities_data = data else {return}
                
                self.cities = cities_data
                
                for i in 0..<cities_data.count
                {
                    self.citiesData.append(self.cities[i].nameEN!)
                    self.cityID.append(self.cities[i].cityID!)
                    self.regionID.append(self.cities[i].regionID!)
                    self.nameAR.append(self.cities[i].nameAR!)
                    self.nameEN.append(self.cities[i].nameEN!)
                    self.latData.append((self.cities[i].centerCoordinate?.first)!)
                    self.lonData.append((self.cities[i].centerCoordinate?.last)!)
                }
                print("TEST citiesData Array count = \(self.citiesData.count)")
                print("TEST cityID Array count = \(self.cityID.count)")
                print("TEST cityregionIDID Array count = \(self.regionID.count)")
                print("TEST nameAR Array count = \(self.nameAR.count)")
                print("TEST nameEN Array count = \(self.nameEN.count)")
                print("TEST latData Array count = \(self.latData.count)")
                print("TEST lonData Array count = \(self.lonData.count)")

                self.filteredData = self.citiesData
                
                self.tableView.reloadData()
            } // of: IF status
        } // of: service.completionHandler
    }
}

extension search_ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "search_TableViewCell", for: indexPath) as! search_TableViewCell
        cell.city.text = filteredData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = create_city_ViewController.self

        seleced_cityID.removeAll()
        seleced_regionID.removeAll()
        seleced_nnameEN.removeAll()
        seleced_nameAR.removeAll()
        seleced_lat_array.removeAll()
        seleced_lon_array.removeAll()
        
        let selected = filteredData[indexPath.row]
        print(selected)

        var index = 0
        for city in citiesData {
            index += 1
            if city == selected {
                print(city)
                print(index)
                let selected_city = cityID[index-1]
                let selected_region = regionID[index-1]
                let selected_EN = nameEN[index-1]
                let selected_AR = nameAR[index-1]
                let selected_lat = latData[index-1]
                let selected_lon = lonData[index-1]
                
                print("TEST selected \(selected_city)")
                print("TEST selected \(selected_region)")
                print("TEST selected \(selected_EN)")
                print("TEST selected \(selected_AR)")
                print("TEST selected \(selected_lat)")
                print("TEST selected \(selected_lon)")


                seleced_cityID.append(selected_city)
                seleced_regionID.append(selected_region)
                seleced_nnameEN.append(selected_EN)
                seleced_nameAR.append(selected_AR)
                seleced_lat_array.append(selected_lat)
                seleced_lon_array.append(selected_lon)
                
                cell.oldCityID = selected_city
                cell.oldRegionID = selected_region
                cell.oldNameEN = selected_EN
                cell.oldNeameAR = selected_AR
                cell.oldLatitude = String(selected_lat)
                cell.oldLongitude = String(selected_lon)
                // get weather from here
                weather.hourWeather.wind_direction.removeAll()
                weather.hourWeather.wind_speed.removeAll()
                weather.hourWeather.precipitation.removeAll()
                weather.hourWeather.description.removeAll()
                weather.hourWeather.temperature.removeAll()
                weather.hourWeather.image.removeAll()
                weather.hourWeather.image_path?.removeAll()
                
                performSegue(withIdentifier: "add_city_from_search", sender: nil)
                break
            }
        }

    }
    
}

extension search_ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if searchText == "" {
            filteredData = citiesData
        }
        
        for word in citiesData {
            if word.uppercased().contains(searchText.uppercased()) {
                filteredData.append(word)
            }
        }
        
        tableView.reloadData()
    }
}
