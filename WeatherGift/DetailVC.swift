//
//  DetailVC.swift
//  WeatherGift
//
//  Created by Morgan Glover on 10/9/19.
//  Copyright © 2019 Morgan Glover. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationsLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    var currentPage = 0
    var locationsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationsLabel.text = locationsArray[currentPage]

    }


}
