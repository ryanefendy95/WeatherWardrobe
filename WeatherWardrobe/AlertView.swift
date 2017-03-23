//
//  AlertView.swift
//  WeatherWardrobe
//
//  Created by Allen Lai on 3/23/17.
//  Copyright © 2017 Allen Lai. All rights reserved.
//

import Foundation
import UIKit

open class AlertViews {


    static func showAlertDelete(parentVC: UIViewController, yesCompletion: @escaping ()-> Void) {
        
        let alert = UIAlertController(title: "Are you sure you want to delete this?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            yesCompletion()
        }
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        parentVC.present(alert, animated: true, completion: nil)
        
        
    }
    


}
