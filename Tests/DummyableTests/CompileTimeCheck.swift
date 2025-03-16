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
    let structDummyProtocol: StructDummyProtocol = dummy(of: StructDummyProtocol.self)
    let structDummyProtocols: [StructDummyProtocol] = dummy(of: [StructDummyProtocol].self, count: 2)
    let classDummyProtocol: ClassDummyProtocol = dummy(of: ClassDummyProtocol.self)
    let classDummyProtocols: [ClassDummyProtocol] = dummy(of: [ClassDummyProtocol].self, count: 3)
    let anyObjectDummyProtocol: AnyObjectDummyProtocol = dummy(of: AnyObjectDummyProtocol.self)
    let anyObjectDummyProtocols: [AnyObjectDummyProtocol] = dummy(of: [AnyObjectDummyProtocol].self, count: 4)
    let structDummy: StructDummy = dummy(of: StructDummy.self)
    let structDummies: [StructDummy] = dummy(of: [StructDummy].self, count: 5)
    let structDummyableMarkedInit: StructDummyableMarkedInit = dummy(of: StructDummyableMarkedInit.self)
    let structDummyableMarkedInits: [StructDummyableMarkedInit] = dummy(of: [StructDummyableMarkedInit].self, count: 6)
    let classDummyableMarkedInit: ClassDummyableMarkedInit = dummy(of: ClassDummyableMarkedInit.self)
    let classDummyableMarkedInits: [ClassDummyableMarkedInit] = dummy(of: [ClassDummyableMarkedInit].self, count: 7)
    let enumDummyable: EnumDummyable = dummy(of: EnumDummyable.self)
    let enumDummyables: [EnumDummyable] = dummy(of: [EnumDummyable].self, count: 8)
    let enumDummyableMarkedCase: EnumDummyableMarkedCase = dummy(of: EnumDummyableMarkedCase.self)
    let enumDummyableMarkedCases: [EnumDummyableMarkedCase] = dummy(of: [EnumDummyableMarkedCase].self, count: 9)
    let manualDummy: ManualDummy = dummy(of: ManualDummy.self)
    let manualDummies: [ManualDummy] = dummy(of: [ManualDummy].self, count: 10)
    let publicManualDummy: PublicManualDummy = dummy(of: PublicManualDummy.self)
    let publicManualDummies: [PublicManualDummy] = dummy(of: [PublicManualDummy].self, count: 11)
    let privateManualDummy: PrivateManualDummy = dummy(of: PrivateManualDummy.self)
    let privateManualDummies: [PrivateManualDummy] = dummy(of: [PrivateManualDummy].self, count: 12)
    let genericDummyA: GenericDummyA<String> = dummy(of: GenericDummyA<String>.self)
    let genericDummyAs: [GenericDummyA<Double>] = dummy(of: [GenericDummyA<Double>].self, count: 13)
    let genericDummyB: GenericDummyB<Int> = dummy(of: GenericDummyB<Int>.self)
    let genericDummyBs: [GenericDummyB<Bool>] = dummy(of: [GenericDummyB<Bool>].self, count: 14)
    let publicGenericDummy: PublicGenericDummy<Float> = dummy(of: PublicGenericDummy<Float>.self)
    let publicGenericDummies: [PublicGenericDummy<Int64>] = dummy(of: [PublicGenericDummy<Int64>].self, count: 15)
    let privateGenericDummy: PrivateGenericDummy<AnyHashable> = dummy(of: PrivateGenericDummy<AnyHashable>.self)
    let privateGenericDummies: [PrivateGenericDummy<Generic>] = dummy(of: [PrivateGenericDummy<Generic>].self, count: 16)
}
