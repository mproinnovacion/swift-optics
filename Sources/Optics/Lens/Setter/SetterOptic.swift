import Foundation

public protocol SetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole
}

extension SetterOptic {
	@inlinable
	public func update(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) throws -> Void
	) rethrows -> Void
	where NewWhole == Whole, NewPart == Part {
		whole = try self.updating(whole) { part in
			var copy = part
			try f(&copy)
			return copy
		}
	}
}

public typealias SimpleSetterOptic<Whole, Part> = SetterOptic<Whole, Part, Whole, Part>

extension SetterOptic {
	@inlinable
	public func `set`(
		_ whole: inout Whole,
		to newValue: NewPart
	) where NewWhole == Whole, NewPart == Part {
		update(&whole) { part in
			part = newValue
		}
	}
	
	@inlinable
	public func setting(
		_ whole: Whole,
		to newValue: Part
	) -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		self.set(&copy, to: newValue)
		return copy
	}
	
	@inlinable
	public func updating(
		_ whole: Whole,
		_ f: @escaping (inout Part) throws -> Void
	) rethrows -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		try self.update(&copy, f)
		return copy
	}
}

public struct SetterRawOptic<Whole, Part, NewWhole, NewPart>: SetterOptic {
	public let _updating: (Whole, @escaping (Part) throws -> NewPart) -> NewWhole
	
	public init(
		updating: @escaping (Whole, @escaping (Part) throws -> NewPart) -> NewWhole
	) {
		self._updating = updating
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		_updating(whole, f)
	}
}
