//
//  Dummies+Generic.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import Foundation

// MARK: Any

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Any.Type) -> Any { 0 }
// periphery:ignore:parameters type
@inlinable public func dummy(of type: Closure<Any>.Type) -> Closure<Any> {
    {
        dummy(of: Any.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A>(of type: ArgClosure<A, Any>.Type) -> ArgClosure<A, Any> {
    { _ in
        dummy(of: Any.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B>(of type: TwoArgsClosure<A, B, Any>.Type) -> TwoArgsClosure<A, B, Any> {
    { _, _ in
        dummy(of: Any.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, Any>.Type) -> ThreeArgsClosure<A, B, C, Any> {
    { _, _, _ in
        dummy(of: Any.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, Any>.Type) -> FourArgsClosure<A, B, C, D, Any> {
    { _, _, _, _ in
        dummy(of: Any.self)
    }
}

// MARK: Optional

// periphery:ignore:parameters type
@inlinable public func dummy<A>(of type: A?.Type) -> A? { nil }
// periphery:ignore:parameters type
@inlinable public func dummy<A>(of type: Closure<A?>.Type) -> Closure<A?> {
    {
        dummy(of: A?.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B>(of type: ArgClosure<A, B?>.Type) -> ArgClosure<A, B?> {
    { _ in
        dummy(of: B?.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C>(of type: TwoArgsClosure<A, B, C?>.Type) -> TwoArgsClosure<A, B, C?> {
    { _, _ in
        dummy(of: C?.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D>(of type: ThreeArgsClosure<A, B, C, D?>.Type) -> ThreeArgsClosure<A, B, C, D?> {
    { _, _, _ in
        dummy(of: D?.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D, E>(of type: FourArgsClosure<A, B, C, D, E?>.Type) -> FourArgsClosure<A, B, C, D, E?> {
    { _, _, _, _ in
        dummy(of: E?.self)
    }
}

// MARK: Array

// periphery:ignore:parameters type
@inlinable public func dummy<T>(of type: [T].Type) -> [T] { [] }
// periphery:ignore:parameters type
@inlinable public func dummy<A>(of type: Closure<[A]>.Type) -> Closure<[A]> {
    {
        dummy(of: [A].self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B>(of type: ArgClosure<A, [B]>.Type) -> ArgClosure<A, [B]> {
    { _ in
        dummy(of: [B].self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C>(of type: TwoArgsClosure<A, B, [C]>.Type) -> TwoArgsClosure<A, B, [C]> {
    { _, _ in
        dummy(of: [C].self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D>(of type: ThreeArgsClosure<A, B, C, [D]>.Type) -> ThreeArgsClosure<A, B, C, [D]> {
    { _, _, _ in
        dummy(of: [D].self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D, E>(of type: FourArgsClosure<A, B, C, D, [E]>.Type) -> FourArgsClosure<A, B, C, D, [E]> {
    { _, _, _, _ in
        dummy(of: [E].self)
    }
}

// MARK: Dictionary

// periphery:ignore:parameters type
@inlinable public func dummy<Key, Value>(of type: [Key: Value].Type) -> [Key: Value] { [:] }
// periphery:ignore:parameters type
@inlinable public func dummy<A, B>(of type: Closure<[A: B]>.Type) -> Closure<[A: B]> {
    {
        dummy(of: [A: B].self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C>(of type: ArgClosure<A, [B: C]>.Type) -> ArgClosure<A, [B: C]> {
    { _ in
        dummy(of: [B: C].self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D>(of type: TwoArgsClosure<A, B, [C: D]>.Type) -> TwoArgsClosure<A, B, [C: D]> {
    { _, _ in
        dummy(of: [C: D].self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D, E>(of type: ThreeArgsClosure<A, B, C, [D: E]>.Type) -> ThreeArgsClosure<A, B, C, [D: E]> {
    { _, _, _ in
        dummy(of: [D: E].self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D, E, F>(of type: FourArgsClosure<A, B, C, D, [E: F]>.Type) -> FourArgsClosure<A, B, C, D, [E: F]> {
    { _, _, _, _ in
        dummy(of: [E: F].self)
    }
}
