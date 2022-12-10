//
//  Auth_ViewController.swift
//  NCM
//
//  Created by Meshal Alsallami on 09/12/2022.
//

import UIKit

class Auth_ViewController: UIViewController {

    @IBOutlet weak var userName_tf: UITextField!
    @IBOutlet weak var password_tf: UITextField!
    
    var users = [Users]()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "http://127.0.0.1:8000/weather/users/") else {
            print("api is down")
            return
        }
        Task {
            await load_users(url: url, httpMethod: "GET")
        }
    }
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        let viewController = Utilities.vc(to: "Django_ViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func Action(_ sender: UIButton) {
        
        for user in users {
            
            if userName_tf.text == user.user_name && password_tf.text == user.password {
                
                print("TEST id \(user.id!) \(user.user_name!) && password: \(user.password!)")
                
                Django_ViewController.user_ID = user.id!

                performSegue(withIdentifier: "login", sender: nil)

            } else {
                print("test user not found")
            }
            
        }
    }
    
    func load_users(url: URL, httpMethod: String) async {
        
        var  urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("Basic bWVzaGFsYWxzYWxsYW1pOk1iMTIzNDU2", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            //print(response!)
            if let data = data {
                if let response = try?
                    JSONDecoder().decode([Users].self, from: data) {
                    DispatchQueue.main.async {
                        self.users = response
                    }
                    return
                }
            }
        }.resume()
    }
}
