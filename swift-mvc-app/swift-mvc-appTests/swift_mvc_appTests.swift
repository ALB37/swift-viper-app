//
//  swift_mvc_appTests.swift
//  swift-mvc-appTests
//
//  Created by Andrew Bloom on 4/14/18.
//  Copyright © 2018 Andrew Bloom. All rights reserved.
//

import XCTest
@testable import swift_mvc_app

class swift_mvc_appTests: XCTestCase {
    
    // MARK: Photo Class Tests
    
    func testPhotoInitializationSucceeds() {
        let zeroRatingPhoto = Photo.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingPhoto)
        
        let positiveRatingPhoto = Photo.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingPhoto)
    }
    
    func testPhotoInitializationFails() {
        let negativeRatingPhoto = Photo.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingPhoto)
        
        let emptyStringPhoto = Photo.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringPhoto)
        
        let largeRatingPhoto = Photo.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingPhoto)
    }
}
