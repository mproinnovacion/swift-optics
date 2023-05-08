import Foundation

extension ThrowingArrayGetterOptic {
	public func onGet(_ f: @escaping () -> Void) -> OnGetThrowingArrayGetter<Self> {
		.init(optic: self, onGet: f)
	}
}

public struct OnGetThrowingArrayGetter<O: ThrowingArrayGetterOptic>: ThrowingArrayGetterOptic {
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

	public func getAll(_ whole: O.Whole) throws -> [O.Part] {
		self.onGet()
		return try self.optic.getAll(whole)
	}
}

