//
//  DeclBuildersAggregator.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DeclBuildersAggregator: ArrayDeclBuilder {
    
    private let builders: [ArrayDeclBuilder]
    
    @inlinable init(_ builders: ArrayDeclBuilder?...) {
        self.builders = builders.compactMap { $0 }
    }
    
    @inlinable func buildDecls() throws -> [DeclSyntax] {
        try builders.flatMap {
            try $0.buildDecls()
        }
    }
}
