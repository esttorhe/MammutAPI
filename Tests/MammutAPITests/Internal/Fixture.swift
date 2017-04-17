/***************************************************************************
** Based off a `Fixture` created by Github user @ornithocoder on 2017.04.15
** as part of `MastodonKit` (https://github.com/ornithocoder/MastodonKit)
** `MastodonKit` was created with an MIT License
****************************************************************************/

import Foundation

internal enum FixtureError: Error {
    case invalidPath, parseError
}

internal struct Fixture {
    static func loadData(from fileName: String) throws -> Data {
        guard let filePath = URL(string: fileName, relativeTo: self.fixturesDirectory) else {
            throw FixtureError.invalidPath
        }

        guard let data = try? Data(contentsOf: filePath) else {
            throw FixtureError.parseError
        }

        return data
    }

    static func loadJSON(from fileName: String) throws -> [String: Any] {
        guard
                let data = try? loadData(from: fileName),
                let json = try? JSONSerialization.jsonObject(with: data, options: []),
                let jsonObject = json as? [String: Any]
                else {
            throw FixtureError.parseError
        }

        return jsonObject
    }
}

fileprivate extension Fixture {
    static var fixturesDirectory: URL {
        return testsDirectory.appendingPathComponent("Fixtures")
    }

    static var testsDirectory: URL {
        var testsDirectory = URL(fileURLWithPath: #file, isDirectory: false)
        testsDirectory.deleteLastPathComponent()
        return testsDirectory
    }
}
