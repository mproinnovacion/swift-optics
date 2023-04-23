//import Foundation
//
//import Algebra
//
///// Get all the elements as an array, update them one by one
//public protocol FoldOptic<Whole, Part> {
//	associatedtype Whole
//	associatedtype Part
//	associatedtype _Body
//	
//	typealias Body = _Body
//	
//	func reduced(
//		_ whole: Whole
//	) -> Part
//	
//	@FoldOpticBuilder<Whole, Part> var body: Body { get }
//}
//
//extension FoldOptic where Body == Never {
//	/// A non-existent body.
//	///
//	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
//	@_transparent
//	public var body: Body {
//		fatalError(
//  """
//  '\(Self.self)' has no body. …
//  Do not access an ArrayOptic's 'body' property directly, as it may not exist.
//  """
//		)
//	}
//}
//
//extension FoldOptic where Body: FoldOptic, Body.Whole == Whole, Body.Part == Part {
//	@inlinable
//	public func reduced(
//		_ whole: Whole
//	) -> Part {
//		self.body.reduced(whole)
//	}
//}
//
//public struct FoldLiftGetterOptic<O: GetterOptic>: FoldOptic {
//	public typealias Whole = O.Whole
//	public typealias Part = O.Part
//	
//	public let optic: O
//	
//	public init(optic: O) {
//		self.optic = optic
//	}
//	
//	public func reduced(
//		_ whole: Whole
//	) -> Part {
//		optic.get(whole)
//	}
//}
//
////public struct FoldLiftOptionalOptic<O: OptionalOptic>: FoldOptic {
////	public typealias Whole = O.Whole
////	public typealias Part = O.Part
////
////	public let optic: O
////
////	public init(optic: O) {
////		self.optic = optic
////	}
////
////	public func reduced(
////		_ whole: Whole
////	) -> Part {
////		optic.tryGet(whole)
////	}
////}
//
////public struct FoldLiftPrismOptic<O: PrismOptic>: FoldOptic {
////	public typealias Whole = O.Whole
////	public typealias Part = O.Part
////
////	public let optic: O
////
////	public init(optic: O) {
////		self.optic = optic
////	}
////
////	public func reduced<Result>(
////		_ whole: Whole,
////		_ monoid: Monoid<Result>,
////		foldMap: (Part) -> Result
////	) -> Result {
////		optic.extract(from: whole).map(foldMap) ?? monoid.empty
////	}
////}
//
////public struct FoldLiftArrayOptic<O: ArrayOptic>: FoldOptic {
////	public typealias Whole = O.Whole
////	public typealias Part = O.Part
////	
////	public let optic: O
////	
////	public init(optic: O) {
////		self.optic = optic
////	}
////	
////	public func reduced(
////		_ whole: Whole
////	) -> Part {
////		optic.getAll(whole)
////	}
////}
