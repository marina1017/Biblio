//
//  BiblioTests.swift
//  BiblioTests
//
//  Created by 中川万莉奈 on 2018/12/19.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import XCTest
@testable import Biblio

class BiblioTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_tableViewが表示されること() {
        let vc = BookListViewController()
        XCTAssertNotNil(vc.tableView)
        XCTAssertTrue(vc.view.subviews.contains(vc.tableView))
    }
    
    func test_sectionが1つあること() {
        let vc = BookListViewController()
        
        let sectionCount = vc.numberOfSections(in: vc.tableView)
        XCTAssertEqual(sectionCount, 1)
    }

}
