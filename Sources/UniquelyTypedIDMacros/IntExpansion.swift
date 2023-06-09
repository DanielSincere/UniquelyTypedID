import SwiftSyntax

func intExpansion(named name: String, isPublic: Bool) -> [DeclSyntax] {
  let modifier = isPublic ? "public ": ""
  return [
    DeclSyntax(stringLiteral: """
    \(modifier)struct \(name): Codable, Hashable, Identifiable, RawRepresentable, CustomStringConvertible, ExpressibleByIntegerLiteral {
      \(modifier)init(rawValue: Int) {
        self.rawValue = rawValue
      }
      \(modifier)init(_ rawValue: Int) {
        self.rawValue = rawValue
      }
      \(modifier)let rawValue: Int
      \(modifier)var description: String {
        "\\(rawValue)"
      }
      \(modifier)var id: Int {
        rawValue
      }
      \(modifier)init(from decoder: Decoder) throws {
        self.rawValue = try decoder.singleValueContainer().decode(Int.self)
      }
      \(modifier)func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
      }
      \(modifier)typealias IntegerLiteralType = Int
      \(modifier)init(integerLiteral value: Int) {
        self.rawValue = value
      }
    }
    """)
    ]
}
