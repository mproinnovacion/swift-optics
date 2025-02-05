import Foundation

public struct Sorted<L: LensOptic, SortPropertyOptic: LensOptic, NewElement>: LensOptic
where L.Part == [SortPropertyOptic.Whole], SortPropertyOptic.Part: Comparable, L.NewPart == [NewElement] {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = L.Part
	public typealias NewPart = L.NewPart
	
	public let reversed: Bool
	public let lens: L
	public let by: SortPropertyOptic
	
	@inlinable
	public init(
		reversed: Bool = false,
		@LensOpticBuilder _ build: () -> L,
		@LensOpticBuilder by: () -> SortPropertyOptic
	) {
		self.reversed = reversed
		self.lens = build()
		self.by = by()
	}
	
	public func get(_ whole: Whole) -> Part {
		lens.get(whole).sorted { left, right in
			let result = self.by.get(left) < self.by.get(right)
			return self.reversed ? !result : result
		}
	}
	
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.updating(in: whole) { (parts: Part) -> NewPart in
			let sortedIndexed = parts.enumerated().sorted {
				self.by.get($0.1) < self.by.get($1.1)
			}
			
			let indices = sortedIndexed.map { index, _ in index }
			let updated = f(sortedIndexed.map { _, item in item })
			
			let updatedOriginalSortingTrimmed = zip(indices, updated)
				.sorted(by: { $0.0 < $1.0 }).map { $0.1 }
			
			let extra = updated.suffix(updated.count - indices.count)
			
			return Array(updatedOriginalSortingTrimmed + extra)
		}
	}
}
