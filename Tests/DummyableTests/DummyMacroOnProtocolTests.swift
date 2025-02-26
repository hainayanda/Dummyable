//
//  DummyMacroOnProtocolTests.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

#if canImport(DummyableMacro) // macro generation can only be run on macos (on pre-compiling phase)
import XCTest
import SwiftSyntaxMacrosTestSupport
@testable import DummyableMacro
import Dummyable

final class DummyMacroOnProtocolTests: XCTestCase {
    
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
    func voidFunc() async throws
    func returnFunc(arg argument: String) async throws -> String
}
"""#

private let basicStructExpansions = #"""
protocol Some {
    var string: String { get }
    var float: Float? { get set }
    func voidFunc() async throws
    func returnFunc(arg argument: String) async throws -> String
}

struct SomeDummy: Some , Dummyable {
    static var dummy: SomeDummy {
        SomeDummy()
    }
        var string: String
        var float: Float?
    init(string: String = Dummies.dummy(of: String.self), float: Float? = Dummies.dummy(of: Float?.self)) {
        self.string = string
        self.float = float
    }
        func voidFunc() async throws {
        Dummies.dummy(of: Void.self)
    }
        func returnFunc(arg argument: String) async throws -> String {
        Dummies.dummy(of: String.self)
    }
}

extension Dummies {
    static func dummy(of type: Some .Type) -> Some {
        SomeDummy.dummy
    }
}
"""#

private let basicClass = #"""
@Dummyable(type: .class)
private protocol Some {
    var string: String { get }
    var float: Float? { get set }
    func voidFunc() async throws
    func returnFunc(arg argument: String) async throws -> String
}
"""#

private let basicClassExpansions = #"""
private protocol Some {
    var string: String { get }
    var float: Float? { get set }
    func voidFunc() async throws
    func returnFunc(arg argument: String) async throws -> String
}

final class SomeDummy: Some , Dummyable {
    static var dummy: SomeDummy {
        SomeDummy()
    }
        var string: String
        var float: Float?
    init(string: String = Dummies.dummy(of: String.self), float: Float? = Dummies.dummy(of: Float?.self)) {
        self.string = string
        self.float = float
    }
        func voidFunc() async throws {
        Dummies.dummy(of: Void.self)
    }
        func returnFunc(arg argument: String) async throws -> String {
        Dummies.dummy(of: String.self)
    }
}

extension Dummies {
    static func dummy(of type: Some .Type) -> Some {
        SomeDummy.dummy
    }
}
"""#

private let basicObjectProtocol = #"""
@Dummyable
public protocol Some: AnyObject {
    var string: String { get }
    var float: Float? { get set }
    func voidFunc() async throws
    func returnFunc(arg argument: String) async throws -> String
}
"""#

private let basicObjectProtocolExpansions = #"""
public protocol Some: AnyObject {
    var string: String { get }
    var float: Float? { get set }
    func voidFunc() async throws
    func returnFunc(arg argument: String) async throws -> String
}

final
public class SomeDummy: Some, Dummyable {
    public static var dummy: SomeDummy {
        SomeDummy()
    }
    public
        var string: String
    public
        var float: Float?
    public init(string: String = Dummies.dummy(of: String.self), float: Float? = Dummies.dummy(of: Float?.self)) {
        self.string = string
        self.float = float
    }
    public
        func voidFunc() async throws {
        Dummies.dummy(of: Void.self)
    }
    public
        func returnFunc(arg argument: String) async throws -> String {
        Dummies.dummy(of: String.self)
    }
}

public extension Dummies {
    static func dummy(of type: Some.Type) -> Some {
        SomeDummy.dummy
    }
}
"""#
#endif
