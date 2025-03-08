//
//  BasicDummy.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import Foundation

#PublicDummy(of: Any.self) { 0 }
#PublicDummy(of: AnyClass.self) { NSObject.self }
#PublicDummy(of: AnyHashable.self) { AnyHashable(0) }
#PublicDummy(of: AnyObject.self) { NSObject() }
#PublicDummy(of: Void.self) { }
#PublicDummy(of: NSNull.self) { NSNull() }
#PublicDummy(of: NSArray.self) { NSArray() }
#PublicDummy(of: NSSet.self) { NSSet() }
#PublicDummy(of: NSDictionary.self) { NSDictionary() }
#PublicDummy(of: Bool.self) { false }
#PublicDummy(of: Int.self) { 0 }
#PublicDummy(of: Int8.self) { 0 }
#PublicDummy(of: Int16.self) { 0 }
#PublicDummy(of: Int32.self) { 0 }
#PublicDummy(of: Int64.self) { 0 }
#PublicDummy(of: UInt.self) { 0 }
#PublicDummy(of: UInt8.self) { 0 }
#PublicDummy(of: UInt16.self) { 0 }
#PublicDummy(of: UInt32.self) { 0 }
#PublicDummy(of: UInt64.self) { 0 }
#PublicDummy(of: Float.self) { 0 }
#PublicDummy(of: Double.self) { 0 }
#PublicDummy(of: Decimal.self) { 0 }
#PublicDummy(of: NSDecimalNumber.self) { 0 }
#PublicDummy(of: NSNumber.self) { 0 }
#PublicDummy(of: Calendar.self) { Calendar.current }
#PublicDummy(of: Locale.self) { Locale.current }
#PublicDummy(of: TimeZone.self) { TimeZone.current }
#PublicDummy(of: String.self) { "" }
#PublicDummy(of: NSString.self) { "" as NSString }
#PublicDummy(of: Character.self) { Character("") }
#PublicDummy(of: AttributedString.self) { AttributedString("") }
#PublicDummy(of: NSMutableAttributedString.self) { NSMutableAttributedString() }
#PublicDummy(of: NSAttributedString.self) { NSAttributedString() }
#PublicDummy(of: URL.self) { URL(fileURLWithPath: "") }
#PublicDummy(of: Data.self) { Data() }
#PublicDummy(of: UUID.self) { UUID() }
#PublicDummy(of: Date.self) { Date() }
#PublicDummy(of: IndexPath.self) { IndexPath() }
#PublicDummy(of: IndexSet.self) { IndexSet() }
#PublicDummy(of: CGFloat.self) { .zero }
#PublicDummy(of: Array<Generic>.self, .isGeneric(0)) { [] }
#PublicDummy(of: Dictionary<Generic, Generic>.self, .isGeneric(0, 1)) { [:] }
#PublicDummy(of: Optional<Generic>.self, .isGeneric(0)) { nil }
#PublicDummy(of: Set<Generic>.self, .isGeneric(0)) { [] }
