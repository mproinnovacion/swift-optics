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
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.body.updating(whole, f)
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
		_ whole: Root,
		_ f: @escaping (Value) -> Value
	) -> Root {
		var result = whole
		result[keyPath: self] = f(result[keyPath: self])
		return result
	}
}

