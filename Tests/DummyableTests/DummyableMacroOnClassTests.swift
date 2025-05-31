//
//  DummyableMacroOnClassTests.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

#if canImport(DummyableMacro) // macro generation can only be run on macos (on pre-compiling phase)
import XCTest
import SwiftSyntaxMacrosTestSupport
@testable import DummyableMacro

final class DummyableMacroOnClassTests: XCTestCase {
    
    func test_givenClass_whenExpanded_shouldUseClassExpansion() {
        assertMacroExpansion(
            basicClass, expandedSource: basicClassExpansions,
            macros: ["Dummyable": DummyableMacro.self]
        )
    }
    
    func test_givenGenericClass_whenExpanded_shouldUseGenericClassExpansion() {
        assertMacroExpansion(
            genericClass, expandedSource: genericClassExpansions,
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
    var someComputed: String {
        "computed"
    }

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
    var someComputed: String {
        "computed"
    }

    @DummyableInit
    init(string: String?, int: Int = 10) {
        self.string = string
        self.int = int
    }
}

func dummy(of type: Some.Type) -> Some {
    Some(string: dummy(of: String?.self))
}

func dummy(of type: [Some].Type, count: Int) -> [Some] {
    Array(repeat: count) {
        dummy(of: Some.self)
    }
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

private let genericClass = #"""
@Dummyable
class Some<T: Equatable> where T: Hashable {
    var generic: T?
    let int: Int
    var doubles: [Double] = []
    let floats: Float = 0.0
    var someComputed: String {
        "computed"
    }

    @DummyableInit
    init(generic: T?, int: Int = 10) {
        self.generic = nil
        self.int = int
    }
}
"""#

private let genericClassExpansions = #"""
class Some<T: Equatable> where T: Hashable {
    var generic: T?
    let int: Int
    var doubles: [Double] = []
    let floats: Float = 0.0
    var someComputed: String {
        "computed"
    }

    @DummyableInit
    init(generic: T?, int: Int = 10) {
        self.generic = nil
        self.int = int
    }
}

func dummy<T: Equatable>(of type: Some<T>.Type) -> Some<T> where T: Hashable {
    Some(generic: dummy(of: T?.self))
}

func dummy<T: Equatable>(of type: [Some<T>].Type, count: Int) -> [Some<T>] where T: Hashable {
    Array(repeat: count) {
        dummy(of: Some<T>.self)
    }
}

func dummy<T: Equatable>(of type: Closure<Some<T>>.Type) -> Closure<Some<T>> where T: Hashable {
    {
        dummy(of: Some<T>.self)
    }
}

func dummy<A, T: Equatable>(of type: ArgClosure<A, Some<T>>.Type) -> ArgClosure<A, Some<T>> where T: Hashable {
    { _ in
        dummy(of: Some<T>.self)
    }
}

func dummy<A, B, T: Equatable>(of type: TwoArgsClosure<A, B, Some<T>>.Type) -> TwoArgsClosure<A, B, Some<T>> where T: Hashable {
    { _, _ in
        dummy(of: Some<T>.self)
    }
}

func dummy<A, B, C, T: Equatable>(of type: ThreeArgsClosure<A, B, C, Some<T>>.Type) -> ThreeArgsClosure<A, B, C, Some<T>> where T: Hashable {
    { _, _, _ in
        dummy(of: Some<T>.self)
    }
}

func dummy<A, B, C, D, T: Equatable>(of type: FourArgsClosure<A, B, C, D, Some<T>>.Type) -> FourArgsClosure<A, B, C, D, Some<T>> where T: Hashable {
    { _, _, _, _ in
        dummy(of: Some<T>.self)
    }
}
"""#
#endif
