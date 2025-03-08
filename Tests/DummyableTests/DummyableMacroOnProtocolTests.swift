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
    var string: String
    var float: Float?
    init() {
        self.string = dummy(of: String.self)
        self.float = dummy(of: Float?.self)
    }
    init?(int: Int) {
        self.string = dummy(of: String.self)
        self.float = dummy(of: Float?.self)
    }
    func voidFunc() async throws {
        dummy(of: Void.self)
    }
    func returnFunc(arg argument: String) async throws -> String {
        dummy(of: String.self)
    }
}

func dummy(of type: Some.Type) -> Some {
    SomeDummy()
}

func dummy(of type: [Some].Type, count: Int) -> [Some] {
    Array(repeat: count) {
        SomeDummy()
    }
}

func dummy(of type: Closure<Some>.Type) -> Closure<Some> {
    {
        SomeDummy()
    }
}

func dummy<A>(of type: ArgClosure<A, Some>.Type) -> ArgClosure<A, Some> {
    { _ in
        SomeDummy()
    }
}

func dummy<A, B>(of type: TwoArgsClosure<A, B, Some>.Type) -> TwoArgsClosure<A, B, Some> {
    { _, _ in
        SomeDummy()
    }
}

func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, Some>.Type) -> ThreeArgsClosure<A, B, C, Some> {
    { _, _, _ in
        SomeDummy()
    }
}

func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, Some>.Type) -> FourArgsClosure<A, B, C, D, Some> {
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
    var string: String
    var float: Float?
    init() {
        self.string = dummy(of: String.self)
        self.float = dummy(of: Float?.self)
    }
    init?(int: Int) {
        self.string = dummy(of: String.self)
        self.float = dummy(of: Float?.self)
    }
    func voidFunc() async throws {
        dummy(of: Void.self)
    }
    func returnFunc(arg argument: String) async throws -> String {
        dummy(of: String.self)
    }
}

private func dummy(of type: Some.Type) -> Some {
    SomeDummy()
}

private func dummy(of type: [Some].Type, count: Int) -> [Some] {
    Array(repeat: count) {
        SomeDummy()
    }
}

private func dummy(of type: Closure<Some>.Type) -> Closure<Some> {
    {
        SomeDummy()
    }
}

private func dummy<A>(of type: ArgClosure<A, Some>.Type) -> ArgClosure<A, Some> {
    { _ in
        SomeDummy()
    }
}

private func dummy<A, B>(of type: TwoArgsClosure<A, B, Some>.Type) -> TwoArgsClosure<A, B, Some> {
    { _, _ in
        SomeDummy()
    }
}

private func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, Some>.Type) -> ThreeArgsClosure<A, B, C, Some> {
    { _, _, _ in
        SomeDummy()
    }
}

private func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, Some>.Type) -> FourArgsClosure<A, B, C, D, Some> {
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
    public var string: String
    public var float: Float?
    public init() {
        self.string = dummy(of: String.self)
        self.float = dummy(of: Float?.self)
    }
    public func voidFunc() async throws {
        dummy(of: Void.self)
    }
    public func returnFunc(arg argument: String) async throws -> String {
        dummy(of: String.self)
    }
}

public func dummy(of type: Some.Type) -> Some {
    SomeDummy()
}

public func dummy(of type: [Some].Type, count: Int) -> [Some] {
    Array(repeat: count) {
        SomeDummy()
    }
}

public func dummy(of type: Closure<Some>.Type) -> Closure<Some> {
    {
        SomeDummy()
    }
}

public func dummy<A>(of type: ArgClosure<A, Some>.Type) -> ArgClosure<A, Some> {
    { _ in
        SomeDummy()
    }
}

public func dummy<A, B>(of type: TwoArgsClosure<A, B, Some>.Type) -> TwoArgsClosure<A, B, Some> {
    { _, _ in
        SomeDummy()
    }
}

public func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, Some>.Type) -> ThreeArgsClosure<A, B, C, Some> {
    { _, _, _ in
        SomeDummy()
    }
}

public func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, Some>.Type) -> FourArgsClosure<A, B, C, D, Some> {
    { _, _, _, _ in
        SomeDummy()
    }
}
"""#
#endif
