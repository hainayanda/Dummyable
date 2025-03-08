//
//  PublisherDummy.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

#if canImport(Combine)
import Combine

#PublicDummy(of: Future<Generic, Generic>.self, .isGeneric(0, 1)) {
    Future { _ in }
}
#PublicDummy(of: AnyPublisher<Generic, Generic>.self, .isGeneric(0, 1)) { Empty(completeImmediately: true).eraseToAnyPublisher()
}
#PublicDummy(of: PassthroughSubject<Generic, Generic>.self, .isGeneric(0, 1)) {
    PassthroughSubject()
}
#PublicDummy(
    of: CurrentValueSubject<Generic, Generic>.self,
    .isGeneric(0, 1),
    .where(0, conform: PlainInitializable.self)
) {
    CurrentValueSubject(.init())
}
#PublicDummy(of: AnyCancellable.self) { AnyCancellable {} }
#endif
