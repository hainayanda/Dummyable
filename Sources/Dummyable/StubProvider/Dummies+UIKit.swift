//
//  Dummies+UIKit.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

#if canImport(UIKit)
import UIKit

#PublicDummy(of: UIColor.self) { .clear }
#PublicDummy(of: UIImage.self) { UIImage() }
#PublicDummy(of: UIFont.self) { .systemFont(ofSize: 12) }
#endif
