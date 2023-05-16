import Foundation

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
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
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
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
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
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		whole.mapValues(f)
	}
}
