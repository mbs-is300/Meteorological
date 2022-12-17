//
//  Cities_Service.swift
//  NCM
//
//  Created by Meshal Alsallami on 01/12/2022.
//

import Foundation
import Alamofire

class Cities_Service {
    
    typealias citiesCallBack = (_ cities:[Cities]?, _ status: Bool, _ message:String) -> Void

    var callBack:citiesCallBack?

    fileprivate var baseUrl = ""
    
    //MARK: init
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    // MARK: - Func to get all cities online from github
    func getAll(endPoint:String) {
        
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            
            print("We got response")
            
            guard let data = responseData.data else {
            
                self.callBack?(nil, false, "")

                return}
            
            do {
                
            let cities = try JSONDecoder().decode([Cities].self, from: data)
                
                self.callBack?(cities, true,"")
                
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
            
        }
    }
    
    func completionHandler(callBack: @escaping citiesCallBack) {
        self.callBack = callBack
    }
}
