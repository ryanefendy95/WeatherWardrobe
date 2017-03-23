import UIKit
import CoreData

class WardrobeVC: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var OuterwearCollectionView: UICollectionView!
    @IBOutlet weak var ShirtCollectionView: UICollectionView!
    @IBOutlet weak var PantsCollectionView: UICollectionView!
    @IBOutlet weak var ShoesCollectionView: UICollectionView!
 
    
    //    var shirts = ["shirts1", "shirt2", "shirt3"]
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Core Data
    var managedObjectContext: NSManagedObjectContext!
    var entries: [NSManagedObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 751)
        self.scrollView.delegate = self
        scrollView.isDirectionalLockEnabled = true
        // Core Data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("error")
            return
        }
        // enables to work/interact w/ core data
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        
        longPressSetUp()
        longPressSetUp2()
        longPressSetUp3()
        longPressSetUp4()

        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.featchOuterwearImages()
        self.fetchShirtImages()
        self.fetchPantsImages()
        self.fetchShoesImages()
    }


    
    
    // pulling outwear images from core data
    func featchOuterwearImages() {
        // remove current images
        CurrentUser.sharedInstance.outwearImages.removeAll()
        
        // make a request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Outerwear")
        
        do {
            // store result from fetch into entryObjects
            let entryObjects = try managedObjectContext.fetch(fetchRequest)
            
            // check if the result contains anything returned from fetch
            if entryObjects.count > 0 {
                
                self.entries = entryObjects as! [NSManagedObject]
                
                for entry in self.entries as [NSManagedObject] {
                    if let image = entry.value(forKey: "image") as? UIImage {
                        CurrentUser.sharedInstance.outwearImages.append(image)
                    }
                }
                self.OuterwearCollectionView.reloadData()
            }
            
            //            self.entries = entryObjects as! [NSManagedObject]
            //
            //            for entry in self.entries {
            //                let image = entry.value(forKey: "image") as! UIImage
            //
            //                CurrentUser.sharedInstance.outerWearImages.append(image)
            //            }
            
            self.OuterwearCollectionView.reloadData()
            
        } catch let error as NSError {
            print("could not fetch entries \(error), \(error.userInfo)")
        }
    }
    
    // pulling shirt images from core data
    func fetchShirtImages() {
        // remove current images
        CurrentUser.sharedInstance.shirtImages.removeAll()
        
        // make a request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Shirt")
        
        do {
            // store result from fetch into entryObjects
            let entryObjects = try managedObjectContext.fetch(fetchRequest)
            
            // check if the result contains anything returned from fetch
            if entryObjects.count > 0 {
                
                self.entries = entryObjects as! [NSManagedObject]
                
                for entry in self.entries as [NSManagedObject] {
                    if let image = entry.value(forKey: "image") as? UIImage {
                        CurrentUser.sharedInstance.shirtImages.append(image)
                    }
                }
                self.ShirtCollectionView.reloadData()
            }
            
            self.ShirtCollectionView.reloadData()
            
        } catch let error as NSError {
            print("could not fetch entries \(error), \(error.userInfo)")
        }
    }
    
    // pulling pants images from core data
    func fetchPantsImages() {
        // remove current images
        CurrentUser.sharedInstance.pantsImages.removeAll()
        
        // make a request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pants")
        
        do {
            // store result from fetch into entryObjects
            let entryObjects = try managedObjectContext.fetch(fetchRequest)
            
            // check if the result contains anything returned from fetch
            if entryObjects.count > 0 {
                
                self.entries = entryObjects as! [NSManagedObject]
                
                for entry in self.entries as [NSManagedObject] {
                    if let image = entry.value(forKey: "image") as? UIImage {
                        CurrentUser.sharedInstance.pantsImages.append(image)
                    }
                }
                self.PantsCollectionView.reloadData()
            }
            
            self.PantsCollectionView.reloadData()
            
        } catch let error as NSError {
            print("could not fetch entries \(error), \(error.userInfo)")
        }
    }
    
    // pulling shoes images from core data
    func fetchShoesImages() {
        // remove current images
        CurrentUser.sharedInstance.shoesImages.removeAll()
        
        // make a request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Shoes")
        
        do {
            // store result from fetch into entryObjects
            let entryObjects = try managedObjectContext.fetch(fetchRequest)
            
            // check if the result contains anything returned from fetch
            if entryObjects.count > 0 {
                
                self.entries = entryObjects as! [NSManagedObject]
                
                for entry in self.entries as [NSManagedObject] {
                    if let image = entry.value(forKey: "image") as? UIImage {
                        CurrentUser.sharedInstance.shoesImages.append(image)
                    }
                }
                self.ShoesCollectionView.reloadData()
            }
            
            self.ShoesCollectionView.reloadData()
            
        } catch let error as NSError {
            print("could not fetch entries \(error), \(error.userInfo)")
        }
    }
}

extension WardrobeVC: UICollectionViewDataSource {
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.OuterwearCollectionView {
            return CurrentUser.sharedInstance.outwearImages.count
        } else if collectionView == self.ShirtCollectionView{
            return CurrentUser.sharedInstance.shirtImages.count
        } else if collectionView == self.PantsCollectionView{
            return CurrentUser.sharedInstance.pantsImages.count
        } else if collectionView == self.ShoesCollectionView{
            return CurrentUser.sharedInstance.shoesImages.count
        } else {
            return 0
        }
    }
    
    // This is a placeholder method just to return a blank cell – you’ll be populating it later
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.OuterwearCollectionView {
            // create cell object from custom cell
            let cell:OuterwearCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "outerwearCell", for: indexPath) as! OuterwearCollectionViewCell
            
            cell.outerwearImageVIew.image = CurrentUser.sharedInstance.outwearImages[indexPath.row]
            
            return cell
        } else if collectionView == self.ShirtCollectionView{
            // create cell object from custom cell
            let cell:ShirtCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "shirtCell", for: indexPath) as! ShirtCollectionViewCell
            
            //            cell.shirtImageView.image = UIImage(named: shirts[indexPath.row])
            cell.shirtImageView.image = CurrentUser.sharedInstance.shirtImages[indexPath.row]
            
            return cell
        } else if collectionView == self.PantsCollectionView{
            let cell:PantsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pantsCell", for: indexPath) as! PantsCollectionViewCell
            cell.pantsImageVIew.image = CurrentUser.sharedInstance.pantsImages[indexPath.row]
            return cell
        } else {
            let cell:ShoesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoesCell", for: indexPath) as! ShoesCollectionViewCell
            cell.shoesImageVIew.image = CurrentUser.sharedInstance.shoesImages[indexPath.row]
            return cell
        }
    }
    
}





extension WardrobeVC {
    func longPressSetUp () {
        let lpgr1 = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        
        lpgr1.minimumPressDuration = 0.5
        lpgr1.delaysTouchesBegan = true
        lpgr1.delegate = self
        self.OuterwearCollectionView.addGestureRecognizer(lpgr1)
    }
    
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        AlertViews.showAlertDelete(parentVC: self) {

//            let point = gestureReconizer.location(in: self.OuterwearCollectionView)
//            let indexPath = self.OuterwearCollectionView.indexPathForItem(at: point)
            

            let indexRow = 0
                //            var cell = self.OuterwearCollectionView.cellForItem(at: index)
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Outerwear")
                
                do {
                    // store result from fetch into entryObjects
                    let entryObjects = try self.managedObjectContext.fetch(fetchRequest)
                    
                    // check if the result contains anything returned from fetch
                    if entryObjects.count > 0 {
                        
                        let entriesObjects = entryObjects as! [NSManagedObject]
                        
                        self.managedObjectContext.delete(entriesObjects[indexRow])
                        CurrentUser.sharedInstance.outwearImages.remove(at: indexRow)
                        self.OuterwearCollectionView.reloadData()
                    }
                    
                }catch let error as NSError {
                    print("could not fetch entries \(error), \(error.userInfo)")
                }
                
                // do stuff with your cell, for example print the indexPath
//                print(index.row)
        }

    }
    
    
    
    
    // shirt
    func longPressSetUp2 () {
        let lpgr1 = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress2))
        
        lpgr1.minimumPressDuration = 0.5
        lpgr1.delaysTouchesBegan = true
        lpgr1.delegate = self
        self.ShirtCollectionView.addGestureRecognizer(lpgr1)
    }
    
    
    func handleLongPress2(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        AlertViews.showAlertDelete(parentVC: self) {
            
            //            let point = gestureReconizer.location(in: self.OuterwearCollectionView)
            //            let indexPath = self.OuterwearCollectionView.indexPathForItem(at: point)
            
            
            let indexRow = 0
            //            var cell = self.OuterwearCollectionView.cellForItem(at: index)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Shirt")
            
            do {
                // store result from fetch into entryObjects
                let entryObjects = try self.managedObjectContext.fetch(fetchRequest)
                
                // check if the result contains anything returned from fetch
                if entryObjects.count > 0 {
                    
                    let entriesObjects = entryObjects as! [NSManagedObject]
                    
                    self.managedObjectContext.delete(entriesObjects[indexRow])
                    CurrentUser.sharedInstance.shirtImages.remove(at: indexRow)
                    self.ShirtCollectionView.reloadData()
                }
                
            }catch let error as NSError {
                print("could not fetch entries \(error), \(error.userInfo)")
            }
            
            // do stuff with your cell, for example print the indexPath
            //                print(index.row)
        }
        
    }
    
    
    
    // pants
    func longPressSetUp3 () {
        let lpgr1 = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress3))
        
        lpgr1.minimumPressDuration = 0.5
        lpgr1.delaysTouchesBegan = true
        lpgr1.delegate = self
        self.PantsCollectionView.addGestureRecognizer(lpgr1)
    }
    
    
    func handleLongPress3(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        AlertViews.showAlertDelete(parentVC: self) {
            
            let indexRow = 0
            //            var cell = self.OuterwearCollectionView.cellForItem(at: index)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pants")
            
            do {
                // store result from fetch into entryObjects
                let entryObjects = try self.managedObjectContext.fetch(fetchRequest)
                
                // check if the result contains anything returned from fetch
                if entryObjects.count > 0 {
                    
                    let entriesObjects = entryObjects as! [NSManagedObject]
                    
                    self.managedObjectContext.delete(entriesObjects[indexRow])
                    CurrentUser.sharedInstance.pantsImages.remove(at: indexRow)
                    self.PantsCollectionView.reloadData()
                }
                
            }catch let error as NSError {
                print("could not fetch entries \(error), \(error.userInfo)")
            }
            
            // do stuff with your cell, for example print the indexPath
            //                print(index.row)
        }
        
    }

    
    
    // shoes
    func longPressSetUp4 () {
        let lpgr1 = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress4))
        
        lpgr1.minimumPressDuration = 0.5
        lpgr1.delaysTouchesBegan = true
        lpgr1.delegate = self
        self.ShoesCollectionView.addGestureRecognizer(lpgr1)
    }
    
    
    func handleLongPress4(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        AlertViews.showAlertDelete(parentVC: self) {
            
            let indexRow = 0
            //            var cell = self.OuterwearCollectionView.cellForItem(at: index)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Shoes")
            
            do {
                // store result from fetch into entryObjects
                let entryObjects = try self.managedObjectContext.fetch(fetchRequest)
                
                // check if the result contains anything returned from fetch
                if entryObjects.count > 0 {
                    
                    let entriesObjects = entryObjects as! [NSManagedObject]
                    
                    self.managedObjectContext.delete(entriesObjects[indexRow])
                    CurrentUser.sharedInstance.shoesImages.remove(at: indexRow)
                    self.ShoesCollectionView.reloadData()
                }
                
            }catch let error as NSError {
                print("could not fetch entries \(error), \(error.userInfo)")
            }
            
            // do stuff with your cell, for example print the indexPath
            //                print(index.row)
        }
        
    }
    
    
    
}
