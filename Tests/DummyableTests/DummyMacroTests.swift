//
//  DummyMacroTests.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//



#if canImport(DummyableMacro) // macro generation can only be run on macos (on pre-compiling phase)
import XCTest
import SwiftSyntaxMacrosTestSupport
@testable import DummyableMacro

final class DummyMacroOnStructTests: XCTestCase {
    
    func test_givenBasicDummy_whenExpanded_shouldUseBasicDummyExpansion() {
        assertMacroExpansion(
            basicDummy, expandedSource: basicDummyExpansions,
            macros: ["Dummy": DummyMacro.self]
        )
    }
    
    func test_givenTrailingDummy_whenExpanded_shouldUseTrailingDummyExpansion() {
        assertMacroExpansion(
            trailingDummy, expandedSource: trailingDummyExpansions,
            macros: ["Dummy": DummyMacro.self]
        )
    }
}

private let basicDummy = #"""
#Dummy(of: Some.self, dummyProvider: {
    Some()
})
"""#

private let basicDummyExpansions = #"""
extension Dummies {
    static func dummy(of type: Some.Type) -> Some {
        Some()
    }
}
"""#

private let trailingDummy = #"""
#Dummy(of: Some.self) {
    Some()
}
"""#

private let trailingDummyExpansions = #"""
extension Dummies {
    static func dummy(of type: Some.Type) -> Some {
        Some()
    }
}
"""#
#endif
