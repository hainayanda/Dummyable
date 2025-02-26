//
//  DummyableTokenSyntaxes.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 22/02/25.
//

import Foundation
import SwiftSyntax

public struct DummyableTokenSyntaxes {
    
    // MARK: label
    
    static let type: TokenSyntax = "type"
    static let `for`: TokenSyntax = "for"
    static let of: TokenSyntax = "of"
    static let get: TokenSyntax = "get"
    static let final: TokenSyntax = "final"
    
    // MARK: Name
    
    static let dummy: TokenSyntax = "dummy"
    
    // MARK: Type
    
    static let dummyType: TokenSyntax = "Dummy"
    static let dummyableType: TokenSyntax = "Dummyable"
    static let dummiesType: TokenSyntax = "Dummies"
    static let typeType: TokenSyntax = "Type"
    static let voidType: TokenSyntax = "Void"
}
