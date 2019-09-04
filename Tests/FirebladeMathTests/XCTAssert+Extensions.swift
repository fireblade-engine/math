//
//  XCTAssert+Extensions.swift
//  
//
//  Created by Christian Treffs on 04.09.19.
//

import func XCTest.XCTAssertEqual
import func XCTest.XCTFail

public func XCTAssertEqualArray<T>(_ expression1: @autoclosure () throws -> [T],
                                   _ expression2: @autoclosure () throws -> [T],
                                   accuracy: T,
                                   _ message: @autoclosure () -> String = "",
                                   file: StaticString = #file,
                                   line: UInt = #line) where T : FloatingPoint {
    do {
        for (lhs, rhs) in zip(try expression1(), try expression2()) {
            XCTAssertEqual(lhs, rhs, accuracy: accuracy, message(), file: file, line: line)
        }
    } catch {
        XCTFail(error.localizedDescription)
    }
}
