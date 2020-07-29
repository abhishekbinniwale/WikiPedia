//
//  APIManagerTest.swift
//  WikiPediaDemoTests
//
//  Created by Abhishek Binniwale on 29/07/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import XCTest
@testable import WikiPediaDemo

class APIManagerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchWikidataAPI() {
        APIManager.sharedInstance.fetchWikiData(searchtext: "Sachin tendulkar") { (wikimodels) in
            self.wait {
                XCTAssertNotNil(wikimodels)
            }
        }
    }
    
    func testFetctImagedataAPI() {
        let url = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Einstein_1921_by_F_Schmutzer_-_restoration.jpg/38px-Einstein_1921_by_F_Schmutzer_-_restoration.jpg"
        APIManager.sharedInstance.fetchImageData(urlString: url) { (data) in
            self.wait {
                XCTAssertNotNil(data)
            }
        }
       }
}

extension XCTestCase {
    func wait(interval: TimeInterval = 0.1 , completion: @escaping (() -> Void)) {
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            completion()
            exp.fulfill()
        }
        waitForExpectations(timeout: interval + 0.1) // add 0.1 for sure asyn after called
    }
}
