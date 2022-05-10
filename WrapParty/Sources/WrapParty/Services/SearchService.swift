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

// MARK: - SearchServiceProviding

protocol SearchServiceProviding: ServiceProviding {}

// MARK: - SearchService

struct SearchService: SearchServiceProviding {
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

  func searchMovies(matching query: String, page: Int = 1, parameters: [MovieSearchParams] = []) async throws -> ResultPage<Movie> {
    try await callEndpoint(routable: Router.movies(query: query, page: page, parameters))
  }

  func allMovieSearchResults(matching query: String, parameters: [MovieSearchParams] = []) async throws -> [Movie] {
    try await searchMovieSequence(matching: query, parameters: parameters).allResults()
  }

  func searchMovieSequence(matching query: String, parameters: [MovieSearchParams] = []) async -> PagedQuerySequence<Movie> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.movies(query: query, page: 1, parameters))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }
}

extension SearchService {
  public enum MovieSearchParams {
    case language(String)
    case page(Int)
    case includeAdult(Bool)
    case region(String)
    case year(Int)
    case primaryReleaseYear(Int)

    // MARK: Internal

    var queryKey: String {
      switch self {
      case .language:
        return "language"
      case .page:
        return "page"
      case .includeAdult:
        return "include_adult"
      case .region:
        return "region"
      case .year:
        return "year"
      case .primaryReleaseYear:
        return "primary_release_year"
      }
    }

    var queryValue: String? {
      switch self {
      case let .language(language):
        return language
      case let .page(page):
        return String(page)
      case let .includeAdult(includeAdult):
        return String(includeAdult)
      case let .region(region):
        return region
      case let .year(year):
        return String(year)
      case let .primaryReleaseYear(primaryReleaseYear):
        return String(primaryReleaseYear)
      }
    }
  }
}

extension RandomAccessCollection where Element == SearchService.MovieSearchParams {
  func toQueryItems() -> [String: String] {
    var results: [String: String] = Dictionary(minimumCapacity: count)
    forEach { results[$0.queryKey] = $0.queryValue }
    return results
  }
}

extension SearchService {
  enum Router: RequestRoutable {
    case movies(query: String, page: Int, [MovieSearchParams])

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .movies(query, page, parameters):
        var queryItems = parameters.toQueryItems()
        queryItems["query"] = query
        queryItems["page"] = String(page)
        return componentsForRoute(path: "search/movie", queryItems: queryItems).url!
      }
    }
  }
}
