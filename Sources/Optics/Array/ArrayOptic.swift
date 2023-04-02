import Foundation

/// Get all the elements as an array, update them one by one
public protocol ArrayOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	associatedtype _Body
	
	typealias Body = _Body
		
	func getAll(_ whole: Whole) -> [Part]
	
	func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole
	
	@ArrayOpticBuilder var body: Body { get }
}

extension ArrayOptic where Body == Never {
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

extension ArrayOptic where Body: ArrayOptic, Body.Whole == Whole, Body.Part == Part, Body.NewWhole == NewWhole, Body.NewPart == NewPart {
	
	@inlinable
	public func getAll(_ whole: Whole) -> [Part] {
		self.body.getAll(whole)
	}
	
	@inlinable
	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.body.updateAll(whole, f)
	}
}

public typealias SimpleArrayOptic<Whole, Part> = ArrayOptic<Whole, Part, Whole, Part>

extension ArrayOptic {
	@inlinable
	public func updateAll(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Void
	where NewWhole == Whole, NewPart == Part {
		whole = self.updateAll(whole) { part in
			var copy = part
			f(&copy)
			return copy
		}
	}
}

extension ArrayOptic where NewPart == Part, NewWhole == Whole {
	@inlinable
	public func setAll(_ whole: inout Whole, to part: Part) -> Void {
		self.updateAll(&whole) { value in
			value = part
		}
	}
	
	@inlinable
	public func updatingAll(_ whole: Whole, _ f: @escaping (inout Part) -> Void) -> Whole {
		self.updateAll(whole) { part in
			var copy = part
			f(&copy)
			return copy
		}
	}

	@inlinable
	public func settingAll(_ whole: Whole, to part: Part) -> Whole {
		var copy = whole
		self.setAll(&copy, to: part)
		return copy
	}
}

public struct ArrayDefaultOptic<Element, NewElement>: ArrayOptic {
	public typealias Whole = Array<Element>
	public typealias NewWhole = Array<NewElement>
	public typealias Part = Element
	public typealias NewPart = NewElement

	@inlinable
	public func getAll(_ whole: Whole) -> [Part] {
		whole
	}

	@inlinable
	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		whole.map(f)
	}
}

public struct SetDefaultOptic<Element: Hashable, NewElement: Hashable>: ArrayOptic {
	public typealias Whole = Set<Element>
	public typealias NewWhole = Set<NewElement>
	public typealias Part = Element
	public typealias NewPart = NewElement

	@inlinable
	public func getAll(_ whole: Whole) -> [Part] {
		Array(whole)
	}

	@inlinable
	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		Set(whole.map(f))
	}
}

public struct DictionaryValuesOptic<Key: Hashable, Value, NewValue>: ArrayOptic {
	public typealias Whole = Dictionary<Key, Value>
	public typealias NewWhole = Dictionary<Key, NewValue>
	public typealias Part = Value
	public typealias NewPart = NewValue

	@inlinable
	public func getAll(_ whole: Whole) -> [Part] {
		Array(whole.values)
	}

	@inlinable
	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		whole.mapValues(f)
	}
}

public struct ArrayLensLiftOptic<O: LensOptic>: ArrayOptic {
	let lens: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public func getAll(_ whole: Whole) -> [Part] {
		[lens.get(whole)]
	}
	
	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.update(whole, f)
	}
}

public struct ArrayOptionalLiftOptic<O: OptionalOptic>: ArrayOptic {
	let optic: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public func getAll(_ whole: Whole) -> [Part] {
		[optic.tryGet(whole)].compactMap { $0 }
	}
	
	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdate(whole, f)
	}
}
