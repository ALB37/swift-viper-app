//
//  Photo.swift
//  swift-mvc-app
//
//  Created by Andrew Bloom on 4/15/18.
//  Copyright © 2018 Andrew Bloom. All rights reserved.
//

import UIKit

class Photo {
    
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        guard (rating >= 0) && (rating < 6) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
}
