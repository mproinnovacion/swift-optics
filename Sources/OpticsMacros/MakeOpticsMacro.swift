import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct MakeOpticsMacro: MemberMacro {
	public static func expansion<Declaration, Context>(
		of node: AttributeSyntax,
		providingMembersOf declaration: Declaration,
		in context: Context
	) throws -> [DeclSyntax]
	where Declaration: DeclGroupSyntax, Context: MacroExpansionContext {
		guard let structDeclaration = declaration.as(StructDeclSyntax.self) else {
			// TODO: Emit error
			return []
		}
		
		let members = structDeclaration.memberBlock.members
		let varDecls = members.compactMap { $0.decl.as(VariableDeclSyntax.self) }
		let elements = varDecls.flatMap { $0.bindings }
		
//		let arguments = elements.map {
//			let type = $0.typeAnnotation!.type //.as(SimpleTypeIdentifierSyntax.self)
//			return "\($0.pattern): \(type)"
//		}.joined(separator: ",\n")
		
//		let names = elements.map { $0.pattern }
		
//		for element in elements {
//			DeclSyntax("""
//			public func "\(element.pattern)Optic() -> {"
//			""")
//		}
		
//		let initializer = try InitializerDeclSyntax("public init(\n\(raw: arguments)\n)") {
//			for name in names {
//				ExprSyntax("self.\(name) = \(name)")
//			}
//		}
		
		return [
//			DeclSyntax(initializer)
		]
	}
}

@main
struct OpticsPlugin: CompilerPlugin {
	 let providingMacros: [Macro.Type] = [
		  MakeOpticsMacro.self,
	 ]
}
