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

func testCompiledDummyCreation() {
    _ = Dummies.dummy(of: StructDummyProtocol.self)
    _ = Dummies.dummy(of: ClassDummyProtocol.self)
    _ = Dummies.dummy(of: AnyObjectDummyProtocol.self)
    _ = Dummies.dummy(of: StructDummy.self)
    _ = Dummies.dummy(of: StructDummyableMarkedInit.self)
    _ = Dummies.dummy(of: ClassDummyableMarkedInit.self)
}
