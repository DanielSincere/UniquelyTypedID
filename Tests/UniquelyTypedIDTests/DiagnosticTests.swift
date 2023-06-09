import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import UniquelyTypedIDMacros

final class DiagnosticTests: XCTestCase {
  
  let testMacros: [String: Macro.Type] = [
    "UniquelyTypedID": UniquelyTypedIDMacro.self,
  ]
  
  func testUnsupportedType() {
    assertMacroExpansion(
      """
      class MyRecord: Identifiable {
        @UniquelyTypedID(URL.self)
        let id: MyID
      }
      """,
      expandedSource:
      """
      class MyRecord: Identifiable {
        let id: MyID
      }
      """,
      diagnostics: [DiagnosticSpec(message: "'@UniquelyTypedID' supports only `String`, `Int`, `UUID`. The type `URL` is not yet supported.", line: 2, column: 3)],
      macros: testMacros)
  }

  func testAnnotationOnType() {
    assertMacroExpansion(
      """
      @UniquelyTypedID
      class MyRecord: Identifiable {
        let id: MyID
      }
      """,
      expandedSource:
      """

      class MyRecord: Identifiable {
        let id: MyID
      }
      """,
      diagnostics: [DiagnosticSpec(message: "'@UniquelyTypedID' annotates variable declarations on a `struct` or `class`, like `@UniquelyTypedID let id: ID`", line: 1, column: 1)],
      macros: testMacros)
  }
}
