//
//  DummyCreationType.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 08/03/25.
//

import SwiftSyntax

enum DummyCreationType {
    case dummyFuncCall
    case emptyInitCall(TokenSyntax)
    case codeBlock(CodeBlockItemListSyntax)
}
