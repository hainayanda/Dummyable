//
//  DummyProvider.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import Foundation

extension Dummies {
    
    public typealias VoidClosure = () -> Void
    
    public static func dummy(of type: VoidClosure.Type) -> VoidClosure {
        { }
    }
    
    public typealias ArgVoidClosure<T> = (T) -> Void
    public typealias TwoArgsVoidClosure<A, B> = (A, B) -> Void
    public typealias ThreeArgsVoidClosure<A, B, C> = (A, B, C) -> Void
    
    public static func dummy<T>(of type: ArgVoidClosure<T>.Type) -> ArgVoidClosure<T> {
        { _ in }
    }
    
    public static func dummy<A, B>(of type: TwoArgsVoidClosure<A, B>.Type) -> TwoArgsVoidClosure<A, B> {
        { _, _  in }
    }
    
    public static func dummy<A, B, C>(of type: ThreeArgsVoidClosure<A, B, C>.Type) -> ThreeArgsVoidClosure<A, B, C> {
        { _, _, _  in }
    }
    
    public typealias ReturnClosure<T> = () -> T
    public typealias TwoReturnClosure<A, B> = () -> (A, B)
    public typealias ThreeReturnClosure<A, B, C> = () -> (A, B, C)
    
    public static func dummy<T: Dummyable>(of type: ReturnClosure<T>.Type) -> ReturnClosure<T> {
        { dummy(of: T.self) }
    }
    
    public static func dummy<A: Dummyable, B: Dummyable>(of type: TwoReturnClosure<A, B>.Type) -> TwoReturnClosure<A, B> {
        { dummy(of: (A, B).self) }
    }
    
    public static func dummy<A: Dummyable, B: Dummyable, C: Dummyable>(of type: ThreeReturnClosure<A, B, C>.Type) -> ThreeReturnClosure<A, B, C> {
        { dummy(of: (A, B, C).self) }
    }
    
    public typealias ArgReturnClosure<A, X> = (A) -> X
    public typealias ArgTwoReturnClosure<A, X, Y> = (A) -> (X, Y)
    public typealias ArgThreeReturnClosure<A, X, Y, Z> = (A) -> (X, Y, Z)
    
    public static func dummy<A, X: Dummyable>(of type: ArgReturnClosure<A, X>.Type) -> ArgReturnClosure<A, X> {
        { _ in dummy(of: X.self) }
    }
    
    public static func dummy<A, X: Dummyable, Y: Dummyable>(of type: ArgTwoReturnClosure<A, X, Y>.Type) -> ArgTwoReturnClosure<A, X, Y> {
        { _ in dummy(of: (X, Y).self) }
    }
    
    public static func dummy<A, X: Dummyable, Y: Dummyable, Z: Dummyable>(of type: ArgThreeReturnClosure<A, X, Y, Z>.Type) -> ArgThreeReturnClosure<A, X, Y, Z> {
        { _ in dummy(of: (X, Y, Z).self) }
    }
    
    public typealias TwoArgsReturnClosure<A, B, X> = (A, B) -> X
    public typealias TwoArgsTwoReturnClosure<A, B, X, Y> = (A, B) -> (X, Y)
    public typealias TwoArgsThreeReturnClosure<A, B, X, Y, Z> = (A, B) -> (X, Y, Z)
    
    public static func dummy<A, B, X: Dummyable>(of type: TwoArgsReturnClosure<A, B, X>.Type) -> TwoArgsReturnClosure<A, B, X> {
        { _, _ in dummy(of: X.self) }
    }
    
    public static func dummy<A, B, X: Dummyable, Y: Dummyable>(of type: TwoArgsTwoReturnClosure<A, B, X, Y>.Type) -> TwoArgsTwoReturnClosure<A, B, X, Y> {
        { _, _ in dummy(of: (X, Y).self) }
    }
    
    public static func dummy<A, B, X: Dummyable, Y: Dummyable, Z: Dummyable>(of type: TwoArgsThreeReturnClosure<A, B, X, Y, Z>.Type) -> TwoArgsThreeReturnClosure<A, B, X, Y, Z> {
        { _, _ in dummy(of: (X, Y, Z).self) }
    }
    
    public typealias ThreeArgsReturnClosure<A, B, C, X> = (A, B, C) -> X
    public typealias ThreeArgsTwoReturnClosure<A, B, C, X, Y> = (A, B, C) -> (X, Y)
    public typealias ThreeArgsThreeReturnClosure<A, B, C, X, Y, Z> = (A, B, C) -> (X, Y, Z)
    
    public static func dummy<A, B, C, X: Dummyable>(of type: ThreeArgsReturnClosure<A, B, C, X>.Type) -> ThreeArgsReturnClosure<A, B, C, X> {
        { _, _, _ in dummy(of: X.self) }
    }
    
    public static func dummy<A, B, C, X: Dummyable, Y: Dummyable>(of type: ThreeArgsTwoReturnClosure<A, B, C, X, Y>.Type) -> ThreeArgsTwoReturnClosure<A, B, C, X, Y> {
        { _, _, _ in dummy(of: (X, Y).self) }
    }
    
    public static func dummy<A, B, C, X: Dummyable, Y: Dummyable, Z: Dummyable>(of type: ThreeArgsThreeReturnClosure<A, B, C, X, Y, Z>.Type) -> ThreeArgsThreeReturnClosure<A, B, C, X, Y, Z> {
        { _, _, _ in dummy(of: (X, Y, Z).self) }
    }
}
