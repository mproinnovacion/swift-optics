import Foundation

public protocol OptionalOptic<Whole, Part, NewWhole, NewPart>: OptionalGetterOptic, OptionalSetterOptic {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	associatedtype _OptionalBody
	
	typealias OptionalBody = _OptionalBody
	
	@OptionalOpticBuilder
	var body: OptionalBody { get }
}

extension OptionalOptic where OptionalBody == Never {
	/// A non-existent body.
	///
	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
	@_transparent
	public var body: OptionalBody {
		fatalError(
  """
  '\(Self.self)' has no body. …
  Do not access an OptionalOptic's 'body' property directly, as it may not exist.
  """
		)
	}
}

extension OptionalOptic where OptionalBody: OptionalOptic, OptionalBody.Whole == Whole, OptionalBody.Part == Part, OptionalBody.NewWhole == NewWhole, OptionalBody.NewPart == NewPart {
	@inlinable
	public func tryGet(_ whole: Whole) -> Part? {
		self.body.tryGet(whole)
	}
	
	@inlinable
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.body.tryUpdating(whole, f)
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
	public let _tryUpdating: (Whole, @escaping (Part) -> NewPart) -> NewWhole
	public let _trySetting: (Whole, NewPart) -> NewWhole
	
	public init(
		tryGet: @escaping (Whole) -> Part?,
		tryUpdating: @escaping (Whole, @escaping (Part) -> NewPart) -> NewWhole,
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
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
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
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		switch whole {
			case let .some(value):
				return .some(f(value))
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

extension PrismOptic {
	public func optional() -> LiftPrismToOptional<Self> {
		.init(prism: self)
	}
}
