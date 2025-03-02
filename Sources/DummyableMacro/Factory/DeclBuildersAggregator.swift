//
//  DeclBuildersAggregator.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DeclBuildersAggregator {
    
    private let builders: [DeclBuilder]
    
    @inlinable init(_ builders: DeclBuilder...) {
        self.builders = builders
    }
    
    @inlinable func buildAllDecl() throws -> [DeclSyntax] {
        try builders.compactMap { try $0.buildDecl() }
    }
}
