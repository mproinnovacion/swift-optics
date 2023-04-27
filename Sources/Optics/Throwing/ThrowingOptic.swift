import Foundation

public enum ThrowingError: Error {
	case noData
}

public protocol ThrowingOptic<Whole, Part, NewWhole, NewPart>: ThrowingGetterOptic, ThrowingSetterOptic {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	associatedtype _Body
	
	typealias Body = _Body
		
	func get(_ whole: Whole) throws -> Part
	
	func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole
	
	func setting(
		_ whole: Whole,
		to: NewPart
	) throws -> NewWhole
	
	@ThrowingOpticBuilder
	var body: Body { get }
}

extension ThrowingOptic where Body == Never {
	/// A non-existent body.
	///
	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
	@_transparent
	public var body: Body {
		fatalError(
  """
  '\(Self.self)' has no body. …
  Do not access a ThrowingOptic's 'body' property directly, as it may not exist.
  """
		)
	}
}

extension ThrowingOptic where Body: ThrowingOptic, Body.Whole == Whole, Body.Part == Part, Body.NewWhole == NewWhole, Body.NewPart == NewPart {
	@inlinable
	public func get(_ whole: Whole) throws -> Part {
		try self.body.get(whole)
	}
	
	@inlinable
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try self.body.updating(whole, f)
	}
	
	@inlinable
	public func setting(
		_ whole: Whole,
		to newPart: NewPart
	) throws -> NewWhole {
		try self.body.setting(whole, to: newPart)
	}
}

public typealias SimpleThrowingOptic<Whole, Part> = ThrowingOptic<Whole, Part, Whole, Part>

extension ThrowingOptic {
	@inlinable
	public func update(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) throws -> Void
	) throws
	where Part == NewPart, Whole == NewWhole {
		whole = try self.updating(whole, { part in
			var copy = part
			try f(&copy)
			return copy
		})
	}
	
	@inlinable
	public func updating(
		_ whole: Whole,
		_ f: @escaping (inout Part) throws -> Void
	) throws -> Whole
	where Part == NewPart, Whole == NewWhole {
		try self.updating(whole) { part in
			var result = part
			try f(&result)
			return result
		}
	}
	
	@inlinable
	public func update(
		_ whole: inout Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws
	where Part == NewPart, Whole == NewWhole {
		try self.update(&whole) { part in
			part = try f(part)
		}
	}
	
	@inlinable
	public func set(
		_ whole: inout Whole,
		to newPart: NewPart
	) throws where Part == NewPart, Whole == NewWhole {
		whole = try self.setting(whole, to: newPart)
	}
	
	@inlinable
	public func setting(
		_ whole: Whole,
		to newValue: NewPart
	) throws -> Whole where Part == NewPart, Whole == NewWhole {
		var copy = whole
		try self.set(&copy, to: newValue)
		return copy
	}
}

public struct ThrowingRawOptic<Whole, Part, NewWhole, NewPart>: ThrowingOptic {
	public let _get: (Whole) throws -> Part
	public let _updating: (Whole, @escaping (Part) throws -> NewPart) throws -> NewWhole
	public let _setting: (Whole, NewPart) throws -> NewWhole
	
	public init(
		get: @escaping (Whole) throws -> Part,
		updating: @escaping (Whole, @escaping (Part) throws -> NewPart) throws -> NewWhole,
		setting: @escaping (Whole, NewPart) throws -> NewWhole
	) {
		self._get = get
		self._updating = updating
		self._setting = setting
	}
	
	@inlinable
	public func get(_ whole: Whole) throws -> Part {
		try _get(whole)
	}

	@inlinable
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try _updating(whole, f)
	}
	
	@inlinable
	public func setting(
		_ whole: Whole,
		to newValue: NewPart
	) throws -> NewWhole {
		try _setting(whole, newValue)
	}
}

extension LensOptic {
	public func throwing() -> LiftLensToThrowing<Self> {
		.init(optic: self)
	}
}

extension PrismOptic {
	public func throwing() -> LiftPrismToThrowing<Self> {
		.init(prism: self)
	}
}

extension OptionalOptic {
	public func throwing() -> LiftOptionalToThrowing<Self> {
		.init(optic: self)
	}
}
