//
//  Closures.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import Foundation

public typealias Closure<A> = () -> A
public typealias ArgClosure<A, B> = (A) -> B
public typealias TwoArgsClosure<A, B, C> = (A, B) -> C
public typealias ThreeArgsClosure<A, B, C, D> = (A, B, C) -> D
public typealias FourArgsClosure<A, B, C, D, E> = (A, B, C, D) -> E
