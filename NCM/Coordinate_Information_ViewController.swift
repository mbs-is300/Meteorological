//
//  Coordinate_Information_ViewController.swift
//  NCM
//
//  Created by Meshal Alsallami on 03/12/2022.
//

import UIKit

class Coordinate_Information_ViewController: UIViewController {

    static var city = "", winDir = 0.00, winSpeed = 0.00, pre = "", img = UIImage(), temp = 0.00, img_url = "", desc = ""
    
    @IBOutlet weak var city_lbl: UILabel!
    @IBOutlet weak var winDir_lbl: UILabel!
    @IBOutlet weak var winSpeed_lbl: UILabel!
    @IBOutlet weak var Pre_lbl: UILabel!
    @IBOutlet weak var img_view: UIImageView!
    @IBOutlet weak var temp_lbl: UILabel!
    @IBOutlet weak var desc_lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = URL(string: Coordinate_Information_ViewController.img_url)!
        //if let data = try? Data(contentsOf: url) {img_view.image = UIImage(data: data)}
        
        Task {
            await getImage(url: url) { image in
                self.img_view.image = image
            }
        }

        city_lbl.text = Coordinate_Information_ViewController.city
        
        let direction =  windDirectionFromDegrees(degrees: Coordinate_Information_ViewController.winDir)

        desc_lbl.text = Coordinate_Information_ViewController.desc
        winDir_lbl.text = "Wind Direction: \(direction)"
        winSpeed_lbl.text = "Wind Speed: \(Coordinate_Information_ViewController.winSpeed) Km/h"
        Pre_lbl.text = "Rain Precipitation: \(Coordinate_Information_ViewController.pre) mm"
        temp_lbl.text = "\(Coordinate_Information_ViewController.temp)°"
    }

    // MARK: - func to get wind directions
    func windDirectionFromDegrees(degrees : Double) -> String {
        
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let i: Int = Int((degrees + 11.25)/22.5)
        return directions[i % 16]
    }
    
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void) async {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let img = UIImage(data: data) {
                completion(img)
            } else {
                completion(nil)
            }
        }.resume()
    }
   }




