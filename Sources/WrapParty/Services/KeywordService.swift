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

// MARK: - KeywordServiceProviding

public protocol KeywordServiceProviding: ServiceProviding {}

// MARK: - KeywordService

public struct KeywordService: KeywordServiceProviding {
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

  public func details(id: Int) async throws -> Keyword {
    try await callEndpoint(routable: Router.details(id: id))
  }

  public func moviesWithKeyword(id: Int, language: String? = nil, includeAdult: Bool? = nil, page: Int? = nil) async throws -> ResultPage<MovieListResult> {
    try await callEndpoint(routable: Router.movieWithKeyword(keywordId: id, language: language, includeAdult: includeAdult, page: page))
  }

  public func moviesWithKeywordSequence(id: Int, language: String? = nil, includeAdult: Bool? = nil) async -> PagedQuerySequence<MovieListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.movieWithKeyword(keywordId: id, language: language, includeAdult: includeAdult, page: 1))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func allMoviesWithKeyword(id: Int, language: String? = nil, includeAdult: Bool? = nil) async throws -> [MovieListResult] {
    try await moviesWithKeywordSequence(id: id, language: language, includeAdult: includeAdult).allResults()
  }
}

extension KeywordService {
  enum Router: RequestRoutable {
    case details(id: Int)
    case movieWithKeyword(keywordId: Int, language: String?, includeAdult: Bool?, page: Int?)

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .details(id):
        return componentsForRoute(path: "keyword/\(id)").url!
      case let .movieWithKeyword(id, language, includeAdult, page):
        return componentsForRoute(path: "keyword/\(id)/movies", queryItems: [
          "language": language,
          "include_adult": includeAdult.map { String($0) },
          "page": page.map { String($0) },
        ]).url!
      }
    }
  }
}
