//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Morgan Glover on 10/26/19.
//  Copyright © 2019 Morgan Glover. All rights reserved.
//

import Foundation

class WeatherLocation: Codable {
    
    var name: String
    var coordinates: String
    
    init(name: String, coordinates: String) {
        self.name = name
        self.coordinates = coordinates
    }
}
