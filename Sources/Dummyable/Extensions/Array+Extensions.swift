//
//  Array+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 08/03/25.
//

import Foundation

public extension Array {
    init(repeat repeatingCount: Int, with provider: () -> Element) {
        self.init(
            (0..<repeatingCount).map { _ in provider() }
        )
    }
}
