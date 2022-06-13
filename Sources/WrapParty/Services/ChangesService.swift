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

// MARK: - ChangesServiceProviding

public protocol ChangesServiceProviding: ServiceProviding {}

// MARK: - ChangesService

public struct ChangesService: ChangesServiceProviding {
  // MARK: Lifecycle

  public init(dataLoader: DataLoading, logger: Logger, tokenManager: TokenManager) {
    self.dataLoader = dataLoader
    self.logger = logger
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  public let dataLoader: DataLoading
  public let logger: Logger
  public let tokenManager: TokenManager

  public func changes(for mediaType: MediaType, start: Date? = nil, end: Date? = nil, page: Int? = nil) async throws -> ResultPage<ChangedEntity> {
    try await callEndpoint(routable: Router.changes(mediaType: mediaType, start: start, end: end, page: page))
  }

  public func changesSequence(for mediaType: MediaType, start: Date? = nil, end: Date? = nil) async -> PagedQuerySequence<ChangedEntity> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.changes(mediaType: mediaType, start: start, end: end, page: 1))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func allChanges(for mediaType: MediaType, start: Date? = nil, end: Date? = nil) async throws -> [ChangedEntity] {
    try await changesSequence(for: mediaType, start: start, end: end).allResults()
  }
}

extension ChangesService {
  enum Router: RequestRoutable {
    case changes(mediaType: MediaType, start: Date?, end: Date?, page: Int?)

    // MARK: Internal

    func asUrl() -> URL {
      let dateFormat: Date.ISO8601FormatStyle = WrapParty.tmdbDefaultDateFormat
      switch self {
      case let .changes(mediaType, start, end, page):
        return componentsForRoute(path: "\(mediaType.rawValue)/changes", queryItems: [
          "start_date": start?.formatted(dateFormat),
          "end_date": end?.formatted(dateFormat),
          "page": page.map { String($0) },
        ]).url!
      }
    }
  }
}
