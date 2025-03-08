//
//  Dummies+SwiftUI.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

#if canImport(SwiftUI)
import SwiftUI

#PublicDummy(of: Color.self) { .clear }
#PublicDummy(of: Font.self) { .body }
#PublicDummy(of: Image.self) { Image(systemName: "circle") }
#endif
