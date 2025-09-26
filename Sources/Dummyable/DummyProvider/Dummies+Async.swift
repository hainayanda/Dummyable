//
//  Dummies+Async.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 27/09/25.
//

import Foundation

#PublicDummy(
    of: AsyncThrowingStream<Generic,
    Error>.self,
    .where(1, conform: Error.self)
) {
    AsyncThrowingStream { $0.finish() }
}

#PublicDummy(of: AsyncStream<Generic>.self) {
    AsyncStream { $0.finish() }
}
