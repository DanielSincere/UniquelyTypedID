import Foundation

@attached(peer, names: arbitrary)
public macro UniquelyTypedID<T>(_ rawValueType: T.Type = UUID.self) = #externalMacro(module: "UniquelyTypedIDMacros", type: "UniquelyTypedIDMacro")
