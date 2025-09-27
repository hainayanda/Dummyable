//
//  Dummies+Async.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 27/09/25.
//

import Foundation

#PublicDummy(of: AsyncStream<Generic>.self) {
    AsyncStream { $0.finish() }
}
