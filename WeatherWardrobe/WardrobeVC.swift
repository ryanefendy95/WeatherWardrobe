//
//  WardrobeVC.swift
//  WeatherWardrobe
//
//  Created by Ryan Efendy on 2/01/17.
//  Copyright © 2017 Ryan Efendy. All rights reserved.
//

import UIKit
import CoreData

class WardrobeVC: UIViewController {

    @IBOutlet weak var OuterwearCollectionView: UICollectionView!
    
    
    // Core Data
    var managedObjectContext: NSManagedObjectContext!
    var entries: [NSManagedObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Core Data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("error")
            return
        }
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
    
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.fetchOuterWearImages()

    }
    
    func fetchOuterWearImages() {
        CurrentUser.sharedInstance.outerWearImages.removeAll()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OuterWearImages")
        
        do {
            let entryObjects = try managedObjectContext.fetch(fetchRequest)
            self.entries = entryObjects as! [NSManagedObject]
        
            for entry in self.entries {
                let image = entry.value(forKey: "image") as! UIImage

                CurrentUser.sharedInstance.outerWearImages.append(image)
                
            }
            
            self.OuterwearCollectionView.reloadData()
            
        } catch let error as NSError {
            print("could not fetch entries \(error), \(error.userInfo)")
        }
        
        
    }
    


}

extension WardrobeVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch <#value#> {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
        
        return CurrentUser.sharedInstance.outerWearImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = OuterwearCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ClothesCell
        cell.clothingImageView.image = CurrentUser.sharedInstance.outerWearImages[indexPath.row]
        
        return cell
    }
    
    
    
    
}
