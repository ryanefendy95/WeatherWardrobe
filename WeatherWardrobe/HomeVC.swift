//
//  HomeVC.swift
//  WeatherWardrobe
//
//  Created by Ryan Efendy on 2/01/17.
//  Copyright © 2017 Ryan Efendy. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
//    var initialText: String = "F"
    // Empty Data Source
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        temperatureLabel.text = labelText
        fetchWeather()
    }
    
    func fetchWeather () {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=d8d4fc65c58aabc5d2b34be1f0fd0778") else {
            return
        }
        
        // Create a request object with url just created
        let request = URLRequest(url: url)
        
        // Get a task from URLSession and initialize with request
        // and completion that needs to execute once data task is finished.
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if there was a error
            if error != nil {
                print(error!.localizedDescription)
            } else {
                // No error, happy path, try to convert RAW data to JSON
                do {
                    // check if data exists, try to serialize to a dictionay object
                    if let jsondata = data,
                        let json = try JSONSerialization.jsonObject(with: jsondata, options: .allowFragments) as? [String: Any] {
                        // We have dictionary by now, check and extract the nutrients names as array of 
                        print(json)
                        if let serverData = json["weather"] as? [String: Any] {
                            print(serverData)
                            // update the data source
                            
                            
                            
                            //                            self.dataSource = serverData
                            // Execute on main thread as this is a async call, that executes on a background thread.
                            DispatchQueue.main.async {
                                // We get data later than the table view is initialized in the screen
                                // Tell tableview to reload itself.
                                //                                self.tableView.reloadData()
                            }
                        }
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
        }
        
        task.resume()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
