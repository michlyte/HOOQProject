//
//  HOOQProjectTests.swift
//  HOOQProjectTests
//
//  Created by Michael Halim on 12/05/18.
//  Copyright © 2018 com. All rights reserved.
//

import XCTest
@testable import HOOQProject
import Alamofire
import JSONJoy

class HOOQProjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetNowPlayingMovie() {
        let expectations = expectation(description: "testGetNowPlayingMovie")
        let params = RestAPI.getParams(page: "1")
        Alamofire.request(RestAPI.getNowPlayingMovieURL(), method: .get, parameters: params , encoding: URLEncoding.default, headers: nil)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let result):
                    //do the checking with expected result
                    //AssertEqual or whatever you need to do with the data
                    //finally fullfill the expectation
                    do {
                        let nowPlayingMovieJSON = try NowPlayingMovieJSON(JSONLoader(result))
                        print(nowPlayingMovieJSON)
                    } catch {
                        print("unable to parse the JSON")
                    }
                    expectations.fulfill()
                case .failure(let error):
                    //this is failed case
                    XCTFail("Server response failed : \(error.localizedDescription)")
                    expectations.fulfill()
                }
            })

        //wait for some time for the expectation (you can wait here more than 30 sec, depending on the time for the response)
        waitForExpectations(timeout: 5, handler: { (error) in
            if let error = error {
                print("Failed : \(error.localizedDescription)")
            }
        })
    }
    
    func testGetSimilarMovie() {
        let expectations = expectation(description: "testGetSimilarMovie")
        let params = RestAPI.getParams(page: "1")
        Alamofire.request(RestAPI.getSimilarMovieURL(movie_id: "299536"), method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let result):
                    //do the checking with expected result
                    //AssertEqual or whatever you need to do with the data
                    //finally fullfill the expectation
                    do {
                        let similarMovieJSON = try SimilarMovieJSON(JSONLoader(result))
                        print(similarMovieJSON)
                    } catch {
                        print("unable to parse the JSON")
                    }
                    expectations.fulfill()
                case .failure(let error):
                    //this is failed case
                    XCTFail("Server response failed : \(error.localizedDescription)")
                    expectations.fulfill()
                }
            })

        //wait for some time for the expectation (you can wait here more than 30 sec, depending on the time for the response)
        waitForExpectations(timeout: 5, handler: { (error) in
            if let error = error {
                print("Failed : \(error.localizedDescription)")
            }
        })
    }
}
