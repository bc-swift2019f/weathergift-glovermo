//
//  DetailVC.swift
//  WeatherGift
//
//  Created by Morgan Glover on 10/9/19.
//  Copyright © 2019 Morgan Glover. All rights reserved.
//

import UIKit
import CoreLocation

class DetailVC: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationsLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    var currentPage = 0
    var locationsArray = [WeatherLocation]()
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentPage != 0 {
            self.locationsArray[currentPage].getWeather {
                self.updateUserInterface()
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentPage == 0 {
            getLocation()
        }
    }
    
    func updateUserInterface() {
        locationsLabel.text = locationsArray[currentPage].name
        temperatureLabel.text = locationsArray[currentPage].currentTemp
        summaryLabel.text = locationsArray[currentPage].dailySummary
    }


}

extension DetailVC: CLLocationManagerDelegate {
    func getLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func handleLocationAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied:
            // Alert user
            print("I'm sorry - can't show location. User has not authorized it.")
        case .restricted:
            // Alert user
            print("Access denied - likely parental controls are restricting location services in this app.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geoCoder = CLGeocoder()
        var place = ""
        currentLocation = locations.last
        let currentLatitude = currentLocation.coordinate.latitude
        let currentLongitude = currentLocation.coordinate.longitude
        let currentCoordinates = "\(currentLatitude),\(currentLongitude)"
        print(currentCoordinates)
        
        var placemark: CLPlacemark?
        
        geoCoder.reverseGeocodeLocation(currentLocation, completionHandler:
            {placemarks, error in
                if placemarks != nil {
                    placemark = placemarks!.last
                    place = (placemark?.name)!
                } else {
                    print("Error retreiving place. Error code: \(error!)")
                    place = "Unknown Weather Location"
                }
                self.locationsArray[0].name = place
                self.locationsArray[0].coordinates = currentCoordinates
                self.locationsArray[0].getWeather {
                    self.updateUserInterface()
                }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("failed to get user location")
    }
}
