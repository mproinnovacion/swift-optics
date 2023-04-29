import Foundation

extension AsyncLensOptic {
	public func map<O0>(
		_ f: @escaping (O0) -> Whole
	) -> (O0) async -> Part {
		{ o0 in
			await self.get(f(o0))
		}
	}
	
	public func map<O0, O1>(
		_ f: @escaping (O0, O1) -> Whole
	) -> (O0, O1) async -> Part {
		{ o0, o1 in
			await self.get(f(o0, o1))
		}
	}
	
	public func map<O0, O1, O2>(
		_ f: @escaping (O0, O1, O2) -> Whole
	) -> (O0, O1, O2) async -> Part {
		{ o0, o1, o2 in
			await self.get(f(o0, o1, o2))
		}
	}
	
	public func map<O0, O1, O2, O3>(
		_ f: @escaping (O0, O1, O2, O3) -> Whole
	) -> (O0, O1, O2, O3) async -> Part {
		{ o0, o1, o2, o3 in
			await self.get(f(o0, o1, o2, o3))
		}
	}
	
	public func map<O0, O1, O2, O3, O4>(
		_ f: @escaping (O0, O1, O2, O3, O4) -> Whole
	) -> (O0, O1, O2, O3, O4) async -> Part {
		{ o0, o1, o2, o3, o4 in
			await self.get(f(o0, o1, o2, o3, o4))
		}
	}
	
	public func map<O0, O1, O2, O3, O4, O5>(
		_ f: @escaping (O0, O1, O2, O3, O4, O5) -> Whole
	) -> (O0, O1, O2, O3, O4, O5) async -> Part {
		{ o0, o1, o2, o3, o4, o5 in
			await self.get(f(o0, o1, o2, o3, o4, o5))
		}
	}
}
