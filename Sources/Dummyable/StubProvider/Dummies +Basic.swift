//
//  BasicDummy.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import Foundation

// periphery:ignore
public struct Dummies {
    public static func dummy(of type: Void.Type) { }
    
    public static func dummy<T>(of type: Optional<T>.Type) -> Optional<T> { nil }
    
    public static func dummy<T>(of type: Array<T>.Type) -> Array<T> { [] }
    
    public static func dummy<T>(of type: Set<T>.Type) -> Set<T> { [] }
    
    public static func dummy<Key, Value>(of type: Dictionary<Key, Value>.Type) -> Dictionary<Key, Value> {
        [:]
    }
    
    public static func dummy(of type: Any.Type) -> Any { 0 }
    
    public static func dummy(of type: AnyClass.Type) -> AnyClass { NSObject.self }
    
    public static func dummy(of type: AnyHashable.Type) -> AnyHashable { AnyHashable(0) }
    
    public static func dummy(of type: AnyObject.Type) -> AnyObject { NSObject() }
    
    public static func dummy(of type: Bool.Type) -> Bool { false }
    
    public static func dummy(of type: Int.Type) -> Int { 0 }
    
    public static func dummy(of type: Int8.Type) -> Int8 { 0 }
    
    public static func dummy(of type: Int16.Type) -> Int16 { 0 }
    
    public static func dummy(of type: Int32.Type) -> Int32 { 0 }
    
    public static func dummy(of type: Int64.Type) -> Int64 { 0 }
    
    public static func dummy(of type: UInt.Type) -> UInt { 0 }
    
    public static func dummy(of type: UInt8.Type) -> UInt8 { 0 }
    
    public static func dummy(of type: UInt16.Type) -> UInt16 { 0 }
    
    public static func dummy(of type: UInt32.Type) -> UInt32 { 0 }
    
    public static func dummy(of type: UInt64.Type) -> UInt64 { 0 }
    
    public static func dummy(of type: Float.Type) -> Float { 0 }
    
    public static func dummy(of type: Double.Type) -> Double { 0 }
    
    public static func dummy(of type: String.Type) -> String { "" }
    
    public static func dummy(of type: Character.Type) -> Character { Character("") }
    
    public static func dummy(of type: URL.Type) -> URL { URL(fileURLWithPath: "") }
    
    public static func dummy(of type: Data.Type) -> Data { Data() }
    
    public static func dummy(of type: UUID.Type) -> UUID { UUID() }
    
    public static func dummy(of type: Date.Type) -> Date { Date() }
    
    public static func dummy(of type: IndexPath.Type) -> IndexPath { IndexPath() }
    
    public static func dummy(of type: IndexSet.Type) -> IndexSet { IndexSet() }
    
    public static func dummy(of type: CGFloat.Type) -> CGFloat { .zero }
    
    public static func dummy(of type: CGSize.Type) -> CGSize { .zero }
    
    public static func dummy(of type: CGPoint.Type) -> CGPoint { .zero }
    
    public static func dummy(of type: CGRect.Type) -> CGRect { .zero }
}
