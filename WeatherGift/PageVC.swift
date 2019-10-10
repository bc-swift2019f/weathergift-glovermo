//
//  PageVC.swift
//  WeatherGift
//
//  Created by Morgan Glover on 10/9/19.
//  Copyright © 2019 Morgan Glover. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {
    
    var currentPage: Int = 0
    var locationsArray = ["Local City Weather",
                          "Chestnut Hill, MA",
                          "Sydney, Australia",
                          "Accra, Ghana",
                          "Uglich, Russia"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        setViewControllers([createDetailVC(forPage: 0)], direction: .forward, animated: false, completion: nil)

    }
    
    func createDetailVC(forPage page: Int) -> DetailVC {
        currentPage = min(max(0, page), locationsArray.count-1)
        let detailVC = storyboard!.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        detailVC.currentPage = currentPage
        detailVC.locationsArray = locationsArray
        return detailVC
    }

    


}

extension PageVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        //is this a DetailVC?
        if let currentViewController = viewController as? DetailVC {
            if currentViewController.currentPage < locationsArray.count - 1 {
                return createDetailVC(forPage: currentViewController.currentPage + 1)
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let currentViewController = viewController as? DetailVC {
            if currentViewController.currentPage > 0 {
                return createDetailVC(forPage: currentViewController.currentPage - 1)
            }
        }
        
        return nil
    }
    
}
