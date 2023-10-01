import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import UniquelyTypedIDMacros

final class IntergerTests: XCTestCase {

  let testMacros: [String: Macro.Type] = [
    "UniquelyTypedID": UniquelyTypedIDMacro.self,
  ]

  func testIntergerID() {
    assertMacroExpansion(
      """
      class MyRecord: Codable, Hashable, Identifiable {
        @UniquelyTypedID(Int.self)
        let id: MyID
        let name: String
      }
      """,
      expandedSource: """
      class MyRecord: Codable, Hashable, Identifiable {
        let id: MyID
      
        struct MyID: Codable, Hashable, Identifiable, RawRepresentable, CustomStringConvertible, ExpressibleByIntegerLiteral {
          init(rawValue: Int) {
            self.rawValue = rawValue
          }
          init(_ rawValue: Int) {
            self.rawValue = rawValue
          }
          let rawValue: Int
          var description: String {
            "\\(rawValue)"
          }
          var id: Int {
            rawValue
          }
          init(from decoder: Decoder) throws {
            self.rawValue = try decoder.singleValueContainer().decode(Int.self)
          }
          func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(rawValue)
          }
          typealias IntegerLiteralType = Int
          init(integerLiteral value: Int) {
            self.rawValue = value
          }
        }
        let name: String
      }
      """,
      macros: testMacros
    )
  }

  func testVariableIntegerID() {
    assertMacroExpansion(
      """
      class MyRecord: Codable, Hashable, Identifiable {
        @UniquelyTypedID(Int.self)
        var id: ID
        let name: String
      }
      """,
      expandedSource: """
      class MyRecord: Codable, Hashable, Identifiable {
        var id: ID
      
        struct ID: Codable, Hashable, Identifiable, RawRepresentable, CustomStringConvertible, ExpressibleByIntegerLiteral {
          init(rawValue: Int) {
            self.rawValue = rawValue
          }
          init(_ rawValue: Int) {
            self.rawValue = rawValue
          }
          let rawValue: Int
          var description: String {
            "\\(rawValue)"
          }
          var id: Int {
            rawValue
          }
          init(from decoder: Decoder) throws {
            self.rawValue = try decoder.singleValueContainer().decode(Int.self)
          }
          func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(rawValue)
          }
          typealias IntegerLiteralType = Int
          init(integerLiteral value: Int) {
            self.rawValue = value
          }
        }
        let name: String
      }
      """,
      macros: testMacros
    )
  }

  func testPublicVariableIntegerID() {
    assertMacroExpansion(
      """
      class MyRecord: Codable, Hashable, Identifiable {
        @UniquelyTypedID(Int.self)
        public var id: ID
        let name: String
      }
      """,
      expandedSource: """
      class MyRecord: Codable, Hashable, Identifiable {
        public var id: ID
      
        public struct ID: Codable, Hashable, Identifiable, RawRepresentable, CustomStringConvertible, ExpressibleByIntegerLiteral {
          public init(rawValue: Int) {
            self.rawValue = rawValue
          }
          public init(_ rawValue: Int) {
            self.rawValue = rawValue
          }
          public let rawValue: Int
          public var description: String {
            "\\(rawValue)"
          }
          public var id: Int {
            rawValue
          }
          public init(from decoder: Decoder) throws {
            self.rawValue = try decoder.singleValueContainer().decode(Int.self)
          }
          public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(rawValue)
          }
          public typealias IntegerLiteralType = Int
          public init(integerLiteral value: Int) {
            self.rawValue = value
          }
        }
        let name: String
      }
      """,
      macros: testMacros
    )
  }

  func testPublicOptionalVariableIntID() {
    assertMacroExpansion(
      """
      class MyRecord: Codable, Hashable, Identifiable {
        @UniquelyTypedID(Int.self)
        public var id: ID?
        let name: String
      }
      """,
      expandedSource: """
      class MyRecord: Codable, Hashable, Identifiable {
        public var id: ID?
      
        public struct ID: Codable, Hashable, Identifiable, RawRepresentable, CustomStringConvertible, ExpressibleByIntegerLiteral {
          public init(rawValue: Int) {
            self.rawValue = rawValue
          }
          public init(_ rawValue: Int) {
            self.rawValue = rawValue
          }
          public let rawValue: Int
          public var description: String {
            "\\(rawValue)"
          }
          public var id: Int {
            rawValue
          }
          public init(from decoder: Decoder) throws {
            self.rawValue = try decoder.singleValueContainer().decode(Int.self)
          }
          public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(rawValue)
          }
          public typealias IntegerLiteralType = Int
          public init(integerLiteral value: Int) {
            self.rawValue = value
          }
        }
        let name: String
      }
      """,
      macros: testMacros
    )
  }

  func testPublicConstantIntID() {
    assertMacroExpansion(
      """
      class MyRecord: Codable, Hashable, Identifiable {
        @UniquelyTypedID(Int.self)
        public let id: ID
        let name: String
      }
      """,
      expandedSource: """
      class MyRecord: Codable, Hashable, Identifiable {
        public let id: ID
      
        public struct ID: Codable, Hashable, Identifiable, RawRepresentable, CustomStringConvertible, ExpressibleByIntegerLiteral {
          public init(rawValue: Int) {
            self.rawValue = rawValue
          }
          public init(_ rawValue: Int) {
            self.rawValue = rawValue
          }
          public let rawValue: Int
          public var description: String {
            "\\(rawValue)"
          }
          public var id: Int {
            rawValue
          }
          public init(from decoder: Decoder) throws {
            self.rawValue = try decoder.singleValueContainer().decode(Int.self)
          }
          public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(rawValue)
          }
          public typealias IntegerLiteralType = Int
          public init(integerLiteral value: Int) {
            self.rawValue = value
          }
        }
        let name: String
      }
      """,
      macros: testMacros
    )
  }
}
