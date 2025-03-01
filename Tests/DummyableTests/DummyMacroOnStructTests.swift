//
//  DummyMacroOnStructTests.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

#if canImport(DummyableMacro) // macro generation can only be run on macos (on pre-compiling phase)
import XCTest
import SwiftSyntaxMacrosTestSupport
@testable import DummyableMacro

final class DummyMacroOnStructTests: XCTestCase {
    
    func test_givenBasicStruct_whenExpanded_shouldUseBasicStructExpansion() {
        assertMacroExpansion(
            basicStruct, expandedSource: basicStructExpansions,
            macros: ["Dummyable": DummyableMacro.self]
        )
    }
    
    func test_givenStructWithInit_whenExpanded_shouldUseStructWithInitExpansion() {
        assertMacroExpansion(
            basicStructWithInit, expandedSource: basicStructWithInitExpansions,
            macros: ["Dummyable": DummyableMacro.self]
        )
    }
}

private let basicStruct = #"""
@Dummyable
struct Some {
    var string: String?
    let int: Int
    var doubles: [Double] = []
    let floats: Float = 0.0
}
"""#

private let basicStructExpansions = #"""
struct Some {
    var string: String?
    let int: Int
    var doubles: [Double] = []
    let floats: Float = 0.0

    init(string: String? = Dummies.dummy(of: String?.self), int: Int = Dummies.dummy(of: Int.self)) {
        self.string = string
        self.int = int
    }
}

extension Dummies {
    static func dummy(of type: Some.Type) -> Some {
        Some()
    }
}
"""#

private let basicStructWithInit = #"""
@Dummyable
private struct Some {
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

private let basicStructWithInitExpansions = #"""
private struct Some {
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

private extension Dummies {
    static func dummy(of type: Some.Type) -> Some {
        Some(string: Dummies.dummy(of: String?.self))
    }
}
"""#
#endif
