import SwiftSyntax

func uuidExpansion(named name: String, isPublic: Bool) -> [DeclSyntax] {
  let modifier = isPublic ? "public ": ""
  return [
    DeclSyntax(stringLiteral: """
    \(modifier)struct \(name): Codable, Hashable, Identifiable, CustomStringConvertible {
      \(modifier)let rawValue: UUID
      \(modifier)init?(_ uuidString: String) {
        guard let uuid = UUID(uuidString: uuidString) else {
          return nil
        }
        self.rawValue = uuid
      }
      \(modifier)init(_ rawValue: UUID = UUID()) {
        self.rawValue = rawValue
      }
      \(modifier)var description: String {
        rawValue.uuidString
      }
      \(modifier)var id: UUID {
        rawValue
      }
      \(modifier)func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.id)
      }
      \(modifier)init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(try container.decode(UUID.self))
      }
    }
    """)
    ]
}
