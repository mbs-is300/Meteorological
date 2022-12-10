//
//  Django_ViewController.swift
//  NCM
//
//  Created by Meshal Alsallami on 08/12/2022.
//

import UIKit
import CoreLocation

class Django_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Static Variables
    static var user_ID = 0
    static var count = 0
    
    // MARK: - Classes
    let weather = Weather.self
    var widgeticons = Widgeticons()
    var metoData: MeteomaticsData = MeteomaticsData()
    var date = Date()
    
    var django = [Django]()
    var cities = [Cities]()
    var user_cities = [User_Cities]()
    var filtered_user_cities = [User_Cities]()
    
    // MARK: - Variables
    var parameters = ["t_max_2m_24h:C","t_min_2m_24h:C","weather_symbol_24h:idx","t_2m:C","precip_1h:mm","wind_speed_10m:ms","wind_dir_10m:d","weather_symbol_1h:idx"] //weather_symbol_24h:idx  or  weather_symbol_1h
    
    var latitude = [21.48817996],   longitude = [39.18094995], city_eng = [""], now_weather_desc = [""]
    
    static var didAppearFirstTime = true
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tabelView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await load_user_cities()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Django_ViewController.didAppearFirstTime {
            Django_ViewController.didAppearFirstTime = false
            
        } else {
            Task {
                await load_user_cities()
            }
        }
        
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
        search_ViewController.user_ID = Django_ViewController.user_ID
        search_ViewController.user_ID = Django_ViewController.user_ID
        
        if identifier == "city" {
            let viewController = Utilities.vc(to: "create_city_ViewController")
            navigationController?.pushViewController(viewController, animated: true)
            
        }
        if identifier == "all_cities" {
            let viewController = Utilities.vc(to: "search_ViewController")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if identifier == "daily_weather" {
            let viewController = Utilities.vc(to: "Coordinate_Information_ViewController")
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func btnClicked(_ sender: UIBarButtonItem) {
        create_city_ViewController.saveType = "POST"
        performSegue(withIdentifier: "all_cities", sender: nil)
    }
    
    
    func load_user_cities() async {
        // MARK: - function to get all cities
        city_eng.removeAll()
        self.longitude.removeAll()
        self.latitude.removeAll()
        self.now_weather_desc.removeAll()
        Weather.dayWeather.image_path?.removeAll()
        Weather.dayWeather.image.removeAll()
        Weather.dayWeather.description.removeAll()
        Weather.dayWeather.minimum_temperature.removeAll()
        Weather.dayWeather.maximum_temperature.removeAll()
        filtered_user_cities.removeAll()
        
        guard let url = URL(string: "http://127.0.0.1:8000/weather/users_cities/") else {
            print("api is down")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("Basic bWVzaGFsYWxzYWxsYW1pOk1iMTIzNDU2", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print(response!)
            if let data = data {
                if let response = try?
                    JSONDecoder().decode([User_Cities].self, from: data) {
                    DispatchQueue.main.async {
                        
                        self.user_cities = response
                        
                        for city in self.user_cities {
                            
                            
                            if city.user_id == Django_ViewController.user_ID {
                                self.filtered_user_cities.append(city)
                                self.city_eng.append(city.nameEN!)
                                self.latitude.append(Double(city.latitude!)!)
                                self.longitude.append(Double(city.longitude!)!)
                            }
                            
                        }
                        print("TEST \(self.latitude)")
                        print("TEST \(self.longitude)")
                        Task {
                            print("TEST All cities count --> \(self.filtered_user_cities.count)") //////////
                            await self.weather.getWeather(latitude:self.latitude,longitude: self.longitude)
                            Task {
                                await self.setupTable()
                            }
                        }
                        
                    }
                    return
                }
            }
        }.resume()
        print("TEST All cities userID --> \(Django_ViewController.user_ID)")
    }
    
    // MARK: - Delete
    func delete(selectedID: Int) async{
        
        guard let url = URL(string: "http://127.0.0.1:8000/weather/users_cities/\(selectedID)/") else {
            print("api is down")
            return
        }
        var  urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("Basic bWVzaGFsYWxzYWxsYW1pOk1iMTIzNDU2", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print(response!)
            if let data = data {
                DispatchQueue.main.async {
                    print("\(data)")
                    print("Delete")
                    Task{
                        await self.load_user_cities()
                    }
                }
                return
            }
        }.resume()
    }
}



extension Django_ViewController {
    // MARK: - Helpers funcs
    
    func setupTable() async{
        tabelView.delegate = self
        tabelView.dataSource = self
        let nib = UINib(nibName: "dailyWeather_TableViewCell", bundle: nil)
        tabelView.register(nib, forCellReuseIdentifier: "dailyWeather_TableViewCell")
        tabelView.backgroundColor = .white
        tabelView.rowHeight = 100
        tabelView.reloadData()
    }
    
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let img = UIImage(data: data) {
                completion(img)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

// MARK: - TableView funcs

extension Django_ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("TEST tabel count = \(filtered_user_cities.count)")
        return filtered_user_cities.count // latitude.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyWeather_TableViewCell", for: indexPath) as! dailyWeather_TableViewCell
        
        if indexPath.row < city_eng.count {
            
            cell.city_lbl.text = city_eng[indexPath.row]
            cell.high_lbl.text = "\(weather.dayWeather.maximum_temperature[indexPath.row])°"
            cell.low_lbl.text = "\(weather.dayWeather.minimum_temperature[indexPath.row])°"
            if indexPath.row < weather.dayWeather.image.count {
                cell.img.image = weather.dayWeather.image[indexPath.row]
            }
            cell.desc_lbl.text = weather.dayWeather.description[indexPath.row]
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let selected_row_id = Int(self.filtered_user_cities[indexPath.row].id!)
        if editingStyle == .delete {
            Task{
                print("test buttonAction \(selected_row_id)")
                await delete(selectedID: selected_row_id)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Need to move below to another view
        let view = create_city_ViewController.self
        
        view.saveType = "PUT"
        view.oldID = filtered_user_cities[indexPath.row].id!
        view.user_ID = filtered_user_cities[indexPath.row].user_id!
        view.oldCityID = filtered_user_cities[indexPath.row].cityID!
        view.oldRegionID = filtered_user_cities[indexPath.row].regionID!
        view.oldNameEN = filtered_user_cities[indexPath.row].nameEN!
        view.oldNeameAR = filtered_user_cities[indexPath.row].nameAR!
        view.oldLatitude = filtered_user_cities[indexPath.row].latitude!
        view.oldLongitude = filtered_user_cities[indexPath.row].longitude!
        
        //performSegue(withIdentifier: "city", sender: nil) <<<<< remove comment after move
        // END to move
        
        // MARK: TO DO: when the user select a row in the table
        
        // MARK: below to make sure all the Arrays are nil
        weather.hourWeather.wind_direction.removeAll()
        weather.hourWeather.wind_speed.removeAll()
        weather.hourWeather.precipitation.removeAll()
        weather.hourWeather.description.removeAll()
        weather.hourWeather.temperature.removeAll()
        weather.hourWeather.image.removeAll()
        weather.hourWeather.image_path?.removeAll()
        
        // MARK: loading the data
        
        var lat:[CLLocationDegrees] = [], lon:[CLLocationDegrees] = []
        lat.append(Double(filtered_user_cities[indexPath.row].latitude!)!)
        lon.append(Double(filtered_user_cities[indexPath.row].longitude!)!)
        
        Task{
            await Weather.getHourWeather(latitude:lat,longitude: lon)
            Coordinate_Information_ViewController.temp = weather.hourWeather.temperature[0]
            Coordinate_Information_ViewController.winDir = weather.hourWeather.wind_direction[0]
            Coordinate_Information_ViewController.winSpeed = weather.hourWeather.wind_speed[0]
            Coordinate_Information_ViewController.pre = String(weather.hourWeather.precipitation[0])
            Coordinate_Information_ViewController.temp = weather.hourWeather.temperature[0]
            Coordinate_Information_ViewController.desc = weather.hourWeather.description[0]
            
            performSegue(withIdentifier: "daily_weather", sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
