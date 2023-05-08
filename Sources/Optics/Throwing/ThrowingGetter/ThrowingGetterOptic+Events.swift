import Foundation

extension ThrowingGetterOptic {
	public func onGet(_ f: @escaping () -> Void) -> OnGetThrowingGetter<Self> {
		.init(optic: self, onGet: f)
	}
}

public struct OnGetThrowingGetter<O: ThrowingGetterOptic>: ThrowingGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	public let onGet: () -> Void
	
	public init(
		optic: O,
		onGet: @escaping () -> Void
	) {
		self.optic = optic
		self.onGet = onGet
	}

	public func get(_ whole: O.Whole) throws -> O.Part {
		self.onGet()
		return try self.optic.get(whole)
	}
}

