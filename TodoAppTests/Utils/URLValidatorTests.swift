//
//  URLValidatorTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/03.
//

import XCTest
@testable import TodoApp

final class URLValidatorTests: XCTestCase {
    private let urlValidator = URLValidator()
    
    func testValidHTTPURL() {
        let urlString = "http://example.com"
        XCTAssertTrue(urlValidator.isValid(urlString))
    }
    
    func testValidHTTPSURL() {
        let urlString = "https://example.com"
        XCTAssertTrue(urlValidator.isValid(urlString))
    }
    
    func testValidURLWithPath() {
        let urlString = "https://example.com/path/to/resource"
        XCTAssertTrue(urlValidator.isValid(urlString))
    }
    
    func testInvalidURLWithoutScheme() {
        let urlString = "example.com"
        XCTAssertFalse(urlValidator.isValid(urlString))
    }
    
    func testInvalidURLWithoutHost() {
        let urlString = "http://"
        XCTAssertFalse(urlValidator.isValid(urlString))
    }
    
    func testInvalidEmptyURL() {
        let urlString = ""
        XCTAssertFalse(urlValidator.isValid(urlString))
    }
    
    func testInvalidMalformedURL() {
        let urlString = "htp://example.com"
        XCTAssertFalse(urlValidator.isValid(urlString))
    }
    
    func testValidURLWithQueryParameters() {
        let urlString = "https://example.com?query=123&key=value"
        XCTAssertTrue(urlValidator.isValid(urlString))
    }
    
    func testValidURLWithPort() {
        let urlString = "https://example.com:8080"
        XCTAssertTrue(urlValidator.isValid(urlString))
    }
    
    func testValidURLWithFragment() {
        let urlString = "https://example.com#fragment"
        XCTAssertTrue(urlValidator.isValid(urlString))
    }

    
    
}
