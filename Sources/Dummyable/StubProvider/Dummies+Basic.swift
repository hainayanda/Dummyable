//
//  BasicDummy.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import Foundation

// periphery:ignore
public struct Dummies {
    
    @inlinable public static func dummy(of type: Any.Type) -> Any { 0 }
    
    @inlinable public static func dummy(of type: AnyClass.Type) -> AnyClass { NSObject.self }
    
    @inlinable public static func dummy(of type: AnyHashable.Type) -> AnyHashable { AnyHashable(0) }
    
    @inlinable public static func dummy(of type: AnyObject.Type) -> AnyObject { NSObject() }
    
    @inlinable public static func dummy(of type: Void.Type) { }
    
    @inlinable public static func dummy<T>(of type: T?.Type) -> T? { nil }
    
    @inlinable public static func dummy(of type: NSNull.Type) -> NSNull { NSNull() }
    
    @inlinable public static func dummy<T>(of type: [T].Type) -> [T] { [] }
    
    @inlinable public static func dummy(of type: NSArray.Type) -> NSArray { NSArray() }
    
    @inlinable public static func dummy<T>(of type: Set<T>.Type) -> Set<T> { [] }
    
    @inlinable public static func dummy(of type: NSSet.Type) -> NSSet { NSSet() }
    
    @inlinable public static func dummy<Key, Value>(of type: [Key: Value].Type) -> [Key: Value] {
        [:]
    }
    
    @inlinable public static func dummy(of type: NSDictionary.Type) -> NSDictionary { NSDictionary() }
    
    @inlinable public static func dummy(of type: Bool.Type) -> Bool { false }
    
    @inlinable public static func dummy(of type: Int.Type) -> Int { 0 }
    
    @inlinable public static func dummy(of type: Int8.Type) -> Int8 { 0 }
    
    @inlinable public static func dummy(of type: Int16.Type) -> Int16 { 0 }
    
    @inlinable public static func dummy(of type: Int32.Type) -> Int32 { 0 }
    
    @inlinable public static func dummy(of type: Int64.Type) -> Int64 { 0 }
    
    @inlinable public static func dummy(of type: UInt.Type) -> UInt { 0 }
    
    @inlinable public static func dummy(of type: UInt8.Type) -> UInt8 { 0 }
    
    @inlinable public static func dummy(of type: UInt16.Type) -> UInt16 { 0 }
    
    @inlinable public static func dummy(of type: UInt32.Type) -> UInt32 { 0 }
    
    @inlinable public static func dummy(of type: UInt64.Type) -> UInt64 { 0 }
    
    @inlinable public static func dummy(of type: Float.Type) -> Float { 0 }
    
    @inlinable public static func dummy(of type: Double.Type) -> Double { 0 }
    
    @inlinable public static func dummy(of type: Decimal.Type) -> Decimal { 0 }
    
    @inlinable public static func dummy(of type: NSDecimalNumber.Type) -> NSDecimalNumber { 0 }
    
    @inlinable public static func dummy(of type: NSNumber.Type) -> NSNumber { 0 }
    
    @inlinable public static func dummy(of type: Calendar.Type) -> Calendar { Calendar.current }
    
    @inlinable public static func dummy(of type: Locale.Type) -> Locale { Locale.current }
    
    @inlinable public static func dummy(of type: TimeZone.Type) -> TimeZone { TimeZone.current }
    
    @inlinable public static func dummy(of type: String.Type) -> String { "" }
    
    @inlinable public static func dummy(of type: NSString.Type) -> NSString { "" as NSString }
    
    @inlinable public static func dummy(of type: Character.Type) -> Character { Character("") }
    
    @inlinable public static func dummy(of type: AttributedString.Type) -> AttributedString {
        AttributedString("")
    }
    
    @inlinable public static func dummy(of type: NSMutableAttributedString.Type) -> NSMutableAttributedString {
        NSMutableAttributedString()
    }
    
    @inlinable public static func dummy(of type: NSAttributedString.Type) -> NSAttributedString {
        NSAttributedString()
    }
    
    @inlinable public static func dummy(of type: URL.Type) -> URL { URL(fileURLWithPath: "") }
    
    @inlinable public static func dummy(of type: Data.Type) -> Data { Data() }
    
    @inlinable public static func dummy(of type: UUID.Type) -> UUID { UUID() }
    
    @inlinable public static func dummy(of type: Date.Type) -> Date { Date() }
    
    @inlinable public static func dummy(of type: IndexPath.Type) -> IndexPath { IndexPath() }
    
    @inlinable public static func dummy(of type: IndexSet.Type) -> IndexSet { IndexSet() }
    
    @inlinable public static func dummy(of type: CGFloat.Type) -> CGFloat { .zero }
}
