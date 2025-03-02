//
//  Macros.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI

@attached(member, names: arbitrary)
@attached(peer, names: suffixed(Dummy), named(dummy(of:)))
public macro Dummyable() = #externalMacro(
    module: "DummyableMacro", type: "DummyableMacro"
)

@attached(peer, names: suffixed(Dummy), named(dummy(of:)))
public macro Dummyable(type: DummyType) = #externalMacro(
    module: "DummyableMacro", type: "DummyableMacro"
)

@attached(peer, names: arbitrary)
public macro DummyableInit() = #externalMacro(
    module: "DummyableMacro", type: "DummyableInitMacro"
)

@attached(peer, names: arbitrary)
public macro DummyableCase() = #externalMacro(
    module: "DummyableMacro", type: "DummyableCaseMacro"
)

@freestanding(declaration, names: named(dummy(of:)))
public macro Dummy<T>(of type: T.Type, dummyProvider: () -> T) = #externalMacro(
    module: "DummyableMacro", type: "DummyMacro"
)

@freestanding(declaration, names: named(dummy(of:)))
public macro PublicDummy<T>(of type: T.Type, dummyProvider: () -> T) = #externalMacro(
    module: "DummyableMacro", type: "DummyMacro"
)

@freestanding(declaration, names: named(dummy(of:)))
public macro PrivateDummy<T>(of type: T.Type, dummyProvider: () -> T) = #externalMacro(
    module: "DummyableMacro", type: "DummyMacro"
)
