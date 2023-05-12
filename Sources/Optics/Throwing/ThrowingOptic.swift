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
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole
	
	func setting(
		in whole: Whole,
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
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try self.body.updating(in: whole, update: f)
	}
	
	@inlinable
	public func setting(
		in whole: Whole,
		to newPart: NewPart
	) throws -> NewWhole {
		try self.body.setting(in: whole, to: newPart)
	}
}

public typealias SimpleThrowingOptic<Whole, Part> = ThrowingOptic<Whole, Part, Whole, Part>

extension ThrowingOptic {
	@inlinable
	public func update(
		in whole: inout Whole,
		update f: @escaping (inout Part) throws -> Void
	) throws
	where Part == NewPart, Whole == NewWhole {
		whole = try self.updating(in: whole) { part in
			var copy = part
			try f(&copy)
			return copy
		}
	}
	
	@inlinable
	public func updating(
		in whole: Whole,
		update f: @escaping (inout Part) throws -> Void
	) throws -> Whole
	where Part == NewPart, Whole == NewWhole {
		try self.updating(in: whole) { part in
			var result = part
			try f(&result)
			return result
		}
	}
	
	@inlinable
	public func update(
		in whole: inout Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws
	where Part == NewPart, Whole == NewWhole {
		try self.update(in: &whole) { part in
			part = try f(part)
		}
	}
	
	@inlinable
	public func set(
		in whole: inout Whole,
		to newPart: NewPart
	) throws where Part == NewPart, Whole == NewWhole {
		whole = try self.setting(in: whole, to: newPart)
	}
	
	@inlinable
	public func setting(
		in whole: Whole,
		to newValue: NewPart
	) throws -> Whole where Part == NewPart, Whole == NewWhole {
		var copy = whole
		try self.set(in: &copy, to: newValue)
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
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try _updating(whole, f)
	}
	
	@inlinable
	public func setting(
		in whole: Whole,
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
		.init(optic: self)
	}
}

extension OptionalOptic {
	public func throwing() -> LiftOptionalToThrowing<Self> {
		.init(optic: self)
	}
}

public struct ThrowingProvidedWholeOptic<O: ThrowingOptic>: ThrowingOptic {
	public typealias Whole = Void
	public typealias Part = O.Part
	public typealias NewWhole = O.NewWhole
	public typealias NewPart = O.NewPart

	public let optic: O
	public let whole: O.Whole

	public init(
		optic: O,
		whole: O.Whole
	) {
		self.optic = optic
		self.whole = whole
	}

	public func get(_ whole: Void) throws -> O.Part {
		try self.optic.get(self.whole)
	}
	
	public func updating(
		in void: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try optic.updating(in: self.whole, update: f)
	}
}

extension ThrowingOptic {
	public func provide(
		_ whole: Whole
	) -> ThrowingProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension ThrowingOptic where Whole == Void {
	public func get() throws -> Part {
		try self.get(())
	}
	
	public func updating(
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try self.updating(in: (), update: f)
	}

	public func setting(
		to newValue: NewPart
	) throws -> NewWhole {
		try self.setting(in: (), to: newValue)
	}
}
