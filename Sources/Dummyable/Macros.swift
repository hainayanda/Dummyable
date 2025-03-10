//
//  Macros.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI

// periphery:ignore

// MARK: Dummyable

@attached(member, names: arbitrary)
@attached(peer, names: suffixed(Dummy), named(dummy(of:)), named(dummy(of:count:)))
public macro Dummyable() = #externalMacro(
    module: "DummyableMacro", type: "DummyableMacro"
)

@attached(peer, names: suffixed(Dummy), named(dummy(of:)), named(dummy(of:count:)))
public macro Dummyable(type: DummyType) = #externalMacro(
    module: "DummyableMacro", type: "DummyableMacro"
)

// MARK: DummyableInit

@attached(peer, names: arbitrary)
public macro DummyableInit() = #externalMacro(
    module: "DummyableMacro", type: "DummyableInitMacro"
)

// MARK: DummyableCase

@attached(peer, names: arbitrary)
public macro DummyableCase() = #externalMacro(
    module: "DummyableMacro", type: "DummyableCaseMacro"
)

// MARK: Dummy

@freestanding(declaration, names: named(dummy(of:)), named(dummy(of:count:)))
public macro Dummy<T>(of type: T.Type, _ meta: DummyMetadata..., dummyProvider: () -> T) = #externalMacro(
    module: "DummyableMacro", type: "DummyMacro"
)

@freestanding(declaration, names: named(dummy(of:)), named(dummy(of:count:)))
public macro Dummy<T>(of type: T.Type, dummyProvider: () -> T) = #externalMacro(
    module: "DummyableMacro", type: "DummyMacro"
)

// MARK: PublicDummy

@freestanding(declaration, names: named(dummy(of:)), named(dummy(of:count:)))
public macro PublicDummy<T>(of type: T.Type, _ meta: DummyMetadata..., dummyProvider: () -> T) = #externalMacro(
    module: "DummyableMacro", type: "DummyMacro"
)

@freestanding(declaration, names: named(dummy(of:)), named(dummy(of:count:)))
public macro PublicDummy<T>(of type: T.Type, dummyProvider: () -> T) = #externalMacro(
    module: "DummyableMacro", type: "DummyMacro"
)

// MARK: PrivateDummy

@freestanding(declaration, names: named(dummy(of:)), named(dummy(of:count:)))
public macro PrivateDummy<T>(of type: T.Type, _ meta: DummyMetadata..., dummyProvider: () -> T) = #externalMacro(
    module: "DummyableMacro", type: "DummyMacro"
)

@freestanding(declaration, names: named(dummy(of:)), named(dummy(of:count:)))
public macro PrivateDummy<T>(of type: T.Type, dummyProvider: () -> T) = #externalMacro(
    module: "DummyableMacro", type: "DummyMacro"
)
