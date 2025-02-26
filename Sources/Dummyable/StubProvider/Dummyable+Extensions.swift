//
//  Dummyable+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import Foundation

extension Optional: Dummyable {
    public static var dummy: Wrapped? { nil }
}

extension Array: Dummyable {
    public static var dummy: [Element] { [] }
}

extension Dictionary: Dummyable {
    public static var dummy: [Key: Value] { [:] }
}

extension Set: Dummyable {
    public static var dummy: Set<Element> { [] }
}

extension Bool: Dummyable {
    public static var dummy: Bool { false }
}

extension Int: Dummyable {
    public static var dummy: Int { 0 }
}

extension Int8: Dummyable {
    public static var dummy: Int8 { 0 }
}

extension Int16: Dummyable {
    public static var dummy: Int16 { 0 }
}

extension Int32: Dummyable {
    public static var dummy: Int32 { 0 }
}

extension Int64: Dummyable {
    public static var dummy: Int64 { 0 }
}

extension UInt: Dummyable {
    public static var dummy: UInt { 0 }
}

extension UInt8: Dummyable {
    public static var dummy: UInt8 { 0 }
}

extension UInt16: Dummyable {
    public static var dummy: UInt16 { 0 }
}

extension UInt32: Dummyable {
    public static var dummy: UInt32 { 0 }
}

extension UInt64: Dummyable {
    public static var dummy: UInt64 { 0 }
}

extension Float: Dummyable {
    public static var dummy: Float { 0 }
}

extension Float16: Dummyable {
    public static var dummy: Float16 { 0 }
}

extension Double: Dummyable {
    public static var dummy: Double { 0 }
}

extension Character: Dummyable {
    public static var dummy: Character { Character("") }
}

extension String: Dummyable {
    public static var dummy: String { "" }
}

extension Data: Dummyable {
    public static var dummy: Data { Data() }
}

extension UUID: Dummyable {
    public static var dummy: UUID { UUID() }
}

extension CGFloat: Dummyable {
    public static var dummy: CGFloat { .zero }
}

extension CGSize: Dummyable {
    public static var dummy: CGSize { .zero }
}

extension CGPoint: Dummyable {
    public static var dummy: CGPoint { .zero }
}

extension CGRect: Dummyable {
    public static var dummy: CGRect { .zero }
}

extension NSObject: Dummyable {
    public static var dummy: Self { Self() }
}
