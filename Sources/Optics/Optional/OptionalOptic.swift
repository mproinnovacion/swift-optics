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
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.body.tryUpdating(in: whole, update: f)
	}
	
	@inlinable
	public func trySetting(
		in whole: Whole,
		to newPart: NewPart
	) -> NewWhole {
		self.body.trySetting(in: whole, to: newPart)
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
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		_tryUpdating(whole, f)
	}
	
	@inlinable
	public func trySetting(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		_trySetting(whole, newValue)
	}
}

extension OptionalOptic where NewWhole == Whole, NewPart == Part {
	public static func none() -> OptionalRawOptic<Whole, Part, NewWhole, NewPart> {
		.init(
			tryGet: { _ in nil }
		) { whole, _ in
			whole
		} trySetting: { whole, _ in
			whole
		}
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
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
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
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		tryUpdating(in: whole) { _ in
			newValue
		}
	}
}

public struct OptionalProvidedWholeOptic<O: OptionalOptic>: OptionalOptic {
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
	
	public func tryGet(_ whole: Void) -> O.Part? {
		optic.tryGet(self.whole)
	}
	
	public func tryUpdating(
		in void: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdating(in: self.whole, update: f)
	}
	
	public func trySetting(
		in whole: Void,
		to newPart: O.NewPart
	) -> O.NewWhole {
		optic.trySetting(in: self.whole, to: newPart)
	}
}

extension OptionalOptic {
	public func provide(
		_ whole: Whole
	) -> OptionalProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension OptionalOptic where Whole == Void {
	public func tryGet() -> Part? {
		self.tryGet(())
	}
	
	public func tryUpdating(
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.tryUpdating(in: (), update: f)
	}
	
	public func trySetting(
		to newPart: NewPart
	) -> NewWhole {
		self.trySetting(in: (), to: newPart)
	}
}
