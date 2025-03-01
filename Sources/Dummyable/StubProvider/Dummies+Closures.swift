//
//  DummyProvider.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import Foundation

// periphery:ignore
extension Dummies {
    
    public typealias VoidClosure = () -> Void
    
    public static func dummy(of type: VoidClosure.Type) -> VoidClosure {
        { }
    }
    
    public typealias ArgVoidClosure<T> = (T) -> Void
    public typealias TwoArgsVoidClosure<A, B> = (A, B) -> Void
    public typealias ThreeArgsVoidClosure<A, B, C> = (A, B, C) -> Void
    public typealias FourArgsVoidClosure<A, B, C, D> = (A, B, C, D) -> Void
    
    public static func dummy<T>(of type: ArgVoidClosure<T>.Type) -> ArgVoidClosure<T> {
        { _ in }
    }
    
    public static func dummy<A, B>(of type: TwoArgsVoidClosure<A, B>.Type) -> TwoArgsVoidClosure<A, B> {
        { _, _  in }
    }
    
    public static func dummy<A, B, C>(of type: ThreeArgsVoidClosure<A, B, C>.Type) -> ThreeArgsVoidClosure<A, B, C> {
        { _, _, _  in }
    }
    
    public static func dummy<A, B, C, D>(of type: FourArgsVoidClosure<A, B, C, D>.Type) -> FourArgsVoidClosure<A, B, C, D> {
        { _, _, _, _ in }
    }
}
