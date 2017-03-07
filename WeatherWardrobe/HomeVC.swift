import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var SummaryCollectionView: UICollectionView!
    var shirts = ["shirt1", "shirt2", "shirt3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SummaryCollectionView.delegate = self
        self.SummaryCollectionView.dataSource = self
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
