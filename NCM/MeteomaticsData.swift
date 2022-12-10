//
//  MeteomaticsData.swift
//  NCM
//
//  Created by Meshal Alsallami on 01/12/2022.
//

import Foundation

struct MeteomaticsData: Codable {
    var version = ""
    var user = ""
    var dateGenerated = ""
    var status = ""
    var data: [Datum] = [Datum(parameter: "t2mc", coordinates: [Coordinate(lat: 0.0, lon: 0.0, dates: [DateElement(date: "", value: 0.0)])])]
}

// MARK: - Datum
struct Datum: Codable {
    let parameter: String
    let coordinates: [Coordinate]
}

// MARK: - Coordinate
struct Coordinate: Codable {
    let lat, lon: Double
    let dates: [DateElement]
}

// MARK: - DateElement
struct DateElement: Codable {
    let date: String
    let value: Double
}

