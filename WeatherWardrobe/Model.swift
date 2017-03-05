//
//  Model.swift
//  WeatherWardrobe
//
//  Created by Ryan Efendy on 2/01/17.
//  Copyright © 2017 Ryan Efendy. All rights reserved.
//

import Foundation
import UIKit


class CurrentUser {
    
    static let sharedInstance = CurrentUser()
    
    var outerWearImages: [UIImage]!
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
        self.outerWearImages = []
        self.shirtImages = []
        self.pantsImages = []
        self.shoesImages = []
    }
    
}




