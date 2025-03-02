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
    
    func test_givenPublicDummy_whenExpanded_shouldUsePublicDummyExpansion() {
        assertMacroExpansion(
            publicDummy, expandedSource: publicDummyExpansions,
            macros: ["PublicDummy": DummyMacro.self]
        )
    }
    
    func test_givenPrivateDummy_whenExpanded_shouldUsePrivateDummyExpansion() {
        assertMacroExpansion(
            privateDummy, expandedSource: privateDummyExpansions,
            macros: ["PrivateDummy": DummyMacro.self]
        )
    }
}

private let basicDummy = #"""
#Dummy(of: Some.self, dummyProvider: {
    Some()
})
"""#

private let basicDummyExpansions = #"""
func dummy(of type: Some.Type) -> Some {
    Some()
}
"""#

private let trailingDummy = #"""
#Dummy(of: Some.self) {
    Some()
}
"""#

private let trailingDummyExpansions = #"""
func dummy(of type: Some.Type) -> Some {
    Some()
}
"""#

private let publicDummy = #"""
#PublicDummy(of: Some.self) {
    Some()
}
"""#

private let publicDummyExpansions = #"""
public func dummy(of type: Some.Type) -> Some {
    Some()
}
"""#

private let privateDummy = #"""
#PrivateDummy(of: Some.self) {
    Some()
}
"""#

private let privateDummyExpansions = #"""
private func dummy(of type: Some.Type) -> Some {
    Some()
}
"""#
#endif
