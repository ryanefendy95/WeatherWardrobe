//
//  SettingsTableVC.swift
//  BFN
//
//  Created by Ryan Efendy on 2/01/17.
//  Copyright © 2017 Ryan Efendy. All rights reserved.
//

import UIKit
import MessageUI
import CoreData


class SettingsTableVC: UITableViewController {

    @IBOutlet weak var thresholdLabel: UILabel!
    @IBOutlet weak var tempSC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func  thresholdSlider(_ sender: UISlider) {
        let val = Int(sender.value)
        if (val > 8) {
            thresholdLabel.text = "Threshold 🌶"
        } else if (val < 3) {
            thresholdLabel.text = "Threshold 🍦"
        } else {
            thresholdLabel.text = "Threshold 😎"
        }
    }
    
    // MARK: - Table view data source
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 4
//    }
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 4
//        case 1:
//            return 1
//        case 2:
//            return 3
//        case 3:
//            return 0
//        default:
//            return 0
//        }
//    }

}




