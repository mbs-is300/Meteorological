//
//  Django.swift
//  NCM
//
//  Created by Meshal Alsallami on 08/12/2022.
//

import Foundation

struct Django: Codable, Identifiable {
    let id: Int?
    var cityID: Int?
    var regionID: Int?
    var nameAR: String?
    var nameEN: String?
    var latitude: String?
    var longitude: String?
}

struct Users: Codable, Identifiable {
    let id: Int?
    var user_name: String?
    var password: String?
}

struct User_Cities: Codable, Identifiable {
    let id: Int?
    var user_id: Int?
    var cityID: Int?
    var regionID: Int?
    var nameAR: String?
    var nameEN: String?
    var latitude: String?
    var longitude: String?
}
