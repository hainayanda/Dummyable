//
//  DummyableMacroOnProtocolTests.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

#if canImport(DummyableMacro) // macro generation can only be run on macos (on pre-compiling phase)
import XCTest
import SwiftSyntaxMacrosTestSupport
@testable import DummyableMacro

final class DummyableMacroOnProtocolTests: XCTestCase {
    
    func test_givenBasicStruct_whenExpanded_shouldUseBasicStructExpansion() {
        assertMacroExpansion(
            basicStruct, expandedSource: basicStructExpansions,
            macros: ["Dummyable": DummyableMacro.self]
        )
    }
    
    func test_givenBasicClass_whenExpanded_shouldUseBasicClassExpansion() {
        assertMacroExpansion(
            basicClass, expandedSource: basicClassExpansions,
            macros: ["Dummyable": DummyableMacro.self]
        )
    }
    
    func test_givenBasicObjectProtocol_whenExpanded_shouldUseBasicObjectProtocolExpansion() {
        assertMacroExpansion(
            basicObjectProtocol, expandedSource: basicObjectProtocolExpansions,
            macros: ["Dummyable": DummyableMacro.self]
        )
    }
}

private let basicStruct = #"""
@Dummyable(type: .struct)
protocol Some {
    var string: String { get }
    var float: Float? { get set }
    init?(int: Int)
    func voidFunc() async throws
    func returnFunc(arg argument: String) async throws -> String
}
"""#

private let basicStructExpansions = #"""
protocol Some {
    var string: String { get }
    var float: Float? { get set }
    init?(int: Int)
    func voidFunc() async throws
    func returnFunc(arg argument: String) async throws -> String
}

private struct SomeDummy: Some {
    let string: String = dummy(of: String.self)
    var float: Float? = dummy(of: Float?.self)
    init() {
    }
    init?(int: Int) {
    }
    func voidFunc() async throws {
        dummy(of: Void.self)
    }
    func returnFunc(arg argument: String) async throws -> String {
        dummy(of: String.self)
    }
}

func dummy(of type: (any Some).Type) -> any Some {
    SomeDummy()
}

func dummy(of type: [any Some].Type, count: Int) -> [any Some] {
    Array(repeat: count) {
        SomeDummy()
    }
}

func dummy(of type: Closure<any Some>.Type) -> Closure<any Some> {
    {
        SomeDummy()
    }
}

func dummy<A>(of type: ArgClosure<A, any Some>.Type) -> ArgClosure<A, any Some> {
    { _ in
        SomeDummy()
    }
}

func dummy<A, B>(of type: TwoArgsClosure<A, B, any Some>.Type) -> TwoArgsClosure<A, B, any Some> {
    { _, _ in
        SomeDummy()
    }
}

func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, any Some>.Type) -> ThreeArgsClosure<A, B, C, any Some> {
    { _, _, _ in
        SomeDummy()
    }
}

func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, any Some>.Type) -> FourArgsClosure<A, B, C, D, any Some> {
    { _, _, _, _ in
        SomeDummy()
    }
}
"""#

private let basicClass = #"""
@Dummyable(type: .class)
private protocol Some {
    var string: String { get }
    var float: Float? { get set }
    init?(int: Int)
    func voidFunc() async throws
    func returnFunc(arg argument: String) async throws -> String
}
"""#

private let basicClassExpansions = #"""
private protocol Some {
    var string: String { get }
    var float: Float? { get set }
    init?(int: Int)
    func voidFunc() async throws
    func returnFunc(arg argument: String) async throws -> String
}

final private class SomeDummy: Some {
    let string: String = dummy(of: String.self)
    var float: Float? = dummy(of: Float?.self)
    init() {
    }
    init?(int: Int) {
    }
    func voidFunc() async throws {
        dummy(of: Void.self)
    }
    func returnFunc(arg argument: String) async throws -> String {
        dummy(of: String.self)
    }
}

private func dummy(of type: (any Some).Type) -> any Some {
    SomeDummy()
}

private func dummy(of type: [any Some].Type, count: Int) -> [any Some] {
    Array(repeat: count) {
        SomeDummy()
    }
}

private func dummy(of type: Closure<any Some>.Type) -> Closure<any Some> {
    {
        SomeDummy()
    }
}

private func dummy<A>(of type: ArgClosure<A, any Some>.Type) -> ArgClosure<A, any Some> {
    { _ in
        SomeDummy()
    }
}

private func dummy<A, B>(of type: TwoArgsClosure<A, B, any Some>.Type) -> TwoArgsClosure<A, B, any Some> {
    { _, _ in
        SomeDummy()
    }
}

private func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, any Some>.Type) -> ThreeArgsClosure<A, B, C, any Some> {
    { _, _, _ in
        SomeDummy()
    }
}

private func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, any Some>.Type) -> FourArgsClosure<A, B, C, D, any Some> {
    { _, _, _, _ in
        SomeDummy()
    }
}
"""#

private let basicObjectProtocol = #"""
@Dummyable
public protocol Some: AnyObject {
    var string: String { get }
    var float: Float? { get set }
    init()
    func voidFunc() async throws
    func returnFunc(arg argument: String) async throws -> String
}
"""#

private let basicObjectProtocolExpansions = #"""
public protocol Some: AnyObject {
    var string: String { get }
    var float: Float? { get set }
    init()
    func voidFunc() async throws
    func returnFunc(arg argument: String) async throws -> String
}

final private class SomeDummy: Some {
    public let string: String = dummy(of: String.self)
    public var float: Float? = dummy(of: Float?.self)
    public init() {
    }
    public func voidFunc() async throws {
        dummy(of: Void.self)
    }
    public func returnFunc(arg argument: String) async throws -> String {
        dummy(of: String.self)
    }
}

public func dummy(of type: (any Some).Type) -> any Some {
    SomeDummy()
}

public func dummy(of type: [any Some].Type, count: Int) -> [any Some] {
    Array(repeat: count) {
        SomeDummy()
    }
}

public func dummy(of type: Closure<any Some>.Type) -> Closure<any Some> {
    {
        SomeDummy()
    }
}

public func dummy<A>(of type: ArgClosure<A, any Some>.Type) -> ArgClosure<A, any Some> {
    { _ in
        SomeDummy()
    }
}

public func dummy<A, B>(of type: TwoArgsClosure<A, B, any Some>.Type) -> TwoArgsClosure<A, B, any Some> {
    { _, _ in
        SomeDummy()
    }
}

public func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, any Some>.Type) -> ThreeArgsClosure<A, B, C, any Some> {
    { _, _, _ in
        SomeDummy()
    }
}

public func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, any Some>.Type) -> FourArgsClosure<A, B, C, D, any Some> {
    { _, _, _, _ in
        SomeDummy()
    }
}
"""#
#endif
