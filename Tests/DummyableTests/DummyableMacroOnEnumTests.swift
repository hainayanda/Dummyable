//
//  DummyableMacroOnEnumTests.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

#if canImport(DummyableMacro) // macro generation can only be run on macos (on pre-compiling phase)
import XCTest
import SwiftSyntaxMacrosTestSupport
@testable import DummyableMacro

final class DummyableMacroOnEnumTests: XCTestCase {
    
    func test_givenEnum_whenExpanded_shouldUseEnumExpansion() {
        assertMacroExpansion(
            basicEnum, expandedSource: basicEnumExpansions,
            macros: ["Dummyable": DummyableMacro.self]
        )
    }
    
    func test_givenExoticEnum_whenExpanded_shouldUseExoticEnumExpansion() {
        assertMacroExpansion(
            exoticEnum, expandedSource: exoticEnumExpansions,
            macros: ["Dummyable": DummyableMacro.self]
        )
    }
    
    func test_givenChoosenEnum_whenExpanded_shouldUseChoosenEnumExpansion() {
        assertMacroExpansion(
            choosenEnum, expandedSource: choosenEnumExpansions,
            macros: ["Dummyable": DummyableMacro.self]
        )
    }
}

private let basicEnum = #"""
@Dummyable
enum Some {
    case some
    case another
    case withParameter(string: String, int: Int)
    case none
}
"""#

private let basicEnumExpansions = #"""
enum Some {
    case some
    case another
    case withParameter(string: String, int: Int)
    case none
}

extension Dummies {
    static func dummy(of type: Some.Type) -> Some {
        .none
    }
}
"""#

private let exoticEnum = #"""
@Dummyable
enum Some {
    case oneParameter(string: String)
    case twoParameter(string: String, int: Int)
    case threeParameter(string: String, int: Int, double: Double)
}
"""#

private let exoticEnumExpansions = #"""
enum Some {
    case oneParameter(string: String)
    case twoParameter(string: String, int: Int)
    case threeParameter(string: String, int: Int, double: Double)
}

extension Dummies {
    static func dummy(of type: Some.Type) -> Some {
        .oneParameter(string: Dummies.dummy(of: String.self))
    }
}
"""#

private let choosenEnum = #"""
@Dummyable
enum Some {
    case some
    case another
    @DummyableCase case withParameter(string: String, int: Int)
    case none
}
"""#

private let choosenEnumExpansions = #"""
enum Some {
    case some
    case another
    @DummyableCase case withParameter(string: String, int: Int)
    case none
}

extension Dummies {
    static func dummy(of type: Some.Type) -> Some {
        .withParameter(string: Dummies.dummy(of: String.self), int: Dummies.dummy(of: Int.self))
    }
}
"""#
#endif
