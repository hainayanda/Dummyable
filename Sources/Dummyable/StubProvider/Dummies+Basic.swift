//
//  BasicDummy.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import Foundation

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Any.Type) -> Any { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: AnyClass.Type) -> AnyClass { NSObject.self }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: AnyHashable.Type) -> AnyHashable { AnyHashable(0) }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: AnyObject.Type) -> AnyObject { NSObject() }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Void.Type) { }

// periphery:ignore:parameters type
@inlinable public func dummy<T>(of type: T?.Type) -> T? { nil }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: NSNull.Type) -> NSNull { NSNull() }

// periphery:ignore:parameters type
@inlinable public func dummy<T>(of type: [T].Type) -> [T] { [] }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: NSArray.Type) -> NSArray { NSArray() }

// periphery:ignore:parameters type
@inlinable public func dummy<T>(of type: Set<T>.Type) -> Set<T> { [] }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: NSSet.Type) -> NSSet { NSSet() }

// periphery:ignore:parameters type
@inlinable public func dummy<Key, Value>(of type: [Key: Value].Type) -> [Key: Value] {
    [:]
}

// periphery:ignore:parameters type
@inlinable public func dummy(of type: NSDictionary.Type) -> NSDictionary { NSDictionary() }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Bool.Type) -> Bool { false }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Int.Type) -> Int { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Int8.Type) -> Int8 { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Int16.Type) -> Int16 { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Int32.Type) -> Int32 { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Int64.Type) -> Int64 { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: UInt.Type) -> UInt { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: UInt8.Type) -> UInt8 { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: UInt16.Type) -> UInt16 { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: UInt32.Type) -> UInt32 { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: UInt64.Type) -> UInt64 { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Float.Type) -> Float { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Double.Type) -> Double { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Decimal.Type) -> Decimal { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: NSDecimalNumber.Type) -> NSDecimalNumber { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: NSNumber.Type) -> NSNumber { 0 }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Calendar.Type) -> Calendar { Calendar.current }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Locale.Type) -> Locale { Locale.current }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: TimeZone.Type) -> TimeZone { TimeZone.current }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: String.Type) -> String { "" }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: NSString.Type) -> NSString { "" as NSString }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Character.Type) -> Character { Character("") }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: AttributedString.Type) -> AttributedString {
    AttributedString("")
}

// periphery:ignore:parameters type
@inlinable public func dummy(of type: NSMutableAttributedString.Type) -> NSMutableAttributedString {
    NSMutableAttributedString()
}

// periphery:ignore:parameters type
@inlinable public func dummy(of type: NSAttributedString.Type) -> NSAttributedString {
    NSAttributedString()
}

// periphery:ignore:parameters type
@inlinable public func dummy(of type: URL.Type) -> URL { URL(fileURLWithPath: "") }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Data.Type) -> Data { Data() }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: UUID.Type) -> UUID { UUID() }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Date.Type) -> Date { Date() }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: IndexPath.Type) -> IndexPath { IndexPath() }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: IndexSet.Type) -> IndexSet { IndexSet() }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: CGFloat.Type) -> CGFloat { .zero }
