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
    static let of: TokenSyntax = "of"
    static let get: TokenSyntax = "get"
    static let available: TokenSyntax = "available"
    
    // MARK: Name
    
    static let dummy: TokenSyntax = "dummy"
    static let underscore: TokenSyntax = "_"
    
    // MARK: Type
    
    static let dummyType: TokenSyntax = "Dummy"
    static let typeType: TokenSyntax = "Type"
    static let voidType: TokenSyntax = "Void"
    static let closureType: TokenSyntax = "Closure"
    static let argClosureType: TokenSyntax = "ArgClosure"
    static let twoArgsClosureType: TokenSyntax = "TwoArgsClosure"
    static let threeArgsClosureType: TokenSyntax = "ThreeArgsClosure"
    static let fourArgsClosureType: TokenSyntax = "FourArgsClosure"
    
    // MARK: Generics
    
    static let genericTypes: [TokenSyntax] = [
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
        "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
        "U", "V", "W", "X", "Y", "Z"
    ]
}
