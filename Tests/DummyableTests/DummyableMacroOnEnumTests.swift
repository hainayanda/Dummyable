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
    
    func test_givenGenericEnum_whenExpanded_shouldUseGenericEnumExpansion() {
        assertMacroExpansion(
            genericEnum, expandedSource: genericEnumExpansions,
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
    var someComputed: String {
        "computed"
    }
}
"""#

private let basicEnumExpansions = #"""
enum Some {
    case some
    case another
    case withParameter(string: String, int: Int)
    case none
    var someComputed: String {
        "computed"
    }
}

func dummy(of type: Some.Type) -> Some {
    .none
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

private let exoticEnum = #"""
@Dummyable
enum Some {
    case oneParameter(string: String)
    case twoParameter(string: String, int: Int)
    case threeParameter(string: String, int: Int, double: Double)
    var someComputed: String {
        "computed"
    }
}
"""#

private let exoticEnumExpansions = #"""
enum Some {
    case oneParameter(string: String)
    case twoParameter(string: String, int: Int)
    case threeParameter(string: String, int: Int, double: Double)
    var someComputed: String {
        "computed"
    }
}

func dummy(of type: Some.Type) -> Some {
    .oneParameter(string: dummy(of: String.self))
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

private let choosenEnum = #"""
@Dummyable
enum Some {
    case some
    case another
    @DummyableCase case withParameter(string: String, int: Int)
    case none
    var someComputed: String {
        "computed"
    }
}
"""#

private let choosenEnumExpansions = #"""
enum Some {
    case some
    case another
    @DummyableCase case withParameter(string: String, int: Int)
    case none
    var someComputed: String {
        "computed"
    }
}

func dummy(of type: Some.Type) -> Some {
    .withParameter(string: dummy(of: String.self), int: dummy(of: Int.self))
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

private let genericEnum = #"""
@Dummyable
enum Some<T: Equatable> {
    case some
    case another
    case withParameter(generic: T, int: Int)
    case none
    var someComputed: String {
        "computed"
    }
}
"""#

private let genericEnumExpansions = #"""
enum Some<T: Equatable> {
    case some
    case another
    case withParameter(generic: T, int: Int)
    case none
    var someComputed: String {
        "computed"
    }
}

func dummy<T: Equatable>(of type: Some<T>.Type) -> Some<T> {
    .none
}

func dummy<T: Equatable>(of type: [Some<T>].Type, count: Int) -> [Some<T>] {
    Array(repeat: count) {
        dummy(of: Some<T>.self)
    }
}

func dummy<T: Equatable>(of type: Closure<Some<T>>.Type) -> Closure<Some<T>> {
    {
        dummy(of: Some<T>.self)
    }
}

func dummy<A, T: Equatable>(of type: ArgClosure<A, Some<T>>.Type) -> ArgClosure<A, Some<T>> {
    { _ in
        dummy(of: Some<T>.self)
    }
}

func dummy<A, B, T: Equatable>(of type: TwoArgsClosure<A, B, Some<T>>.Type) -> TwoArgsClosure<A, B, Some<T>> {
    { _, _ in
        dummy(of: Some<T>.self)
    }
}

func dummy<A, B, C, T: Equatable>(of type: ThreeArgsClosure<A, B, C, Some<T>>.Type) -> ThreeArgsClosure<A, B, C, Some<T>> {
    { _, _, _ in
        dummy(of: Some<T>.self)
    }
}

func dummy<A, B, C, D, T: Equatable>(of type: FourArgsClosure<A, B, C, D, Some<T>>.Type) -> FourArgsClosure<A, B, C, D, Some<T>> {
    { _, _, _, _ in
        dummy(of: Some<T>.self)
    }
}
"""#
#endif
