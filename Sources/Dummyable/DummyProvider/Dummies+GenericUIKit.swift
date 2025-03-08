//
//  Dummies+GenericUIKit.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

#if canImport(UIKit)
import UIKit

// MARK: UIView

// periphery:ignore:parameters type
@inlinable public func dummy<A: UIView>(of type: A.Type) -> A { A() }
// periphery:ignore:parameters type
@inlinable public func dummy<A: UIView>(of type: Closure<A>.Type) -> Closure<A> {
    return { dummy(of: A.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B: UIView>(of type: ArgClosure<A, B>.Type) -> ArgClosure<A, B> {
    return { _ in dummy(of: B.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C: UIView>(of type: TwoArgsClosure<A, B, C>.Type) -> TwoArgsClosure<A, B, C> {
    return { _, _ in dummy(of: C.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D: UIView>(of type: ThreeArgsClosure<A, B, C, D>.Type) -> ThreeArgsClosure<A, B, C, D> {
    return { _, _, _ in dummy(of: D.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D, E: UIView>(of type: FourArgsClosure<A, B, C, D, E>.Type) -> FourArgsClosure<A, B, C, D, E> {
    return { _, _, _, _ in dummy(of: E.self) }
}

// MARK: UIViewController

// periphery:ignore:parameters type
@inlinable public func dummy<A: UIViewController>(of type: A.Type) -> A { A() }
// periphery:ignore:parameters type
@inlinable public func dummy<A: UIViewController>(of type: Closure<A>.Type) -> Closure<A> {
    return { dummy(of: A.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B: UIViewController>(of type: ArgClosure<A, B>.Type) -> ArgClosure<A, B> {
    return { _ in dummy(of: B.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C: UIViewController>(of type: TwoArgsClosure<A, B, C>.Type) -> TwoArgsClosure<A, B, C> {
    return { _, _ in dummy(of: C.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D: UIViewController>(of type: ThreeArgsClosure<A, B, C, D>.Type) -> ThreeArgsClosure<A, B, C, D> {
    return { _, _, _ in dummy(of: D.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D, E: UIViewController>(of type: FourArgsClosure<A, B, C, D, E>.Type) -> FourArgsClosure<A, B, C, D, E> {
    return { _, _, _, _ in dummy(of: E.self) }
}

// MARK: UIWindow

// periphery:ignore:parameters type
@inlinable public func dummy<A: UIWindow>(of type: A.Type) -> A { A() }
// periphery:ignore:parameters type
@inlinable public func dummy<A: UIWindow>(of type: Closure<A>.Type) -> Closure<A> {
    return { dummy(of: A.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B: UIWindow>(of type: ArgClosure<A, B>.Type) -> ArgClosure<A, B> {
    return { _ in dummy(of: B.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C: UIWindow>(of type: TwoArgsClosure<A, B, C>.Type) -> TwoArgsClosure<A, B, C> {
    return { _, _ in dummy(of: C.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D: UIWindow>(of type: ThreeArgsClosure<A, B, C, D>.Type) -> ThreeArgsClosure<A, B, C, D> {
    return { _, _, _ in dummy(of: D.self) }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D, E: UIWindow>(of type: FourArgsClosure<A, B, C, D, E>.Type) -> FourArgsClosure<A, B, C, D, E> {
    return { _, _, _, _ in dummy(of: E.self) }
}
#endif
