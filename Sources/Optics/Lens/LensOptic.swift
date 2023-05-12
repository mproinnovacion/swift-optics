import Foundation

public protocol LensOptic<Whole, Part, NewWhole, NewPart>: GetterOptic, SetterOptic {
	associatedtype _LensBody
	
	typealias LensBody = _LensBody

	@LensOpticBuilder
	var body: LensBody { get }
}

extension LensOptic where LensBody == Never {
	/// A non-existent body.
	///
	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
	@_transparent
	public var body: LensBody {
		fatalError(
  """
  '\(Self.self)' has no body. …
  Do not access a LensOptic's 'body' property directly, as it may not exist.
  """
		)
	}
}

extension LensOptic where LensBody: LensOptic, LensBody.Whole == Whole, LensBody.Part == Part, LensBody.NewWhole == NewWhole, LensBody.NewPart == NewPart {
	
	@inlinable
	public func get(_ whole: Whole) -> Part {
		self.body.get(whole)
	}
	@inlinable
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.body.updating(in: whole, update: f)
	}
}

public typealias SimpleLensOptic<Whole, Part> = LensOptic<Whole, Part, Whole, Part>

extension LensOptic {
	@inlinable
	public func each<Element, NewElement>() -> Each<Self, Element, NewElement>
	where Part == [Element], NewPart == [NewElement] {
		Each {
			self
		}
	}
}

extension WritableKeyPath: LensOptic {
	public typealias NewWhole = Root
	public typealias NewPart = Value
	
	@inlinable
	public func updating(
		in whole: Root,
		update f: @escaping (Value) -> Value
	) -> Root {
		var result = whole
		result[keyPath: self] = f(result[keyPath: self])
		return result
	}
}

public struct LensProvidedWholeOptic<O: LensOptic>: LensOptic {
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
	
	public func get(_ whole: Void) -> O.Part {
		self.optic.get(self.whole)
	}
	
	public func updating(
		in void: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updating(in: self.whole, update: f)
	}
}

extension LensOptic {
	public func provide(
		_ whole: Whole
	) -> LensProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension LensOptic where Whole == Void {
	public func get() -> Part {
		self.get(())
	}
	
	public func updating(
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.updating(in: (), update: f)
	}
	
	public func setting(
		to newValue: NewPart
	) -> NewWhole {
		self.setting(in: (), to: newValue)
	}
}
