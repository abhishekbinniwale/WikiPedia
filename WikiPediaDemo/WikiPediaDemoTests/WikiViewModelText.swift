//
//  WikiViewModelText.swift
//  WikiPediaDemoTests
//
//  Created by Abhishek Binniwale on 29/07/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import XCTest
@testable import WikiPediaDemo

class WikiViewModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWikiViewModel() {
        
        let wikiModel = WikiModel(pageid: 123, canonicalurl: "test", editurl: "test", fullurl: "test", title: "testing case", touched: "yesterday")
        //DI
        let wikiViewModel = WikiViewModel(wikiModel: wikiModel)
        
        XCTAssertEqual(wikiModel.pageid, wikiViewModel.id)
        XCTAssertEqual(wikiModel.fullurl, wikiViewModel.fullUrl)
        XCTAssertEqual(wikiModel.title, wikiViewModel.title)
    }

}
