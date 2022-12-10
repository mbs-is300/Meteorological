//
//  create_city_ViewController.swift
//  NCM
//
//  Created by Meshal Alsallami on 09/12/2022.
//

import UIKit

class create_city_ViewController: UIViewController {
        
    @IBOutlet weak var cityID: UITextField!
    @IBOutlet weak var regionID: UITextField!
    @IBOutlet weak var nameEN: UITextField!
    @IBOutlet weak var nameAR: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    
    static var oldID = 0, user_ID = 0, oldCityID = 0, oldRegionID = 0, oldNameEN = "", oldNeameAR = "", oldLatitude = "", oldLongitude = "", selectedID = 0
    
    var cities = [Django]()
    
    static var saveType = ""
    
    var actionType = "", id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id = create_city_ViewController.user_ID
        actionType = create_city_ViewController.saveType
        cityID.text = String(create_city_ViewController.oldCityID)
        regionID.text = String(create_city_ViewController.oldRegionID)
        nameEN.text = create_city_ViewController.oldNameEN
        nameAR.text = create_city_ViewController.oldNeameAR
        latitude.text = create_city_ViewController.oldLatitude
        longitude.text = create_city_ViewController.oldLongitude
        
        if actionType == "PUT" {
            cityID.isEnabled = false; cityID.textColor = UIColor.lightGray
            regionID.isEnabled = false; regionID.textColor = UIColor.lightGray
            nameEN.isEnabled = false; nameEN.textColor = UIColor.lightGray
            nameAR.isEnabled = false; nameAR.textColor = UIColor.lightGray
        }
    }
    
    
    @IBAction func Action(_ sender: UIBarButtonItem) {

        print("TEST Action \(actionType)")

        if actionType == "POST" {
            guard let url = URL(string: "http://127.0.0.1:8000/weather/users_cities/") else {
                print("TEST api is down")
                return
            }
            dohttpMethod(url: url, httpMethod: "POST")
        }
        
        if actionType == "PUT" {
            guard let url = URL(string: "http://127.0.0.1:8000/weather/users_cities/\(create_city_ViewController.oldID)/") else {

                print("TEST api is down")
                return
            }
            print("TEST url \(url)")
            dohttpMethod(url: url, httpMethod: "PUT")
        }

    }
    

    
    func dohttpMethod(url: URL, httpMethod: String) {

        let userCitiesData = User_Cities (id: 0,
                                          user_id: create_city_ViewController.user_ID,
                                          cityID: Int(cityID.text!)!,
                                          regionID: Int(regionID.text!)!,
                                          nameAR: nameAR.text!,
                                          nameEN: nameEN.text!,
                                          latitude: latitude.text!,
                                          longitude: longitude.text!)
        
        
        guard let encoded = try? JSONEncoder().encode(userCitiesData) else {
            print("TEST failed to encode")
            return
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic bWVzaGFsYWxzYWxsYW1pOk1iMTIzNDU2", forHTTPHeaderField: "Authorization")
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {

                if let response = try? JSONDecoder().decode(User_Cities.self, from: data) {
                    DispatchQueue.main.async {
                        print("response \(response) ")
                    }
                    return
                } else {
                    print("TEST POST Error: \(response!)")
                }
            }
        }.resume()
    }
}
