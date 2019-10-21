//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Morgan Glover on 10/18/19.
//  Copyright © 2019 Morgan Glover. All rights reserved.
//

import Foundation
import Alamofire

class WeatherLocation {
    var name = ""
    var coordinates = ""
    
    func getWeater() {
        let weatherURL = urlBase + urlAPIKey + coordinates
        print(weatherURL)
        Alamofire.request(weatherURL).responseJSON { response in
            print(response)
        }

    }
}
