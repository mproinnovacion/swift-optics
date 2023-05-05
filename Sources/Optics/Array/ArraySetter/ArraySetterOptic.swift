import Foundation

public protocol ArraySetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole
}

extension ArraySetterOptic {
	@inlinable
	public func updateAll(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Void
	where NewWhole == Whole, NewPart == Part {
		whole = self.updatingAll(whole) { part in
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
		_ whole: inout Whole,
		to newValue: NewPart
	) where NewWhole == Whole, NewPart == Part {
		updateAll(&whole) { part in
			part = newValue
		}
	}
	
	@inlinable
	public func settingAll(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		self.updatingAll(whole, { _ in newValue })
	}
	
	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (inout Part) -> Void
	) -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		self.updateAll(&copy, f)
		return copy
	}
}

public struct ArraySetterRawOptic<Whole, Part, NewWhole, NewPart>: ArraySetterOptic {
	public let _updatingAll: (Whole, @escaping (Part) -> NewPart) -> NewWhole
	
	public init(
		updatingAll: @escaping (Whole, @escaping (Part) -> NewPart) -> NewWhole
	) {
		self._updatingAll = updatingAll
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
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
		_ void: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updatingAll(self.whole, f)
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
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.updatingAll((), f)
	}
	
	public func settingAll(
		to newPart: NewPart
	) -> NewWhole {
		self.settingAll((), to: newPart)
	}
}
