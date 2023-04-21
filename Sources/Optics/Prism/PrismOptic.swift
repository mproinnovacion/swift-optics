import Foundation
import CasePaths

public protocol PrismOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
	associatedtype _Body

	typealias Body = _Body

	func extract(from whole: Whole) -> Part?
	
	func embed(_ part: Part) -> Whole

	@PrismOpticBuilder
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
	@inlinable
	public func extract(from whole: Whole) -> Part? {
		self.body.extract(from: whole)
	}
	
	@inlinable
	public func embed(
		_ part: Part
	) -> Whole {
		self.body.embed(part)
	}
}

extension PrismOptic {
	@inlinable
	public func tryUpdate(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) throws -> Void
	) rethrows {
		whole = try tryUpdating(whole, { part in
			var copy = part
			try f(&copy)
			return copy
		})
	}
	
	@inlinable
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> Part
	) rethrows -> Whole {
		guard let part = extract(from: whole) else {
			return whole
		}
		
		return embed(try f(part))
	}
	
	@inlinable
	public func trySet(
		_ whole: inout Whole,
		to newValue: Part
	) {
		self.tryUpdate(&whole) { part in
			part = newValue
		}
	}
}

extension CasePath: PrismOptic {}

public struct PrismRawOptic<Whole, Part>: PrismOptic {
	var _extract: (Whole) -> Part?
	var _embed: (Part) -> Whole
	
	public init(
		extract: @escaping (Whole) -> Part?,
		embed: @escaping (Part) -> Whole
	) {
		self._extract = extract
		self._embed = embed
	}
	
	public func extract(from whole: Whole) -> Part? {
		_extract(whole)
	}
	
	public func embed(_ part: Part) -> Whole {
		_embed(part)
	}
}

public struct PrismOptionalOptic<Wrapped>: PrismOptic {
	public typealias Whole = Optional<Wrapped>
	public typealias Part = Wrapped

	@inlinable
	public func embed(_ part: Wrapped) -> Optional<Wrapped> {
		.some(part)
	}
	
	@inlinable
	public func extract(from whole: Optional<Wrapped>) -> Wrapped? {
		whole
	}
}

public struct OptionalOpticFromPrismOptional<Whole, Part, O: PrismOptic>: OptionalOptic
where Whole == O.Whole, Part == O.Part {
	let optic: O?
	
	public typealias NewWhole = Whole
	public typealias NewPart = Part
	
	public init(optic: O?) {
		self.optic = optic
	}
	
	public func tryGet(
		_ whole: Whole
	) -> Part? {
		self.optic?.extract(from: whole)
	}
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		guard let part = self.optic?.extract(from: whole) else {
			return whole
		}
		
		let newPart = try f(part)
		
		return self.optic?.embed(newPart) ?? whole
	}
	
	public func trySetting(
		_ whole: Whole,
		to newPart: NewPart
	) -> NewWhole {
		self.optic?.embed(newPart) ?? whole
	}
}
