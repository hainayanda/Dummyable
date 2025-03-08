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
struct ManualDummy {
    let string: String?
}

#Dummy(of: ManualDummy.self) {
    ManualDummy(string: "some")
}

// periphery:ignore
struct PrivateManualDummy {
    let string: String?
}

#PrivateDummy(of: PrivateManualDummy.self) {
    PrivateManualDummy(string: "some")
}

// periphery:ignore
public struct PublicManualDummy {
    let string: String?
}

#PublicDummy(of: PublicManualDummy.self) {
    PublicManualDummy(string: "some")
}

// periphery:ignore
public struct GenericDummyA<T> {
    let value: T?
}

#Dummy(of: GenericDummyA<Generic>.self, .isGeneric(0)) {
    GenericDummyA(value: nil)
}

// periphery:ignore
public struct GenericDummyB<T> {
    let value: T?
}

#Dummy(
    of: GenericDummyB<Generic>.self,
    .where(0, conform: (any Equatable).self),
    .available(.iOS(15.0), .macOS(12.0), .tvOS(15.0), .watchOS(8.0))
) {
    GenericDummyB(value: nil)
}

// periphery:ignore
public struct PublicGenericDummy<T> {
    let value: T?
}

#PublicDummy(of: PublicGenericDummy<Generic>.self, .isGeneric(0)) {
    PublicGenericDummy(value: nil)
}

// periphery:ignore
private struct PrivateGenericDummy<T> {
    let value: T?
}

#PrivateDummy(of: PrivateGenericDummy<Generic>.self, .isGeneric(0)) {
    PrivateGenericDummy(value: nil)
}

// periphery:ignore
func testCompiledDummyCreation() {
    _ = dummy(of: StructDummyProtocol.self)
    _ = dummy(of: [StructDummyProtocol].self, count: 2)
    _ = dummy(of: ClassDummyProtocol.self)
    _ = dummy(of: [ClassDummyProtocol].self, count: 3)
    _ = dummy(of: AnyObjectDummyProtocol.self)
    _ = dummy(of: [AnyObjectDummyProtocol].self, count: 4)
    _ = dummy(of: StructDummy.self)
    _ = dummy(of: [StructDummy].self, count: 5)
    _ = dummy(of: StructDummyableMarkedInit.self)
    _ = dummy(of: [StructDummyableMarkedInit].self, count: 6)
    _ = dummy(of: ClassDummyableMarkedInit.self)
    _ = dummy(of: [ClassDummyableMarkedInit].self, count: 7)
    _ = dummy(of: EnumDummyable.self)
    _ = dummy(of: [EnumDummyable].self, count: 8)
    _ = dummy(of: EnumDummyableMarkedCase.self)
    _ = dummy(of: [EnumDummyableMarkedCase].self, count: 9)
    _ = dummy(of: ManualDummy.self)
    _ = dummy(of: [ManualDummy].self, count: 10)
    _ = dummy(of: PublicManualDummy.self)
    _ = dummy(of: [PublicManualDummy].self, count: 11)
    _ = dummy(of: PrivateManualDummy.self)
    _ = dummy(of: [PrivateManualDummy].self, count: 12)
    _ = dummy(of: GenericDummyA<String>.self)
    _ = dummy(of: [GenericDummyA<Double>].self, count: 13)
    _ = dummy(of: GenericDummyB<Int>.self)
    _ = dummy(of: [GenericDummyB<Bool>].self, count: 14)
    _ = dummy(of: PublicGenericDummy<Int>.self)
    _ = dummy(of: [PublicGenericDummy<Bool>].self, count: 15)
    _ = dummy(of: PrivateGenericDummy<Int>.self)
    _ = dummy(of: [PrivateGenericDummy<Bool>].self, count: 16)
}
