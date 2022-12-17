//
//  Cities.swift
//  NCM
//
//  Created by Meshal Alsallami on 01/12/2022.
//

import Foundation

struct Cities: Decodable {
    
    var cityID: Int?
    var regionID: Int?
    var nameAR: String?
    var nameEN: String?
    var centerCoordinate: [(Double)]?
    
    enum CodingKeys: String, CodingKey {
        
        case cityID = "city_id"
        case regionID = "region_id"
        case nameAR = "name_ar"
        case nameEN = "name_en"
        case centerCoordinate = "center"
    }
}
