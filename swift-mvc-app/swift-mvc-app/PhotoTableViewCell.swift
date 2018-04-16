//
//  PhotoTableViewCell.swift
//  swift-mvc-app
//
//  Created by Andrew Bloom on 4/15/18.
//  Copyright © 2018 Andrew Bloom. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
