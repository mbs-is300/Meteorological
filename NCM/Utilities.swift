//
//  Utilities.swift
//  NCM
//
//  Created by Meshal Alsallami on 03/12/2022.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        let bottomLine = CALayer() // Create the bottom line
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 208/255, green: 132/255, blue: 152/255, alpha: 1).cgColor
        textfield.borderStyle = .none // Remove border on text field
        textfield.layer.addSublayer(bottomLine) // Add the line to the text field
    }
    
    static func styleButton(_ button:UIButton) {
        button.frame.size.height = 44
        button.backgroundColor = UIColor.init(red: 208/255, green: 132/255, blue: 152/255, alpha: 1)
        button.layer.cornerRadius = 10 // Filled rounded corner style
        button.tintColor = UIColor.white
    }
    

    
    static func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func vc (to identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as UIViewController
        return viewController
    }
    
  
    
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        //let scale = newWidth / image.size.width
        let newHeight = newWidth //image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    static func resize(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    static func makeTable(TableView: UITableView, Nib: String) {
        let nib = UINib(nibName: Nib, bundle: nil)
        TableView.register(nib, forCellReuseIdentifier: Nib)
        TableView.backgroundColor = .white
    }
    
    static func showAlert (Title: String, Message: String) -> UIAlertController {
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { action in
            print("OK")
        }))
        return alert
    }
    
    
}
