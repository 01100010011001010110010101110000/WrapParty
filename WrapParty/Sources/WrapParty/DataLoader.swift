// Copyright (C) 2022 Tyler Gregory (@01100010011001010110010101110000)
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later
// version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation

// MARK: - DataLoading

public protocol DataLoading {
  func loadData(for request: URLRequest) async throws -> (Data, URLResponse)
}

// MARK: - DataLoader

final class DataLoader: DataLoading {
  // MARK: Lifecycle

  init(configuration: URLSessionConfiguration = DataLoader.defaultSessionConfig()) {
    session = URLSession(configuration: configuration)
    session.sessionDescription = "WrapParty URLSession"
  }

  // MARK: Internal

  static func defaultSessionConfig() -> URLSessionConfiguration {
    let configuration: URLSessionConfiguration = .default

    let processInfo = ProcessInfo()
    let userAgentString = [
      "WrapParty",
      // TODO: - Replace with real version string
      "v1.0.0",
      "\(processInfo.operatingSystemVersionString)",
    ].joined(separator: ":")
    configuration.httpAdditionalHeaders = [
      "User-Agent": userAgentString,
      "Accept": "application/json",
    ]

    let memoryCapacity = 10 * 1024 * 1024
    let diskCapacity = 150 * 1024 * 1024
    configuration.urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, directory: cacheDir)
    // Respect TMDB's cache-control headers
    configuration.requestCachePolicy = .useProtocolCachePolicy

    return configuration
  }

  func loadData(for request: URLRequest) async throws -> (Data, URLResponse) {
    try await session.data(for: request, delegate: nil)
  }

  // MARK: Private

  private static let cacheDir: URL? = {
    do {
      let url = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        .appendingPathComponent("http-cache", isDirectory: true)
      try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
      return url
    } catch {
      #if DEBUG
      print("Failed to configure cache dir: \(error)")
      #endif
      // If we fail, return nil and let URLCache use its default dir
      return nil
    }
  }()

  private let session: URLSession
}
