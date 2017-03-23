import Foundation
import UIKit


class CurrentUser {
    
    static let sharedInstance = CurrentUser()
    
    var outwearImages: [UIImage]!
    var shirtImages: [UIImage]!
    var pantsImages: [UIImage]!
    var shoesImages: [UIImage]!
    
    enum catagories {
        case outerwear
        case shirt
        case pants
        case shoes
    }
    
    init() {
        self.outwearImages = []
        self.shirtImages = []
        self.pantsImages = []
        self.shoesImages = []
    }
    
}

