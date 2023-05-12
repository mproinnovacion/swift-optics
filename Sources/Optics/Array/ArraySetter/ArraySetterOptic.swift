import Foundation

public protocol ArraySetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole
}

extension ArraySetterOptic {
	@inlinable
	public func updateAll(
		in whole: inout Whole,
		update f: @escaping (inout Part) -> Void
	) -> Void
	where NewWhole == Whole, NewPart == Part {
		whole = self.updatingAll(in: whole) { part in
			var copy = part
			f(&copy)
			return copy
		}
	}
}

public typealias SimpleArraySetterOptic<Whole, Part> = ArraySetterOptic<Whole, Part, Whole, Part>

extension ArraySetterOptic {
	@inlinable
	public func setAll(
		in whole: inout Whole,
		to newValue: NewPart
	) where NewWhole == Whole, NewPart == Part {
		updateAll(in: &whole) { part in
			part = newValue
		}
	}
	
	@inlinable
	public func settingAll(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		self.updatingAll(in: whole) { _ in newValue }
	}
	
	@inlinable
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (inout Part) -> Void
	) -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		self.updateAll(in: &copy, update: f)
		return copy
	}
	
	@inlinable
	public func updater(
		update f: @escaping (Part) -> NewPart
	) -> (Whole) -> NewWhole {
		{ whole in
			self.updatingAll(in: whole, update: f)
		}
	}
}

public struct ArraySetterRawOptic<Whole, Part, NewWhole, NewPart>: ArraySetterOptic {
	public let _updatingAll: (Whole, @escaping (Part) -> NewPart) -> NewWhole
	
	public init(
		updatingAll: @escaping (
			Whole,
			@escaping (Part) -> NewPart
		) -> NewWhole
	) {
		self._updatingAll = updatingAll
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		_updatingAll(whole, f)
	}
}

public struct ArraySetterProvidedWholeOptic<O: ArraySetterOptic>: ArraySetterOptic {
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
	
	public func updatingAll(
		in void: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updatingAll(in: self.whole, update: f)
	}
}

extension ArraySetterOptic {
	public func provide(
		_ whole: Whole
	) -> ArraySetterProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension ArraySetterOptic where Whole == Void {
	public func updatingAll(
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.updatingAll(in: (), update: f)
	}
	
	public func settingAll(
		to newPart: NewPart
	) -> NewWhole {
		self.settingAll(in: (), to: newPart)
	}
}
