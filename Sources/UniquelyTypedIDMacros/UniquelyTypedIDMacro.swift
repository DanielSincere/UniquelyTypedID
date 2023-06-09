import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics
import IdentifiedEnumCases

/// Implementation of the `@UniquelyTypedID` macro,
public struct UniquelyTypedIDMacro: PeerMacro {
  public enum SupportedTypes: String, CaseIterable {
    case string = "String", int = "Int", uuid = "UUID"
  }
  public static func expansion<Context, Declaration>(of node: SwiftSyntax.AttributeSyntax,
                                                     providingPeersOf declaration: Declaration,
                                                     in context: Context) throws -> [SwiftSyntax.DeclSyntax] where Context : SwiftSyntaxMacros.MacroExpansionContext, Declaration : SwiftSyntax.DeclSyntaxProtocol {

    guard let declaration = declaration.as(VariableDeclSyntax.self) else {
      context.diagnose(Diagnostic(node: declaration._syntaxNode, message: Diagnostics.expectedVariableSyntax))
      return []
    }

    guard let lastIdentifierName: String = declaration.tokens(viewMode: .fixedUp).compactMap({ tokenSyntax in
      if case let .identifier(name) = tokenSyntax.tokenKind {
        return name
      } else {
        return nil
      }
    }).last else {
      context.diagnose(Diagnostic(node: declaration._syntaxNode, message: Diagnostics.expectedIdentifier))
      return []
    }

//    let idType: SupportedTypes = node.tokens(viewMode: .fixedUp).compactMap({
//      if case let .identifier(type) = $0.tokenKind, let type = SupportedTypes(rawValue: type) {
//        return type
//      } else {
//        return nil
//      }
//    }).first ?? .uuid

    let idTypeString = node.tokens(viewMode: .fixedUp).compactMap({
      if case let .identifier(type) = $0.tokenKind, type != "UniquelyTypedID" {
        return type
      } else {
        return nil
      }
    }).first ?? SupportedTypes.uuid.rawValue

    guard let idType = SupportedTypes(rawValue: idTypeString) else {
      context.diagnose(Diagnostic(node: declaration._syntaxNode, message: Diagnostics.unsupportedType(idTypeString)))
      return []
    }

    switch idType {
    case .string:
      return stringExpansion(named: lastIdentifierName, isPublic: declaration.hasPublicModifier)
    case .uuid:
      return uuidExpansion(named: lastIdentifierName, isPublic: declaration.hasPublicModifier)
    case .int:
      return intExpansion(named: lastIdentifierName, isPublic: declaration.hasPublicModifier)
    }
  }

  @IdentifiedEnumCases
  public enum Diagnostics: DiagnosticMessage {
    case expectedIdentifier
    case expectedVariableSyntax
    case unsupportedType(String)

    public var message: String {
      switch self {
      case .expectedVariableSyntax: "'@UniquelyTypedID' annotates variable declarations on a `struct` or `class`, like `@UniquelyTypedID let id: ID`"
      case .expectedIdentifier: "To name the type of the ID, '@UniquelyTypedID' expects a valid Swift identifier as the last token in this declaration."
      case .unsupportedType(let name): "'@UniquelyTypedID' supports only \(SupportedTypes.allCases.map { "`\($0.rawValue)`" }.joined(separator: ", ")). The type `\(name)` is not yet supported."
      }
    }

    public var diagnosticID: MessageID {
      MessageID(domain: "UniquelyTypedIDMacro", id: self.id.rawValue)
    }

    public var severity: DiagnosticSeverity { .error }
  }
}

private extension VariableDeclSyntax {
  var hasPublicModifier: Bool {
    guard let modifiers = self.modifiers else {
      return false
    }

    return modifiers.children(viewMode: .fixedUp)
      .compactMap { syntax in
        syntax.as(DeclModifierSyntax.self)?
          .children(viewMode: .fixedUp)
          .contains { syntax in
            switch syntax.as(TokenSyntax.self)?.tokenKind {
            case .keyword(.public):
              return true
            default:
              return false
            }
          }
      }
      .contains(true)
  }
}

@main
struct UniquelyTypedIDPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
      UniquelyTypedIDMacro.self,
    ]
}
