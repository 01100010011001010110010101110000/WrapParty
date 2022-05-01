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
  func details(for id: Int, including: Set<Appendable>, language: String?, imageLanguages: Set<String>?) async throws -> Movie
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

  func changes(for id: Int, startDate: Date? = nil, endDate: Date? = nil) async throws -> MovieChanges {
    try await callEndpoint(routable: Router.changes(id: id, startDate: startDate, endDate: endDate))
  }

  func credits(for id: Int, language: String? = nil) async throws -> MovieCredits {
    try await callEndpoint(routable: Router.credits(id: id, language: language))
  }

  func externalIds(for id: Int) async throws -> MovieExternalIds {
    try await callEndpoint(routable: Router.externalIds(id: id))
  }

  func details(for id: Int, including: Set<Appendable> = [], language: String? = nil, imageLanguages: Set<String>? = []) async throws -> Movie {
    try await callEndpoint(routable: Router.details(id: id, appending: including, language: language, imageLanguages: imageLanguages))
  }

  func details(for id: Int, including: Set<Appendable> = []) async throws -> Movie {
    try await details(for: id, including: including, language: nil)
  }

  func keywords(for id: Int) async throws -> MovieKeywords {
    try await callEndpoint(routable: Router.keywords(id: id))
  }

  func images(for id: Int, language: String? = nil, imageLanguages: Set<String>? = []) async throws -> MovieImages {
    try await callEndpoint(routable: Router.images(id: id, language: language, imageLanguages: imageLanguages))
  }

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
  enum Appendable: String, CaseIterable {
    case alternativeTitles = "alternative_titles"
    case changes
    case credits
    case externalIds = "external_ids"
    case images
    case keywords
    case videos
  }
}

extension MovieService {
  enum Router: RequestRoutable {
    case alternativeTitles(id: Int, countryCode: String?)
    case changes(id: Int, startDate: Date?, endDate: Date?)
    case credits(id: Int, language: String?)
    case details(id: Int, appending: Set<Appendable>, language: String?, imageLanguages: Set<String>?)
    case externalIds(id: Int)
    case images(id: Int, language: String?, imageLanguages: Set<String>?)
    case keywords(id: Int)

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
        let components = componentsForRoute(path: "movie/\(id)/alternative_titles", queryItems: [
          "country": countryCode,
        ])
        return components.url!
      case let .changes(id, startDate, endDate):
        let dateFormat: Date.ISO8601FormatStyle = .iso8601.year().month().day()
        let components = componentsForRoute(path: "movie/\(id)/changes", queryItems: [
          "start_date": startDate?.formatted(dateFormat),
          "end_date": endDate?.formatted(dateFormat),
        ])
        return components.url!
      case let .credits(id, language):
        let components = componentsForRoute(path: "movie/\(id)/credits", queryItems: [
          "language": language,
        ])
        return components.url!
      case let .details(id, appending, language, imageLanguages):
        let components = componentsForRoute(path: "movie/\(id)", queryItems: [
          "append_to_response": appending.map(\.rawValue).joined(separator: ","),
          "language": language,
          "include_image_language": imageLanguages?.joined(separator: ","),
        ])
        return components.url!
      case let .externalIds(id):
        return componentsForRoute(path: "movie/\(id)/external_ids").url!
      case let .images(id, language, imageLanguages):
        let components = componentsForRoute(path: "movie/\(id)/images", queryItems: [
          "language": language,
          "include_image_language": imageLanguages?.joined(separator: ","),
        ])
        return components.url!
      case let .keywords(id):
        return componentsForRoute(path: "movie/\(id)/keywords").url!
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
