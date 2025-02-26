//
//  DummyMacroOnClassTests.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

#if canImport(DummyableMacro) // macro generation can only be run on macos (on pre-compiling phase)
import XCTest
import SwiftSyntaxMacrosTestSupport
@testable import DummyableMacro
import Dummyable

final class DummyMacroOnClassTests: XCTestCase {
    
    func test_givenClass_whenExpanded_shouldUseClassExpansion() {
        assertMacroExpansion(
            basicClass, expandedSource: basicClassExpansions,
            macros: ["Dummyable": DummyableMacro.self]
        )
    }
}

private let basicClass = #"""
@Dummyable
class Some {
    var string: String?
    let int: Int
    var doubles: [Double] = []
    let floats: Float = 0.0

    @DummyableInit
    init(string: String?, int: Int = 10) {
        self.string = string
        self.int = int
    }
}
"""#

private let basicClassExpansions = #"""
class Some {
    var string: String?
    let int: Int
    var doubles: [Double] = []
    let floats: Float = 0.0

    @DummyableInit
    init(string: String?, int: Int = 10) {
        self.string = string
        self.int = int
    }
}

extension Dummies {
    static func dummy(of type: Some.Type) -> Some {
        Some (string: dummy(of: String?.self))
    }
}
"""#

private let basicFinalClass = #"""
@Dummyable
final class Some {
    var string: String?
    let int: Int
    var doubles: [Double] = []
    let floats: Float = 0.0

    @DummyableInit
    init(string: String?, int: Int = 10) {
        self.string = string
        self.int = int
    }
}
"""#

private let basicFinalClassExpansions = #"""
final class Some {
    var string: String?
    let int: Int
    var doubles: [Double] = []
    let floats: Float = 0.0

    @DummyableInit
    init(string: String?, int: Int = 10) {
        self.string = string
        self.int = int
    }
}

extension Some : Dummyable {
    static var dummy: Some {
        Some (string: dummy(of: String?.self))
    }
}
"""#
#endif
