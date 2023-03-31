import Foundation
import CasePaths

public protocol PrismOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
	associatedtype _Body

	typealias Body = _Body

	func extract(from whole: Whole) -> Part?
	
	func embed(_ part: Part) -> Whole

	@PrismBuilder
	var body: Body { get }
}

extension PrismOptic where Body == Never {
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

extension PrismOptic where Body: PrismOptic, Body.Whole == Whole, Body.Part == Part {
	public func extract(from whole: Whole) -> Part? {
		self.body.extract(from: whole)
	}
	
	public func embed(
		_ part: Part
	) -> Whole {
		self.body.embed(part)
	}
}

extension PrismOptic {
	func tryUpdate(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) -> Void
	) {
		guard var part = extract(from: whole) else {
			return
		}
		
		f(&part)
		
		whole = embed(part)
	}
	
	func trySet(
		_ whole: inout Whole,
		to newValue: Part
	) {
		self.tryUpdate(&whole) { part in
			part = newValue
		}
	}
}

extension CasePath: PrismOptic {}

public struct PrismOptionalOptic<Wrapped>: PrismOptic {
	public typealias Whole = Optional<Wrapped>
	public typealias Part = Wrapped

	public func embed(_ part: Wrapped) -> Optional<Wrapped> {
		.some(part)
	}
	
	public func extract(from whole: Optional<Wrapped>) -> Wrapped? {
		whole
	}
}
