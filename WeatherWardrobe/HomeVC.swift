//
//  HomeVC.swift
//  WeatherWardrobe
//
//  Created by Ryan Efendy on 2/01/17.
//  Copyright © 2017 Ryan Efendy. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

     @IBOutlet weak var summaryCollectionView: UICollectionView!
    
    var shirts = ["shirt1", "shirt2", "shirt3"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.summaryCollectionView.delegate = self
        self.summaryCollectionView.dataSource = self
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shirts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "summaryCell", for: indexPath) as! SummaryCollectionViewCell
        
        // set image
        cell.summaryImageView.image = UIImage(named: shirts[indexPath.row])
        return cell
    }
}
