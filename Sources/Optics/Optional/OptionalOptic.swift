import Foundation

public protocol OptionalOptic<Whole, Part, NewWhole, NewPart>: OptionalGetterOptic, OptionalSetterOptic {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	associatedtype _Body
	
	typealias Body = _Body
		
	func tryGet(_ whole: Whole) -> Part?
	
	func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole
	
	func trySetting(_ whole: Whole, to: NewPart) -> NewWhole
	
	@OptionalOpticBuilder
	var body: Body { get }
}

extension OptionalOptic where Body == Never {
	/// A non-existent body.
	///
	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
	@_transparent
	public var body: Body {
		fatalError(
  """
  '\(Self.self)' has no body. …
  Do not access an OptionalOptic's 'body' property directly, as it may not exist.
  """
		)
	}
}

extension OptionalOptic where Body: OptionalOptic, Body.Whole == Whole, Body.Part == Part, Body.NewWhole == NewWhole, Body.NewPart == NewPart {
	@inlinable
	public func tryGet(_ whole: Whole) -> Part? {
		self.body.tryGet(whole)
	}
	
	@inlinable
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try self.body.tryUpdating(whole, f)
	}
	
	@inlinable
	public func trySetting(
		_ whole: Whole,
		to newPart: NewPart
	) -> NewWhole {
		self.body.trySetting(whole, to: newPart)
	}
}

public typealias SimpleOptionalOptic<Whole, Part> = OptionalOptic<Whole, Part, Whole, Part>

public struct OptionalRawOptic<Whole, Part, NewWhole, NewPart>: OptionalOptic {
	public let _tryGet: (Whole) -> Part?
	public let _tryUpdating: (Whole, @escaping (Part) throws -> NewPart) -> NewWhole
	public let _trySetting: (Whole, NewPart) -> NewWhole
	
	public init(
		tryGet: @escaping (Whole) -> Part?,
		tryUpdating: @escaping (Whole, @escaping (Part) throws -> NewPart) -> NewWhole,
		trySetting: @escaping (Whole, NewPart) -> NewWhole
	) {
		self._tryGet = tryGet
		self._tryUpdating = tryUpdating
		self._trySetting = trySetting
	}
	
	@inlinable
	public func tryGet(_ whole: Whole) -> Part? {
		_tryGet(whole)
	}

	@inlinable
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		_tryUpdating(whole, f)
	}
	
	@inlinable
	public func trySetting(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		_trySetting(whole, newValue)
	}
}

public struct OptionalDefaultOptic<Wrapped, NewWrapped>: OptionalOptic {
	public typealias Whole = Optional<Wrapped>
	public typealias NewWhole = Optional<NewWrapped>
	public typealias Part = Wrapped
	public typealias NewPart = NewWrapped

	@inlinable
	public func tryGet(_ whole: Whole) -> Part? {
		whole
	}

	@inlinable
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		switch whole {
			case let .some(value):
				return .some(try f(value))
			case .none:
				return .none
		}
	}
	
	@inlinable
	public func trySetting(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		tryUpdating(whole) { _ in
			newValue
		}
	}
}

public struct OptionalLiftPrismOptic<P: PrismOptic>: OptionalOptic {
	public typealias Whole = P.Whole
	public typealias NewWhole = Whole
	public typealias Part = P.Part
	public typealias NewPart = Part
	
	public let prism: P
	
	public init(prism: P) {
		self.prism = prism
	}
	
	@inlinable
	public func tryGet(_ whole: Whole) -> Part? {
		prism.extract(from: whole)
	}
	
	@inlinable
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		guard var value = prism.extract(from: whole) else {
			return whole
		}
		
		value = try f(value)
		
		return prism.embed(value)
	}
	
	@inlinable
	public func trySetting(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		prism.embed(newValue)
	}
}

extension PrismOptic {
	public func optional() -> OptionalLiftPrismOptic<Self> {
		.init(prism: self)
	}
}
