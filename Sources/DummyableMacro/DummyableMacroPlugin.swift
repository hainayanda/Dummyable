//
//  DummyableMacroPlugin.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 22/02/25.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct DummyableMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DummyableMacro.self, DummyableInitMacro.self
    ]
}
