//
//  DummyableMacroOnStructTests.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

#if canImport(DummyableMacro) // macro generation can only be run on macos (on pre-compiling phase)
import XCTest
import SwiftSyntaxMacrosTestSupport
@testable import DummyableMacro

final class DummyableMacroOnStructTests: XCTestCase {
    
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

    init(string: String? = dummy(of: String?.self), int: Int = dummy(of: Int.self)) {
        self.string = string
        self.int = int
    }
}

func dummy(of type: Some.Type) -> Some {
    Some()
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

private func dummy(of type: Some.Type) -> Some {
    Some(string: dummy(of: String?.self))
}

private func dummy(of type: Closure<Some>.Type) -> Closure<Some> {
    {
        dummy(of: Some.self)
    }
}

private func dummy<A>(of type: ArgClosure<A, Some>.Type) -> ArgClosure<A, Some> {
    { _ in
        dummy(of: Some.self)
    }
}

private func dummy<A, B>(of type: TwoArgsClosure<A, B, Some>.Type) -> TwoArgsClosure<A, B, Some> {
    { _, _ in
        dummy(of: Some.self)
    }
}

private func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, Some>.Type) -> ThreeArgsClosure<A, B, C, Some> {
    { _, _, _ in
        dummy(of: Some.self)
    }
}

private func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, Some>.Type) -> FourArgsClosure<A, B, C, D, Some> {
    { _, _, _, _ in
        dummy(of: Some.self)
    }
}
"""#
#endif
