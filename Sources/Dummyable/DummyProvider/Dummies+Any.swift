//
//  Dummies+Any.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import Foundation

// periphery:ignore:parameters type
@inlinable public func dummy(of type: Any.Type) -> Any { 0 }
// periphery:ignore:parameters type
@inlinable public func dummy(of type: Closure<Any>.Type) -> Closure<Any> {
    return { dummy(of: Any.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A>(of type: ArgClosure<A, Any>.Type) -> ArgClosure<A, Any> {
    return { _  in dummy(of: Any.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B>(of type: TwoArgsClosure<A, B, Any>.Type) -> TwoArgsClosure<A, B, Any> {
    return { _, _  in dummy(of: Any.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, Any>.Type) -> ThreeArgsClosure<A, B, C, Any> {
    return { _, _, _  in dummy(of: Any.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, Any>.Type) -> FourArgsClosure<A, B, C, D, Any> {
    return { _, _, _, _  in dummy(of: Any.self) }
}
