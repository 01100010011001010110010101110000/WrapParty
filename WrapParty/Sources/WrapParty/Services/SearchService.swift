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

// MARK: - SearchServiceProviding

protocol SearchServiceProviding: ServiceProviding {}

// MARK: - SearchService

struct SearchService: SearchServiceProviding {
  // MARK: Lifecycle

  init(dataLoader: DataLoading, tokenManager: TokenManager) {
    self.dataLoader = dataLoader
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  let dataLoader: DataLoading
  let tokenManager: TokenManager
}

extension SearchService {
  enum MovieSearchParams: String {
    case query
    case language
    case page
    case includeAdult = "include_adult"
    case region
    case year
    case primaryReleaseYear = "primary_release_year"
  }
}

extension SearchService {
  enum Router: RequestRoutable {
    case movies(query: String, language: String?, page: Int?, includeAdult: Bool?, region: String?, year: String?, primaryReleaseYear: String?)

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
//      case let .movies(query, language, page, includeAdult, region, year, primaryReleaseYear):
//        return componentsForRoute(path: "search/movie", queryItems: [
//          "query": query,
//          "language": language,
//          "page": page.map { String($0) },
//
//        ]).url!
      }
    }
  }
}
