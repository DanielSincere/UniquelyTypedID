import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import UniquelyTypedIDMacros
import Foundation

final class UUIDTests: XCTestCase {
  let testMacros: [String: Macro.Type] = [
    "UniquelyTypedID": UniquelyTypedIDMacro.self,
  ]

  func testConstantUUID() {
    assertMacroExpansion(
      """
      class MyRecord: Codable, Hashable, Identifiable {
        @UniquelyTypedID(UUID.self)
        let id: ID
        let name: String
      }
      """,
      expandedSource: """
      class MyRecord: Codable, Hashable, Identifiable {
        let id: ID
      
        struct ID: Codable, Hashable, Identifiable, CustomStringConvertible {
          let rawValue: UUID
          init?(_ uuidString: String) {
            guard let uuid = UUID(uuidString: uuidString) else {
              return nil
            }
            self.rawValue = uuid
          }
          init(_ rawValue: UUID = UUID()) {
            self.rawValue = rawValue
          }
          var description: String {
            rawValue.uuidString
          }
          var id: UUID {
            rawValue
          }
          func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(self.id)
          }
          init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self.init(try container.decode(UUID.self))
          }
        }
        let name: String
      }
      """,
      macros: testMacros
    )
  }

  func testPublicVariableUUID() {
    assertMacroExpansion(
      """
      class MyRecord: Codable, Hashable, Identifiable {
        @UniquelyTypedID(UUID.self)
        public var id: ID
        let name: String
      }
      """,
      expandedSource: """
      class MyRecord: Codable, Hashable, Identifiable {
        public var id: ID
      
        public struct ID: Codable, Hashable, Identifiable, CustomStringConvertible {
          public let rawValue: UUID
          public init?(_ uuidString: String) {
            guard let uuid = UUID(uuidString: uuidString) else {
              return nil
            }
            self.rawValue = uuid
          }
          public init(_ rawValue: UUID = UUID()) {
            self.rawValue = rawValue
          }
          public var description: String {
            rawValue.uuidString
          }
          public var id: UUID {
            rawValue
          }
          public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(self.id)
          }
          public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self.init(try container.decode(UUID.self))
          }
        }
        let name: String
      }
      """,
      macros: testMacros
    )
  }

  func testPublicOptionalUUID() {
    assertMacroExpansion(
      """
      class MyRecord: Codable, Hashable, Identifiable {
        @UniquelyTypedID(String.self)
        public var id: UUID?
        let name: String
      }
      """,
      expandedSource: """
      class MyRecord: Codable, Hashable, Identifiable {
        public var id: UUID?
      
        public struct UUID: Codable, Hashable, Identifiable, RawRepresentable, CustomStringConvertible, ExpressibleByStringLiteral {
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


  func testDefaultsToUUID() {
    assertMacroExpansion(
      """
      class MyRecord: Codable, Hashable, Identifiable {
        @UniquelyTypedID
        public let id: ID
        let name: String
      }
      """,
      expandedSource: """
      class MyRecord: Codable, Hashable, Identifiable {
        public let id: ID
      
        public struct ID: Codable, Hashable, Identifiable, CustomStringConvertible {
          public let rawValue: UUID
          public init?(_ uuidString: String) {
            guard let uuid = UUID(uuidString: uuidString) else {
              return nil
            }
            self.rawValue = uuid
          }
          public init(_ rawValue: UUID = UUID()) {
            self.rawValue = rawValue
          }
          public var description: String {
            rawValue.uuidString
          }
          public var id: UUID {
            rawValue
          }
          public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(self.id)
          }
          public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self.init(try container.decode(UUID.self))
          }
        }
        let name: String
      }
      """,
      macros: testMacros
    )
  }
}
