//
//  MockObservable.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI
import Dummyable
import Observation

// periphery:ignore
@Dummyable(type: .struct)
protocol StructDummyProtocol {
    var string: String? { get }
    var int: Int { get set }
    var doubles: [Double] { get async }
    var floats: [Float]? { get throws }
    
    init(bool: Bool)
    
    func voidFunc()
    func returnFunc() -> Int
    func paramFunc(param: String) -> [String: String]
    func asyncFunc() async
    func asyncThrowsFunc() async throws -> String
}

// periphery:ignore
@Dummyable(type: .class)
protocol ClassDummyProtocol {
    var string: String? { get }
    var int: Int { get set }
    var doubles: [Double] { get async }
    var floats: [Float]? { get throws }
    
    init(bool: Bool)
    
    func voidFunc()
    func returnFunc() -> Int
    func paramFunc(param: String) -> [String: String]
    func asyncFunc() async
    func asyncThrowsFunc() async throws -> String
}

// periphery:ignore
@Dummyable
protocol AnyObjectDummyProtocol: AnyObject {
    var string: String? { get }
    var int: Int { get set }
    var doubles: [Double] { get async }
    var floats: [Float]? { get throws }
    
    init(bool: Bool)
    
    func voidFunc()
    func returnFunc() -> Int
    func paramFunc(param: String) -> [String: String]
    func asyncFunc() async
    func asyncThrowsFunc() async throws -> String
}

// periphery:ignore
@Dummyable
struct StructDummy {
    var string: String?
    let int: Int
    var doubles: [Double] = []
    let floats: Float = 0.0
}

// periphery:ignore
@Dummyable
struct StructDummyableMarkedInit {
    var string: String?
    let int: Int
    var doubles: [Double] = []
    let floats: Float = 0.0
    
    @DummyableInit
    init(number: Int) {
        self.string = "\(number)"
        self.int = number
        self.doubles = Array(repeating: Double(number), count: number)
    }
}

// periphery:ignore
@Dummyable
class ClassDummyableMarkedInit {
    var string: String?
    let int: Int
    var doubles: [Double] = []
    let floats: Float = 0.0
    
    @DummyableInit
    init(number: Int) {
        self.string = "\(number)"
        self.int = number
        self.doubles = Array(repeating: Double(number), count: number)
    }
}

// periphery:ignore
@Dummyable
enum EnumDummyable {
    case some
    case another(string: String)
    case any
}

// periphery:ignore
@Dummyable
enum EnumDummyableMarkedCase {
    case some
    @DummyableCase
    case another(string: String)
    case any
}

// periphery:ignore
struct Dum {
    let string: String?
}

#Dummy(of: Dum.self) {
    Dum(string: "some")
}

// periphery:ignore
struct PrivateDum {
    let string: String?
}

#PrivateDummy(of: PrivateDum.self) {
    PrivateDum(string: "some")
}

// periphery:ignore
public struct PublicDum {
    let string: String?
}

#PublicDummy(of: PublicDum.self) {
    PublicDum(string: "some")
}

public struct GenericDummyA<T> {
    let value: T?
}

#PublicDummy(of: GenericDummyA<Generic>.self, .isGeneric(0)) {
    GenericDummyA(value: nil)
}

public struct GenericDummyB<T> {
    let value: T?
}

#PublicDummy(
    of: GenericDummyB<Generic>.self,
    .where(0, conform: (any Equatable).self),
    .available(.iOS(15.0), .macOS(12.0), .tvOS(15.0), .watchOS(8.0))
) {
    GenericDummyB(value: nil)
}

// periphery:ignore
func testCompiledDummyCreation() {
    _ = dummy(of: StructDummyProtocol.self)
    _ = dummy(of: ClassDummyProtocol.self)
    _ = dummy(of: AnyObjectDummyProtocol.self)
    _ = dummy(of: StructDummy.self)
    _ = dummy(of: StructDummyableMarkedInit.self)
    _ = dummy(of: ClassDummyableMarkedInit.self)
    _ = dummy(of: EnumDummyable.self)
    _ = dummy(of: EnumDummyableMarkedCase.self)
    _ = dummy(of: Dum.self)
    _ = dummy(of: PublicDum.self)
    _ = dummy(of: PrivateDum.self)
    _ = dummy(of: GenericDummyA<String>.self)
    _ = dummy(of: GenericDummyB<Int>.self)
}
