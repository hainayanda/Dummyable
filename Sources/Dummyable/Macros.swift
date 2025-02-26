//
//  Macros.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 22/02/25.
//

import SwiftUI

@attached(extension, names: arbitrary)
@attached(peer, names: named(dummy), suffixed(Dummy))
@attached(extension, conformances: Dummyable, names: arbitrary)
public macro Dummyable() = #externalMacro(
    module: "DummyableMacro", type: "DummyableMacro"
)

@attached(extension, names: arbitrary)
@attached(peer, names: suffixed(Dummy))
public macro Dummyable(type: DummyType) = #externalMacro(
    module: "DummyableMacro", type: "DummyableMacro"
)

@attached(peer, names: arbitrary)
public macro DummyableInit() = #externalMacro(
    module: "DummyableMacro", type: "DummyableInitMacro"
)

public enum DummyType {
    case `struct`
    case `class`
}
