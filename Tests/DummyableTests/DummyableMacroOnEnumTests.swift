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

func dummy(of type: Some.Type) -> Some {
    .none
}

func dummy(of type: Closure<Some>.Type) -> Closure<Some> {
    {
        dummy(of: Some.self)
    }
}

func dummy<A>(of type: ArgClosure<A, Some>.Type) -> ArgClosure<A, Some> {
    { _ in
        dummy(of: Some.self)
    }
}

func dummy<A, B>(of type: TwoArgsClosure<A, B, Some>.Type) -> TwoArgsClosure<A, B, Some> {
    { _, _ in
        dummy(of: Some.self)
    }
}

func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, Some>.Type) -> ThreeArgsClosure<A, B, C, Some> {
    { _, _, _ in
        dummy(of: Some.self)
    }
}

func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, Some>.Type) -> FourArgsClosure<A, B, C, D, Some> {
    { _, _, _, _ in
        dummy(of: Some.self)
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

func dummy(of type: Some.Type) -> Some {
    .oneParameter(string: dummy(of: String.self))
}

func dummy(of type: Closure<Some>.Type) -> Closure<Some> {
    {
        dummy(of: Some.self)
    }
}

func dummy<A>(of type: ArgClosure<A, Some>.Type) -> ArgClosure<A, Some> {
    { _ in
        dummy(of: Some.self)
    }
}

func dummy<A, B>(of type: TwoArgsClosure<A, B, Some>.Type) -> TwoArgsClosure<A, B, Some> {
    { _, _ in
        dummy(of: Some.self)
    }
}

func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, Some>.Type) -> ThreeArgsClosure<A, B, C, Some> {
    { _, _, _ in
        dummy(of: Some.self)
    }
}

func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, Some>.Type) -> FourArgsClosure<A, B, C, D, Some> {
    { _, _, _, _ in
        dummy(of: Some.self)
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

func dummy(of type: Some.Type) -> Some {
    .withParameter(string: dummy(of: String.self), int: dummy(of: Int.self))
}

func dummy(of type: Closure<Some>.Type) -> Closure<Some> {
    {
        dummy(of: Some.self)
    }
}

func dummy<A>(of type: ArgClosure<A, Some>.Type) -> ArgClosure<A, Some> {
    { _ in
        dummy(of: Some.self)
    }
}

func dummy<A, B>(of type: TwoArgsClosure<A, B, Some>.Type) -> TwoArgsClosure<A, B, Some> {
    { _, _ in
        dummy(of: Some.self)
    }
}

func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, Some>.Type) -> ThreeArgsClosure<A, B, C, Some> {
    { _, _, _ in
        dummy(of: Some.self)
    }
}

func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, Some>.Type) -> FourArgsClosure<A, B, C, D, Some> {
    { _, _, _, _ in
        dummy(of: Some.self)
    }
}
"""#
#endif
