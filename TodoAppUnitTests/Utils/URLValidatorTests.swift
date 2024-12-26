//
//  URLValidatorTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/03.
//
import XCTest
@testable import TodoApp

/// `URLValidator` の動作を検証するテストクラス
///
/// このクラスでは、`URLValidator` の `isValid` メソッドが正しく動作することをテストします
/// HTTP/HTTPS スキームを持つ有効なURL、無効なURL、パス、クエリ、ポート、フラグメントなど、さまざまなURL形式に対する動作を検証します
final class URLValidatorTests: XCTestCase {

    /// テスト対象の `URLValidator` インスタンス
    private let urlValidator = URLValidator()

    /// 有効な HTTP URL を検証
    ///
    /// - 期待結果: `http://example.com` は有効なURLとして認識される
    func testValidHTTPURL() {
        let urlString = "http://example.com"
        XCTAssertTrue(urlValidator.isValid(urlString))
    }

    /// 有効な HTTPS URL を検証
    ///
    /// - 期待結果: `https://example.com` は有効なURLとして認識される
    func testValidHTTPSURL() {
        let urlString = "https://example.com"
        XCTAssertTrue(urlValidator.isValid(urlString))
    }

    /// パスを含む有効なURLを検証
    ///
    /// - 期待結果: `https://example.com/path/to/resource` は有効なURLとして認識される
    func testValidURLWithPath() {
        let urlString = "https://example.com/path/to/resource"
        XCTAssertTrue(urlValidator.isValid(urlString))
    }

    /// スキームのない無効なURLを検証
    ///
    /// - 期待結果: `example.com` は無効なURLとして認識される
    func testInvalidURLWithoutScheme() {
        let urlString = "example.com"
        XCTAssertFalse(urlValidator.isValid(urlString))
    }

    /// ホストのない無効なURLを検証
    ///
    /// - 期待結果: `http://` は無効なURLとして認識される
    func testInvalidURLWithoutHost() {
        let urlString = "http://"
        XCTAssertFalse(urlValidator.isValid(urlString))
    }

    /// 空のURLを検証
    ///
    /// - 期待結果: 空文字列は無効なURLとして認識される
    func testInvalidEmptyURL() {
        let urlString = ""
        XCTAssertFalse(urlValidator.isValid(urlString))
    }

    /// 誤った形式の無効なURLを検証
    ///
    /// - 期待結果: `htp://example.com` は無効なURLとして認識される
    func testInvalidMalformedURL() {
        let urlString = "htp://example.com"
        XCTAssertFalse(urlValidator.isValid(urlString))
    }

    /// クエリパラメータを含む有効なURLを検証
    ///
    /// - 期待結果: `https://example.com?query=123&key=value` は有効なURLとして認識される
    func testValidURLWithQueryParameters() {
        let urlString = "https://example.com?query=123&key=value"
        XCTAssertTrue(urlValidator.isValid(urlString))
    }

    /// ポート番号を含む有効なURLを検証
    ///
    /// - 期待結果: `https://example.com:8080` は有効なURLとして認識される
    func testValidURLWithPort() {
        let urlString = "https://example.com:8080"
        XCTAssertTrue(urlValidator.isValid(urlString))
    }

    /// フラグメントを含む有効なURLを検証
    ///
    /// - 期待結果: `https://example.com#fragment` は有効なURLとして認識される
    func testValidURLWithFragment() {
        let urlString = "https://example.com#fragment"
        XCTAssertTrue(urlValidator.isValid(urlString))
    }
}
