import Foundation

import Algebra

/// Get all the elements as an array, update them one by one
public protocol ReduceOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
	associatedtype _Body
	
	typealias Body = _Body
	
	func reduced<Result>(
		_ whole: Whole,
		_ monoid: Monoid<Result>,
		foldMap: (Part) -> Result
	) -> Result
	
	@ReduceOpticBuilder var body: Body { get }
}

extension ReduceOptic {
	public func getAll(
		_ whole: Whole
	) -> [Part] {
		self.reduced(whole, [Part].monoid) { [$0] }
	}
}

extension ReduceOptic where Body == Never {
	/// A non-existent body.
	///
	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
	@_transparent
	public var body: Body {
		fatalError(
  """
  '\(Self.self)' has no body. …
  Do not access an ArrayOptic's 'body' property directly, as it may not exist.
  """
		)
	}
}

extension ReduceOptic where Body: ReduceOptic, Body.Whole == Whole, Body.Part == Part {
	@inlinable
	public func reduced<Result>(
		_ whole: Whole,
		_ monoid: Monoid<Result>,
		foldMap: @escaping (Part) -> Result
	) -> Result {
		self.body.reduced(whole, monoid, foldMap: foldMap)
	}
}

public struct ReduceLiftLensOptic<O: LensOptic>: ReduceOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let lens: O
	
	public init(lens: O) {
		self.lens = lens
	}
	
	public func reduced<Result>(
		_ whole: Whole,
		_ monoid: Monoid<Result>,
		foldMap: (Part) -> Result
	) -> Result {
		foldMap(lens.get(whole))
	}
}

public struct ReduceLiftOptionalOptic<O: OptionalOptic>: ReduceOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func reduced<Result>(
		_ whole: Whole,
		_ monoid: Monoid<Result>,
		foldMap: (Part) -> Result
	) -> Result {
		optic.tryGet(whole).map(foldMap) ?? monoid.empty
	}
}

public struct ReduceLiftPrismOptic<O: PrismOptic>: ReduceOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func reduced<Result>(
		_ whole: Whole,
		_ monoid: Monoid<Result>,
		foldMap: (Part) -> Result
	) -> Result {
		optic.extract(from: whole).map(foldMap) ?? monoid.empty
	}
}

public struct ReduceLiftArrayOptic<O: ArrayOptic>: ReduceOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func reduced<Result>(
		_ whole: Whole,
		_ monoid: Monoid<Result>,
		foldMap: (Part) -> Result
	) -> Result {
		optic.getAll(whole).foldMap(foldMap, monoid)
	}
}
