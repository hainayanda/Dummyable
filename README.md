# Dummyable

`Dummyable` is a lightweight utility for easily generating dummy instances of Swift types for testing and prototyping.

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/dcaa4fc883d94d6bb73abaf8a8fa5edc)](https://app.codacy.com/gh/hainayanda/Dummyable/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
[![Unit Test](https://github.com/hainayanda/Dummyable/actions/workflows/test.yml/badge.svg)](https://github.com/hainayanda/Dummyable/actions/workflows/test.yml)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen)](https://swift.org/package-manager/)

## Requirements

- Swift 5.9 or higher
- iOS 15.0 or higher
- macOS 12.0 or higher
- tvOS 15.0 or higher
- watchOS 8.0 or higher
- visionOS 1.0 or higher
- Xcode 15 or higher

## Installation

### Swift Package Manager (Xcode)

To install using Xcode's Swift Package Manager, follow these steps:

- Go to **File > Swift Package > Add Package Dependency**
- Enter the URL: **<https://github.com/hainayanda/Dummyable.git>**
- Choose **Up to Next Major** for the version rule and set the version to **1.0.0**.
- Click "Next" and wait for the package to be fetched.

### Swift Package Manager (Package.swift)

If you prefer using Package.swift, add Dummyable as a dependency in your **Package.swift** file:

```swift
dependencies: [
    .package(url: "https://github.com/hainayanda/Dummyable.git", .upToNextMajor(from: "1.0.0"))
]
```

Then, include it in your target:

```swift
 .target(
    name: "MyModule",
    dependencies: ["Dummyable"]
)
```

## Usage

### Creating Dummy Instance

Dummyable provides an easy way to create dummy instances of basic types:

```swift
let intDummy = dummy(of: Int.self)
let intDummies = dummy(of: [Int].self, count: 10)
```

If your type marked with `@Dummyable` or has associated `#Dummy` macro declaration, you can create a dummy instance by calling the `dummy(of:)` global function:

```swift
let someDummy = dummy(of: SomeMarkedWithDummyable.self)
```

### Enabling Dummy Creation on Protocol

`Dummyable` allow you to create dummy instances from a protocol by marking it with `@Dummyable`:

```swift
@Dummyable(.struct)
protocol SomeModelProtocol { 
    var title: String { get }
    var description: String { get set }
    // SomeType must be marked with @Dummyable, have #Dummy macro declaration, or provided by a `dummy(of:)` global function
    var someType: SomeType { get }
    init(title: String, description: String)
    func doSomething()
}
```

If you want to create a class instance, you can do one of theese following methods:

```swift
// tell Dummyable to implement the protocol to a dummy class
@Dummyable(.class)
protocol SomeModelProtocol { }

// tell Dummyable the protocol is an object
@Dummyable
protocol SomeObjectProtocol: AnyObject { }

// tell Dummyable the protocol is a class instance
@Dummyable
protocol SomeClassProtocol: class { }
```

Keep in mind that the `@Dummyable` macro will not work well on protocol has an associated type or has an inheritance clause.


### Enabling Dummy on a Struct

`Dummyable` also allows you to create dummy instances from a struct by marking it with `@Dummyable`:

```swift
@Dummyable
struct SomeModel { 
    let title: String
    var description: String
    
    // SomeType must be marked with @Dummyable, have #Dummy macro declaration, or provided by a `dummy(of:)` global function
    let someType: SomeType
    
    func doSomething() { 
        // do something
    }
}
```

If you prefer the dummy to created using some custom initializer, you can mark it with `@DummyableInit`:

```swift
@Dummyable
struct SomeModel { 
    let title: String
    var description: String
    
    // SomeType must be marked with @Dummyable, have #Dummy macro declaration, or provided by a `dummy(of:)` global function
    let someType: SomeType
    
    @DummyableInit
    init(title: String, description: String = "", someType: SomeType) {
        self.title = title
        self.description = description
    }
    
    func doSomething() { 
        // do something
    }
}
```

Then it will create a dummy instance using marked ini by only provide the parameter that is have no default value.

The macro will still work on struct with generic parameter as long as the mandatory type can be created using `dummy(of:)` global function.

### Enabling Dummy on a Class

`Dummyable` also allows you to create dummy instances from a class by marking it with `@Dummyable`. But since a class might have a superclass, `@DummyableInit` to make it work:

```swift
@Dummyable
class SomeModel { 
    let title: String
    var description: String
    
    // SomeType must be marked with @Dummyable, have #Dummy macro declaration, or provided by a `dummy(of:)` global function
    let someType: SomeType
    
    @DummyableInit
    init(title: String, description: String, someType: SomeType) {
        self.title = title
        self.description = description
    }
}
```

The macro will still work on class with generic parameter as long as the mandatory type can be created using `dummy(of:)` global function.

### Enabling Dummy on an Enum

`Dummyable` also allows you to create dummy instances from an enum by marking it with `@Dummyable`:

```swift
@Dummyable
enum SomeEnum {
    case one
    case two
    case three
}
```

It will try to create an instance using the last case, and the one with least associated value.

If you want to make sure the dummy instance is created with a specific case, you can mark the enum with `@DummyableCase`:

```swift
@Dummyable
enum SomeEnum {
    @DummyableCase case one
    case two
    case three
}
```

The macro will still work on enum with generic parameter as long as the mandatory type can be created using `dummy(of:)` global function.

### Dummy with no Declaration

If you want enable dummy creation on a type that you don't have access to the declaration, you can use the `#Dummy` macro:

```swift
#Dummy(SomeType.self) { 
    SomeType()
}
```

This will be helpful if you have a dependency that you want to mock, but you don't have access to the declaration. You can also use this to create a dummy instance of Closure, Tuple or some other type that is not a class, struct, or enum:

```swift
#Dummy((() -> (Int, String)).self) {
    { (1, "Hello") }
}
```

By default, the global `dummy(of:)` function will have no modifier and act as internal function. To make it public or fileprivate, use `#PublicDummy` or `#PrivateDummy` macro:

```swift
// or #PrivateDummy for fileprivate global function
#PublicDummy(SomeType.self) { 
    SomeType()
}
```

if your type has a generic parameter, you can provide the generic parameter using `Generic` type as well:

```swift
#Dummy(TypeWithGeneric<Generic>.self) {
    TypeWithGeneric()
}
```


`Generic` is a real type that implements `Hashable`, `Equatable`, `Identifiable`, `Sendable`, `Error`, and `Codable`. You can implement more if you need to. But in case you can't, you can use any generic parameter and tell `#Dummy` macro to treat it as a generic parameter:

```swift
// tell #Dummy to treat the generic parameter at 0 as generic
#Dummy(TypeWithGeneric<String>.self, .isGeneric(0)) {
    TypeWithGeneric()
}
```

If you want to add where clause to the generic parameter, you can do so by providing the where clause:

```swift
#Dummy(TypeWithGeneric<String>.self, .where(0, conform: SomeProtocol.self, (any Equatable).self)) {
    TypeWithGeneric()
}
```

If the Type is only available in a specific platform, you can provide the platform:

```swift
#Dummy(TypeWithGeneric<String>.self, .availble(.iOS(15.0))) {
    TypeWithGeneric()
}
```

### How Dummyable Works

`Dummyable` works by assuming that the mandatory type needed can be created using `dummy(of:)` global function:

```swift
// on the generated code
self.title = dummy(of: String.self)
```

So it will throw a compile-time error if the type can't be created using `dummy(of:)` global function:

```swift
// on the generated code
self.someType = dummy(of: SomeType.self) // Default argument value of type 'Any' cannot be converted to type 'SomeType'
```

To fix this, you need to mark the type with `@Dummyable` or provide a `#Dummy` macro declaration. Or at least manually create a global `dummy(of:)` function that returns the type:

```swift
func dummy(of type: SomeType.Type) -> SomeType {
    SomeType()
}
```

But doing it manually will not provide you with `dummy(of:count:)` and some other global function that use the type that is generated by `@Dummyable` or `#Dummy` macro.

## Contributing

Contributions are welcome! Please follow the guidelines in the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## License

Dummyable is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Credits

This project is maintained by [Nayanda Haberty](hainayanda@outlook.com).
