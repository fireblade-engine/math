//
//  XCTAssert+Extensions.swift
//
//
//  Created by Christian Treffs on 04.09.19.
//

import func XCTest.XCTAssertEqual
import func XCTest.XCTFail

public func XCTAssertEqualElements<T, S>(_ expression1: @autoclosure () throws -> S,
                                         _ expression2: @autoclosure () throws -> S,
                                         accuracy: T,
                                         _ message: @autoclosure () -> String = "",
                                         file: StaticString = #file,
                                         line: UInt = #line) where T: FloatingPoint, S: Sequence, S.Element == T {
    do {
        for (index, elements) in zip(try expression1(), try expression2()).enumerated() {
            XCTAssertEqual(elements.0, elements.1, accuracy: accuracy, "[element:\(index+1)]" + message(), file: (file), line: line)
        }
    } catch {
        XCTFail(error.localizedDescription)
    }
}

public func XCTAssertEqualElements<T, S>(_ expression1: @autoclosure () throws -> S,
                                         _ expression2: @autoclosure () throws -> S,
                                         _ message: @autoclosure () -> String = "",
                                         file: StaticString = #file,
                                         line: UInt = #line) where T: Equatable, S: Sequence, S.Element == T {
    do {
        for (index, elements) in zip(try expression1(), try expression2()).enumerated() {
            XCTAssertEqual(elements.0, elements.1, "[element:\(index+1)]" + message(), file: (file), line: line)
        }
    } catch {
        XCTFail(error.localizedDescription)
    }
}
