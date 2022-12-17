//
//  Weather.swift
//  NCM
//
//  Created by Meshal Alsallami on 04/12/2022.
//

import UIKit
import Alamofire
import CoreLocation

class Weather: UIViewController {
    
    // MARK: - Classes
    static var widgeticons = Widgeticons()
    static var metoData: MeteomaticsData = MeteomaticsData()
    
    // MARK: - Variables
    
    static var parameters = ["t_max_2m_24h:C",
                      "t_min_2m_24h:C",
                      "weather_symbol_24h:idx",
                             "t_2m:C",
                      "precip_1h:mm",
                             "wind_speed_10m:ms",
                      "wind_dir_10m:d",
                      "weather_symbol_1h:idx"]
        
    static var user = "x_alsallami",    password = "F52mtiM0Vz"
    
    struct dayWeather {
        static var maximum_temperature: [Int] = []
        static var minimum_temperature: [Int] = []
        static var description: [String] = []
        static var image_path: String?
        static var image: [UIImage] = []
    }
    
    struct hourWeather {
        static var temperature: [Double] = []
        static var description: [String] = []
        static var precipitation: [Double] = []
        static var wind_speed: [Double] = []
        static var wind_direction: [Double] = []
        
        
        static var image_path: String?
        static var image: [UIImage] = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    static func getWeather(latitude: [CLLocationDegrees], longitude: [CLLocationDegrees]) async {
        
        print("Class weather & func weather")

        for i in 0..<latitude.count {
            
            let meteo = Meteomatics(forDate: Date(), parameters: parameters, latitude: latitude[i], longitude: longitude[i], user: user, password: password)
            
            do {
                metoData = try await meteo.fetchWeather()
            } catch {
                print(error)
            }

            dayWeather.maximum_temperature.append(Int(metoData.data[0].coordinates[0].dates[0].value))
            dayWeather.minimum_temperature.append(Int(metoData.data[1].coordinates[0].dates[0].value))

            let day_id = Int(metoData.data[2].coordinates[0].dates[0].value)
            let day_icon = widgeticons.getWeatherIcon(ID: day_id)
            let day_path = "https://static.meteomatics.com/widgeticons/\(day_icon.first!)"
            dayWeather.image_path = day_path
            dayWeather.description.append(day_icon.last!)

            let day_url = URL(string: dayWeather.image_path!)
            
            DispatchQueue.main.async {
                
                Utilities.getImage(url: day_url!) { image in
                    dayWeather.image.append(image!)
                }
            }
        }
    }
    
    static func getHourWeather(latitude: [CLLocationDegrees], longitude: [CLLocationDegrees]) async {
        
        print("Class weather & func hour weather")

        for i in 0..<latitude.count {
            
            let meteo = Meteomatics(forDate: Date(), parameters: parameters, latitude: latitude[i], longitude: longitude[i], user: user, password: password)
            
            do {
                metoData = try await meteo.fetchWeather()
            } catch {
                print(error)
            }

            hourWeather.temperature.append(metoData.data[3].coordinates[0].dates[0].value)
            hourWeather.precipitation.append(metoData.data[4].coordinates[0].dates[0].value)
            hourWeather.wind_speed.append(metoData.data[5].coordinates[0].dates[0].value)
            hourWeather.wind_direction.append(metoData.data[6].coordinates[0].dates[0].value)
            
            let hour_id = Int(metoData.data[7].coordinates[0].dates[0].value)
            let hour_icon = widgeticons.getWeatherIcon(ID: hour_id)
            let hour_path = "https://static.meteomatics.com/widgeticons/\(hour_icon.first!)"
            hourWeather.image_path = hour_path
            hourWeather.description.append(hour_icon.last!)
            print("Hour img path: \(hourWeather.image_path!)")

            let hour_url = URL(string: hourWeather.image_path!)
            print("hour img url: \(hour_url!.absoluteString)")
            Coordinate_Information_ViewController.img_url = hour_path
            
            Utilities.getImage(url: hour_url!) { image in
                hourWeather.image.append(image!)
            }
        }
    }
}
