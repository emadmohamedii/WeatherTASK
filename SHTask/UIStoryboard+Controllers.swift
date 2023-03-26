//
//  UIStoryboard+Controllers.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//


import Foundation
import UIKit

extension UIStoryboard {

    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

}


extension UIStoryboard {
    
    var weatherHomeViewController: WeatherHomeViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: WeatherHomeViewController.self)) as? WeatherHomeViewController else {
            fatalError(String(describing: WeatherHomeViewController.self) + "\(NSLocalizedString("couldn't be found in Storyboard file", comment: ""))")
        }
        return viewController
    }
    
    var weatherLocationsViewController: WeatherLocationsViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: WeatherLocationsViewController.self)) as? WeatherLocationsViewController else {
            fatalError(String(describing: WeatherLocationsViewController.self) + "\(NSLocalizedString("couldn't be found in Storyboard file", comment: ""))")
        }
        return viewController
    }

    
    
}
