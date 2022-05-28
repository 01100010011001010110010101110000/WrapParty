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

// MARK: - TrendingServiceProviding

protocol TrendingServiceProviding: ServiceProviding {}

// MARK: - TrendingService

struct TrendingService: TrendingServiceProviding {
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

  func trending(for mediaType: TrendingMediaType, in window: TrendingTimeWindow, page: Int? = nil) async throws -> ResultPage<InlineMediaListResult> {
    try await callEndpoint(routable: Router.trending(mediaType: mediaType, window: window, page: page))
  }

  func trendingSequence(for mediaType: TrendingMediaType, in window: TrendingTimeWindow) async -> PagedQuerySequence<InlineMediaListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.trending(mediaType: mediaType, window: window, page: 1))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  func allTrending(for mediaType: TrendingMediaType, in window: TrendingTimeWindow) async throws -> [InlineMediaListResult] {
    try await trendingSequence(for: mediaType, in: window).allResults()
  }
}

extension TrendingService {
  enum Router: RequestRoutable {
    case trending(mediaType: TrendingMediaType, window: TrendingTimeWindow, page: Int?)

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .trending(mediaType, window, page):
        return componentsForRoute(path: "trending/\(mediaType.rawValue)/\(window.rawValue)", queryItems: [
          "page": page.map { String($0) },
        ]).url!
      }
    }
  }
}
