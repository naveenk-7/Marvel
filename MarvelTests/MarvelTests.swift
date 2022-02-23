//
//  MarvelTests.swift
//  MarvelTests
//
//  Created by Naveen Kumar on 22/02/22.
//

import XCTest
import Alamofire
@testable import Marvel

class MarvelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Marvel list api
    func testMarvelAListAPI() {
        let expectation = self.expectation(description: Constants.marvelList)
        AF.request(APIRouter.listPage).response { response in
            guard response.error == nil else {
                print(response.error as Any)
                XCTAssertTrue(false)
                return
            }
            if let data = response.data {
                do {
                    _ = try JSONDecoder().decode(Marvel.self, from: data)
                    XCTAssertTrue(true)
                }
                catch {
                    print(response.error.debugDescription as Any)
                    XCTAssertTrue(false)
                }
            }
            else {
                print(response.error.debugDescription)
                XCTAssertTrue(false)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // Marvel detail api
    func testMarvelDetailAPI() {
        let expectation = self.expectation(description: Constants.marvelDetail)
        AF.request(APIRouter.detailPage(characterID: Constants.id)).response { response in
            guard response.error == nil else {
                print(response.error as Any)
                XCTAssertTrue(false)
                return
            }
            if let data = response.data {
                do {
                    _ = try JSONDecoder().decode(Marvel.self, from: data)
                    XCTAssertTrue(true)
                }
                catch {
                    print(response.error.debugDescription as Any)
                    XCTAssertTrue(false)
                }
            }
            else {
                print(response.error.debugDescription)
                XCTAssertTrue(false)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 4, handler: nil)
    }

}
