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
    
    // MARK: Name
    
    static let dummy: TokenSyntax = "dummy"
    static let underscore: TokenSyntax = "_"
    
    // MARK: Type
    
    static let dummyType: TokenSyntax = "Dummy"
    static let typeType: TokenSyntax = "Type"
    static let voidType: TokenSyntax = "Void"
    static let closureType: TokenSyntax = "Closure"
    static let argClosureType: TokenSyntax = "ArgClosure"
    static let twoArgClosureType: TokenSyntax = "TwoArgsClosure"
    static let threeArgClosureType: TokenSyntax = "ThreeArgsClosure"
    static let fourArgClosureType: TokenSyntax = "FourArgsClosure"
    static let aType: TokenSyntax = "A"
    static let bType: TokenSyntax = "B"
    static let cType: TokenSyntax = "C"
    static let dType: TokenSyntax = "D"
}
