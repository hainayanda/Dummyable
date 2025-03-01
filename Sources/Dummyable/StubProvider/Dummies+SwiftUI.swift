//
//  Dummies+SwiftUI.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

#if canImport(SwiftUI)
import SwiftUI

// periphery:ignore
extension Dummies {
    public static func dummy(of type: Color.Type) -> Color {
        Color.clear
    }
    
    public static func dummy(of type: Font.Type) -> Font {
        Font.body
    }
    
    public static func dummy(of type: Image.Type) -> Image {
        Image(systemName: "circle")
    }

}
#endif
