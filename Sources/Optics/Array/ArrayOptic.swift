import Foundation

import Algebra

/// Get all the elements as an array, update them one by one
public protocol ArrayOptic<Whole, Part, NewWhole, NewPart>: ArrayGetterOptic, ArraySetterOptic {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	associatedtype _ArrayBody
	
	typealias ArrayBody = _ArrayBody
	
	@ArrayOpticBuilder var body: ArrayBody { get }
}

extension ArrayOptic where ArrayBody == Never {
	/// A non-existent body.
	///
	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
	@_transparent
	public var body: ArrayBody {
		fatalError(
  """
  '\(Self.self)' has no body. …
  Do not access an ArrayOptic's 'body' property directly, as it may not exist.
  """
		)
	}
}

extension ArrayOptic where ArrayBody: ArrayOptic, ArrayBody.Whole == Whole, ArrayBody.Part == Part, ArrayBody.NewWhole == NewWhole, ArrayBody.NewPart == NewPart {
	
	@inlinable
	public func getAll(_ whole: Whole) -> [Part] {
		self.body.getAll(whole)
	}
	
	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.body.updatingAll(whole, f)
	}
}

public typealias SimpleArrayOptic<Whole, Part> = ArrayOptic<Whole, Part, Whole, Part>

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
	public func updatingAll(
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
	public func updatingAll(
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
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		whole.mapValues(f)
	}
}

public struct ArrayOpticFromOptional<Whole, Part, NewPart, O: ArrayOptic>: ArrayOptic
where O.NewWhole == O.Whole, Whole == O.Whole, Part == O.Part, NewPart == O.NewPart {
	public typealias NewWhole = O.NewWhole
	
	public let optic: O?
	
	public init(optic: O?) {
		self.optic = optic
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optic?.getAll(whole) ?? []
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		guard let optic = self.optic else {
			return whole
		}
		
		return optic.updatingAll(whole, f)
	}
}
