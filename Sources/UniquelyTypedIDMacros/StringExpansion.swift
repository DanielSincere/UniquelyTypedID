import SwiftSyntax

func stringExpansion(named name: String, isPublic: Bool) -> [DeclSyntax] {
  let modifier = isPublic ? "public ": ""
  return [
    DeclSyntax(stringLiteral: """
    \(modifier)struct \(name): Codable, Hashable, Identifiable, RawRepresentable, CustomStringConvertible, ExpressibleByStringLiteral {
      \(modifier)init(rawValue: String) {
        self.rawValue = rawValue
      }
      \(modifier)init(_ rawValue: String) {
        self.rawValue = rawValue
      }
      \(modifier)let rawValue: String
      \(modifier)var description: String {
        rawValue
      }
      \(modifier)var id: String {
        rawValue
      }
      \(modifier)init(from decoder: Decoder) throws {
        self.rawValue = try decoder.singleValueContainer().decode(String.self)
      }
      \(modifier)func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
      }
      \(modifier)typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
      \(modifier)typealias UnicodeScalarLiteralType = StringLiteralType
      \(modifier)init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
          self.rawValue = String(value)
      }
      \(modifier)init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
          self.rawValue = String(value)
      }
      \(modifier)init(stringLiteral value: StringLiteralType) {
          self.rawValue = String(value)
      }
    }
    """)
  ]
}
