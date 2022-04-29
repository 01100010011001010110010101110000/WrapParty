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

// MARK: - MovieServiceProviding

protocol MovieServiceProviding: ServiceProviding & DetailAppendable {
  func details(for id: Int, including: Set<Appendable>, language: String?) async throws -> Movie
  func images(for id: Int) async throws -> MovieImages
}

// MARK: - MovieService

struct MovieService: MovieServiceProviding {
  // MARK: Lifecycle

  init(dataLoader: DataLoading, tokenManager: TokenManager) {
    self.dataLoader = dataLoader
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  let dataLoader: DataLoading
  let tokenManager: TokenManager

  func alternativeTitles(for id: Int, inCountry code: String? = nil) async throws -> MovieAlternativeTitle {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.alternativeTitles(id: id, countryCode: code))
    let (data, response) = try await dataLoader.loadData(for: request)
    return try WrapParty.jsonDecoder.decode(MovieAlternativeTitle.self, from: data)
  }

  func details(for id: Int, including: Set<Appendable> = [], language: String? = nil) async throws -> Movie {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.details(id: id, appending: including, language: language))
    let (data, response) = try await dataLoader.loadData(for: request)
    // TODO: - Implement response status code checking
    return try WrapParty.jsonDecoder.decode(Movie.self, from: data)
  }

  func changes(for id: Int, startDate: Date? = nil, endDate: Date? = nil) async throws -> MovieChanges {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.changes(id: id, startDate: startDate, endDate: endDate))
    let (data, response) = try await dataLoader.loadData(for: request)
    return try WrapParty.jsonDecoder.decode(MovieChanges.self, from: data)
  }

  func details(for id: Int, including: Set<Appendable> = []) async throws -> Movie {
    try await details(for: id, including: including, language: nil)
  }

  func images(for _: Int) async throws -> MovieImages { fatalError("images(for:) has not been implemented") }
}

extension MovieService {
  enum Appendable: String {
    case alternativeTitles = "alternative_titles"
    case changes
    case images
    case videos
  }
}

extension MovieService {
  enum Router: RequestRouter {
    case alternativeTitles(id: Int, countryCode: String?)
    case changes(id: Int, startDate: Date?, endDate: Date?)
    case details(id: Int, appending: Set<Appendable>, language: String?)

    // MARK: Internal

    func asUrlRequest() -> URLRequest {
      switch self {
      default:
        return URLRequest(url: asUrl())
      }
    }

    func asUrl() -> URL {
      switch self {
      case let .alternativeTitles(id, countryCode):
        var components = componentsForRoute(path: "movie/\(id)/alternative_titles")
        if let countryCode = countryCode { components.queryItems = [URLQueryItem(name: "country", value: countryCode)] }
        return components.url!
      case let .changes(id, startDate, endDate):
        let dateFormat: Date.ISO8601FormatStyle = .iso8601.year().month().day()
        var components = componentsForRoute(path: "movie/\(id)/changes")
        components.queryItems = []
        if let date = startDate { components.queryItems?.append(URLQueryItem(name: "start_date", value: dateFormat.format(date))) }
        if let date = endDate { components.queryItems?.append(URLQueryItem(name: "end_date", value: dateFormat.format(date))) }
        return components.url!
      case let .details(id, appending, language):
        var components = componentsForRoute(path: "movie/\(id)")
        components.queryItems = [
          URLQueryItem(name: "language", value: language),
          URLQueryItem(name: "append_to_response", value: appending.map(\.rawValue).joined(separator: ",")),
        ].filter { !($0.value?.isEmpty ?? true) }
        return components.url!
      }
    }

    // MARK: Private

    private func componentsForRoute(path: String) -> URLComponents {
      URLComponents(url: URL(string: path, relativeTo: WrapParty.baseUrl)!, resolvingAgainstBaseURL: true)!
    }
  }
}
