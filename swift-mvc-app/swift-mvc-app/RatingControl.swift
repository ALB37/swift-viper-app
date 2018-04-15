//
//  RatingControl.swift
//  swift-mvc-app
//
//  Created by Andrew Bloom on 4/15/18.
//  Copyright © 2018 Andrew Bloom. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {

    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // MARK: Button Action
    
    @objc func ratingButtonPressed(button: UIButton) {
        print("Button pressed 👍")
    }
    
    // MARK: Private Methods
    
    private func setupButtons() {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.addTarget(self, action: #selector(RatingControl.ratingButtonPressed(button:)), for: .touchUpInside)
        
        addArrangedSubview(button)
    }

}
