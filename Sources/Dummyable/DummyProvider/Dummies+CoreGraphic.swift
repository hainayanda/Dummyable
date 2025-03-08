//
//  Dummies+CoreGraphic.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

#if canImport(CoreGraphics)
import CoreGraphics

#PublicDummy(of: CGSize.self) { .zero }
#PublicDummy(of: CGPoint.self) { .zero }
#PublicDummy(of: CGRect.self) { .zero }
#endif
