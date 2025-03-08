//
//  PublisherDummy.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

#if canImport(Combine)
import Combine

#PublicDummy(of: Future<Generic, Generic>.self) {
    Future { _ in }
}
#PublicDummy(of: AnyPublisher<Generic, Generic>.self) {
    Empty(completeImmediately: true).eraseToAnyPublisher()
}
#PublicDummy(of: PassthroughSubject<Generic, Generic>.self) {
    PassthroughSubject()
}
#PublicDummy(
    of: CurrentValueSubject<Generic, Generic>.self,
    .where(0, conform: PlainInitializable.self)
) {
    CurrentValueSubject(.init())
}
#PublicDummy(of: AnyCancellable.self) { AnyCancellable {} }
#endif
