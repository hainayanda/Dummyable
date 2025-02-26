//
//  BasicDummy.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import Foundation

public struct Dummies {
    public static func dummy(of type: Void.Type) { }
    
    public static func dummy<T: Dummyable>(of type: T.Type) -> T {
        type.dummy
    }
    
    public static func dummy<A: Dummyable, B: Dummyable>(of type: (A, B).Type) -> (A, B) {
        (dummy(of: A.self), dummy(of: B.self))
    }
    
    public static func dummy<A: Dummyable, B: Dummyable, C: Dummyable>(of type: (A, B, C).Type) -> (A, B, C) {
        (dummy(of: A.self), dummy(of: B.self), dummy(of: C.self))
    }
}
