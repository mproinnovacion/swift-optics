import Foundation

extension URL {
	public static func fileOptic() -> some SimpleThrowingOptic<URL, Data> {
		ThrowingRawOptic { url in
			try Data(contentsOf: url, options: [])
		} update: { url, update in
			let data = try Data(contentsOf: url, options: [])
			
			let updated = try update(data)
			
			try updated.write(to: url)
			
			return url
		} set: { url, newData in
			try newData.write(to: url)
			return url
		}
	}
}
