
import Foundation
import XCTest

extension XCTestCase {
    func XCTAssertNotRetainCycle<T: AnyObject>(
        _ expression: () throws -> T?,
        _: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        var sut: T?
        XCTAssertNoThrow(sut = try expression(), file: file, line: line)
        weak var weakSut = sut
        XCTAssertNotNil(sut, file: file, line: line)
        sut = nil

        addTeardownBlock {
            XCTAssertNil(weakSut, file: file, line: line)
        }
    }
}
