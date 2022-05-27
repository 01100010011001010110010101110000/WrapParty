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
import Logging

// MARK: - WatchProviderServiceProviding

protocol WatchProviderServiceProviding: ServiceProviding {}

// MARK: - WatchProviderService

struct WatchProviderService: WatchProviderServiceProviding {
  // MARK: Lifecycle

  init(dataLoader: DataLoading, logger: Logger, tokenManager: TokenManager) {
    self.dataLoader = dataLoader
    self.logger = logger
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  let dataLoader: DataLoading
  let logger: Logger
  let tokenManager: TokenManager

  func regions(language: String? = nil) async throws -> Results<TmdbConfiguration.Country> {
    try await callEndpoint(routable: Router.regions(language: language))
  }

  func movieProviders(language: String? = nil, region: String? = nil) async throws -> Results<WatchProviders.Provider> {
    try await callEndpoint(routable: Router.movie(language: language, region: region))
  }

  func tvProviders(language: String? = nil, region: String? = nil) async throws -> Results<WatchProviders.Provider> {
    try await callEndpoint(routable: Router.tv(language: language, region: region))
  }
}

extension WatchProviderService {
  enum Router: RequestRoutable {
    case regions(language: String?)
    case tv(language: String?, region: String?)
    case movie(language: String?, region: String?)

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .regions(language):
        return componentsForRoute(path: "watch/providers/regions", queryItems: [
          "language": language,
        ]).url!
      case let .tv(language, region):
        return componentsForRoute(path: "watch/providers/tv", queryItems: [
          "language": language,
          "watch_region": region,
        ]).url!
      case let .movie(language, region):
        return componentsForRoute(path: "watch/providers/movie", queryItems: [
          "language": language,
          "watch_region": region,
        ]).url!
      }
    }
  }
}
