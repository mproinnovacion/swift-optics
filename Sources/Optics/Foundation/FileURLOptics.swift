import Foundation

extension URL {
	public static func fileOptic() -> some SimpleOptionalOptic<URL, Data> {
		OptionalRawOptic { url in
			try? Data(contentsOf: url, options: [])
		} tryUpdate: { url, update in
			let data = try? Data(contentsOf: url, options: [])
			
			try? data.map(update)?.write(to: url)
			
			return url
		} trySet: { url, newData in
			try? newData.write(to: url)
			return url
		}
	}
}
