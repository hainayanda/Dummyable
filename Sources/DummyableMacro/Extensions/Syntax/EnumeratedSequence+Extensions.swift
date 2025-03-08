//
//  EnumeratedSequence+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 09/03/25.
//

import Foundation

extension EnumeratedSequence {
    func mapElement<T>(_ transform: (Base.Element) -> T) -> [(offset: Int, element: T)] {
        map { (index, element) in
            return (index, transform(element))
        }
    }
}
