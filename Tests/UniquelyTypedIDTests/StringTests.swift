import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import UniquelyTypedIDMacros
import Foundation

final class StringTests: XCTestCase {
  let testMacros: [String: Macro.Type] = [
    "UniquelyTypedID": UniquelyTypedIDMacro.self,
  ]

  func testStringID() {
    assertMacroExpansion(
      """
      class MyRecord: Codable, Hashable, Identifiable {
        @UniquelyTypedID(String.self)
        let id: ID
        let name: String
      }
      """,
      expandedSource: """
      class MyRecord: Codable, Hashable, Identifiable {
        let id: ID
        struct ID: Codable, Hashable, Identifiable, RawRepresentable, CustomStringConvertible, ExpressibleByStringLiteral {
          init(rawValue: String) {
            self.rawValue = rawValue
          }
          init(_ rawValue: String) {
            self.rawValue = rawValue
          }
          let rawValue: String
          var description: String {
            rawValue
          }
          var id: String {
            rawValue
          }
          init(from decoder: Decoder) throws {
            self.rawValue = try decoder.singleValueContainer().decode(String.self)
          }
          func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(rawValue)
          }
          typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
          typealias UnicodeScalarLiteralType = StringLiteralType
          init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
              self.rawValue = String(value)
          }
          init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
              self.rawValue = String(value)
          }
          init(stringLiteral value: StringLiteralType) {
              self.rawValue = String(value)
          }
        }
        let name: String
      }
      """,
      macros: testMacros
    )
  }

  func testPublicVariableStringID() {
    assertMacroExpansion(
      """
      class MyRecord: Codable, Hashable, Identifiable {
        @UniquelyTypedID(String.self)
        public var id: ID
        let name: String
      }
      """,
      expandedSource: """
      class MyRecord: Codable, Hashable, Identifiable {
        public var id: ID
        public struct ID: Codable, Hashable, Identifiable, RawRepresentable, CustomStringConvertible, ExpressibleByStringLiteral {
          public init(rawValue: String) {
            self.rawValue = rawValue
          }
          public init(_ rawValue: String) {
            self.rawValue = rawValue
          }
          public let rawValue: String
          public var description: String {
            rawValue
          }
          public var id: String {
            rawValue
          }
          public init(from decoder: Decoder) throws {
            self.rawValue = try decoder.singleValueContainer().decode(String.self)
          }
          public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(rawValue)
          }
          public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
          public typealias UnicodeScalarLiteralType = StringLiteralType
          public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
              self.rawValue = String(value)
          }
          public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
              self.rawValue = String(value)
          }
          public init(stringLiteral value: StringLiteralType) {
              self.rawValue = String(value)
          }
        }
        let name: String
      }
      """,
      macros: testMacros
    )
  }

  func testPublicOptionalStringID() {
    assertMacroExpansion(
      """
      class MyRecord: Codable, Hashable, Identifiable {
        @UniquelyTypedID(String.self)
        public var id: ID?
        let name: String
      }
      """,
      expandedSource: """
      class MyRecord: Codable, Hashable, Identifiable {
        public var id: ID?
        public struct ID: Codable, Hashable, Identifiable, RawRepresentable, CustomStringConvertible, ExpressibleByStringLiteral {
          public init(rawValue: String) {
            self.rawValue = rawValue
          }
          public init(_ rawValue: String) {
            self.rawValue = rawValue
          }
          public let rawValue: String
          public var description: String {
            rawValue
          }
          public var id: String {
            rawValue
          }
          public init(from decoder: Decoder) throws {
            self.rawValue = try decoder.singleValueContainer().decode(String.self)
          }
          public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(rawValue)
          }
          public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
          public typealias UnicodeScalarLiteralType = StringLiteralType
          public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
              self.rawValue = String(value)
          }
          public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
              self.rawValue = String(value)
          }
          public init(stringLiteral value: StringLiteralType) {
              self.rawValue = String(value)
          }
        }
        let name: String
      }
      """,
      macros: testMacros
    )
  }

  func testPublicConstantStringID() {
    assertMacroExpansion(
      """
      class MyRecord: Codable, Hashable, Identifiable {
        @UniquelyTypedID(String.self)
        public let id: ID
        let name: String
      }
      """,
      expandedSource: """
      class MyRecord: Codable, Hashable, Identifiable {
        public let id: ID
        public struct ID: Codable, Hashable, Identifiable, RawRepresentable, CustomStringConvertible, ExpressibleByStringLiteral {
          public init(rawValue: String) {
            self.rawValue = rawValue
          }
          public init(_ rawValue: String) {
            self.rawValue = rawValue
          }
          public let rawValue: String
          public var description: String {
            rawValue
          }
          public var id: String {
            rawValue
          }
          public init(from decoder: Decoder) throws {
            self.rawValue = try decoder.singleValueContainer().decode(String.self)
          }
          public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(rawValue)
          }
          public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
          public typealias UnicodeScalarLiteralType = StringLiteralType
          public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
              self.rawValue = String(value)
          }
          public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
              self.rawValue = String(value)
          }
          public init(stringLiteral value: StringLiteralType) {
              self.rawValue = String(value)
          }
        }
        let name: String
      }
      """,
      macros: testMacros
    )
  }
}
