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
    try await callEndpoint(routable: Router.alternativeTitles(id: id, countryCode: code))
  }

  func details(for id: Int, including: Set<Appendable> = [], language: String? = nil) async throws -> Movie {
    try await callEndpoint(routable: Router.details(id: id, appending: including, language: language))
  }

  func changes(for id: Int, startDate: Date? = nil, endDate: Date? = nil) async throws -> MovieChanges {
    try await callEndpoint(routable: Router.changes(id: id, startDate: startDate, endDate: endDate))
  }

  func credits(for id: Int, language: String? = nil) async throws -> MovieCredits {
    try await callEndpoint(routable: Router.credits(id: id, language: language))
  }

  func details(for id: Int, including: Set<Appendable> = []) async throws -> Movie {
    try await details(for: id, including: including, language: nil)
  }

  func images(for _: Int) async throws -> MovieImages { fatalError("images(for:) has not been implemented") }

  // MARK: Private

  // Might move this out to be used by all services
  private func callEndpoint<R: RequestRoutable, Result: Codable>(routable: R) async throws -> Result {
    let request = await tokenManager.vendAuthenticatedRequest(for: routable)
    // TODO: - Implement response status code checking
    let (data, response) = try await dataLoader.loadData(for: request)
    return try WrapParty.jsonDecoder.decode(Result.self, from: data)
  }
}

extension MovieService {
  enum Appendable: String {
    case alternativeTitles = "alternative_titles"
    case changes
    case credits
    case images
    case videos
  }
}

extension MovieService {
  enum Router: RequestRoutable {
    case alternativeTitles(id: Int, countryCode: String?)
    case changes(id: Int, startDate: Date?, endDate: Date?)
    case credits(id: Int, language: String?)
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
        var components = componentsForRoute(path: "movie/\(id)/alternative_titles", queryItems: [
          "country": countryCode,
        ])
        return components.url!
      case let .changes(id, startDate, endDate):
        let dateFormat: Date.ISO8601FormatStyle = .iso8601.year().month().day()
        var components = componentsForRoute(path: "movie/\(id)/changes", queryItems: [
          "start_date": startDate?.formatted(dateFormat),
          "end_date": endDate?.formatted(dateFormat),
        ])
        return components.url!
      case let .credits(id, language):
        var components = componentsForRoute(path: "movie/\(id)/credits", queryItems: [
          "language": language,
        ])
        return components.url!
      case let .details(id, appending, language):
        var components = componentsForRoute(path: "movie/\(id)", queryItems: [
          "append_to_response": appending.map(\.rawValue).joined(separator: ","),
          "language": language,
        ])
        return components.url!
      }
    }

    // MARK: Private

    private func componentsForRoute(path: String, queryItems: [String: String?] = [:], filterEmptyQueryItems: Bool = true) -> URLComponents {
      var components = URLComponents(url: URL(string: path, relativeTo: WrapParty.baseUrl)!, resolvingAgainstBaseURL: true)!
      components.queryItems = queryItems.compactMap { key, value in
        if filterEmptyQueryItems, value?.isEmpty ?? true { return nil }
        return URLQueryItem(name: key, value: value)
      }
      return components
    }
  }
}
