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
    @IBOutlet weak var datePickerTxt: UITextField!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()

    }
    
//    @IBAction func tempSC(_ sender: UISegmentedControl) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let homeVC = storyboard.instantiateViewController(withIdentifier :"HomeVC") as! HomeVC
//        if (sender.selectedSegmentIndex == 0) {
//            homeVC.temperatureLabel.text = "F"
//        } else {
//            homeVC.temperatureLabel.text = "C"
//        }
//    }

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
    
    func createDatePicker() {
        //format for picker
        datePicker.datePickerMode =  .date
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:  #selector(donePressed))
        toolbar.setItems([doneButton], animated : false)
        
        datePickerTxt.inputAccessoryView = toolbar
        
        // assigning date picker to text field
        datePickerTxt.inputView = datePicker
    }
    
    func donePressed() {
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        datePickerTxt.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 1
        case 2:
            return 3
        case 3:
            return 0
        default:
            return 0
        }
    }

}




