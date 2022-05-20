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

// MARK: - PersonServiceProviding

protocol PersonServiceProviding: ServiceProviding {}

// MARK: - PersonService

struct PersonService: PersonServiceProviding {
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

  func changes(for id: Int, startDate: Date? = nil, endDate: Date? = nil, page: Int? = nil) async throws -> MediaChanges {
    try await callEndpoint(routable: Router.changes(id: id, startDate: startDate, endDate: endDate, page: page))
  }

  func combinedCredits(for id: Int, language: String? = nil) async throws -> PersonCombinedCredits {
    try await callEndpoint(routable: Router.combinedCredits(id: id, language: language))
  }

  func details(for id: Int, including: Set<Appendable> = []) async throws -> Person {
    try await callEndpoint(routable: Router.details(id: id, appending: including, language: nil, page: nil))
  }

  func details(for id: Int, including: Set<Appendable> = [], language: String? = nil, page: Int? = nil) async throws -> Person {
    try await callEndpoint(routable: Router.details(id: id, appending: including, language: language, page: page))
  }

  func externalIds(for id: Int, language: String? = nil) async throws -> ExternalIds {
    try await callEndpoint(routable: Router.externalIds(id: id, language: language))
  }

  func images(for id: Int) async throws -> PersonImages {
    try await callEndpoint(routable: Router.images(id: id))
  }

  func movieCredits(for id: Int, language: String? = nil) async throws -> PersonMovieCredits {
    try await callEndpoint(routable: Router.movieCredits(id: id, language: language))
  }

  func allTaggedImages(for id: Int, language: String? = nil) async throws -> [PersonTaggedImageAsset] {
    try await taggedImageSequence(for: id, language: language).allResults()
  }

  func taggedImages(for id: Int, language: String? = nil, page: Int? = nil) async throws -> ResultPage<PersonTaggedImageAsset> {
    try await callEndpoint(routable: Router.taggedImages(id: id, language: language, page: page))
  }

  func taggedImageSequence(for id: Int, language: String? = nil) async throws -> PagedQuerySequence<PersonTaggedImageAsset> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.taggedImages(id: id, language: language, page: 1))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  func translations(for id: Int, language: String? = nil) async throws -> PersonTranslations {
    try await callEndpoint(routable: Router.translations(id: id, language: language))
  }

  func tvCredits(for id: Int, language: String? = nil) async throws -> PersonTvCredits {
    try await callEndpoint(routable: Router.tvCredits(id: id, language: language))
  }

  func latest(language: String? = nil) async throws -> Person {
    try await callEndpoint(routable: Router.latest(language: language))
  }

  func allPopular(language: String? = nil) async throws -> [PersonListResult] {
    try await popularSequence(language: language).allResults()
  }

  func popular(language: String? = nil, page: Int? = nil) async throws -> ResultPage<PersonListResult> {
    try await callEndpoint(routable: Router.popular(language: language, page: page))
  }

  func popularSequence(language: String? = nil) async throws -> PagedQuerySequence<PersonListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.popular(language: language, page: 1))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }
}

extension PersonService {
  enum Appendable: String, CaseIterable {
    case changes
    case combinedCredits = "combined_credits"
    case externalIds = "external_ids"
    case images
    case movieCredits = "movie_credits"
    case taggedImages = "tagged_images"
    case translations
    case tvCredits = "tv_credits"
  }
}

extension PersonService {
  enum Router: RequestRoutable {
    case changes(id: Int, startDate: Date?, endDate: Date?, page: Int?)
    case combinedCredits(id: Int, language: String?)
    case details(id: Int, appending: Set<Appendable>, language: String?, page: Int?)
    case externalIds(id: Int, language: String?)
    case images(id: Int)
    case movieCredits(id: Int, language: String?)
    case taggedImages(id: Int, language: String?, page: Int?)
    case translations(id: Int, language: String?)
    case tvCredits(id: Int, language: String?)

    // Meta endpoints

    case latest(language: String?)
    case popular(language: String?, page: Int?)

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .changes(id, startDate, endDate, page):
        let dateFormat: Date.ISO8601FormatStyle = .iso8601.year().month().day()
        return componentsForRoute(path: "person/\(id)/changes", queryItems: [
          "start_date": startDate?.formatted(dateFormat),
          "end_date": endDate?.formatted(dateFormat),
          "page": page.map { String($0) },
        ]).url!
      case let .combinedCredits(id, language):
        return componentsForRoute(path: "person/\(id)/combined_credits", queryItems: [
          "language": language,
        ]).url!
      case let .details(id, appending, language, page):
        return componentsForRoute(path: "person/\(id)", queryItems: [
          "append_to_response": appending.map(\.rawValue).joined(separator: ","),
          "language": language,
          "page": page.map { String($0) },
        ]).url!
      case let .externalIds(id, language):
        return componentsForRoute(path: "person/\(id)/external_ids", queryItems: [
          "language": language,
        ]).url!
      case let .images(id):
        return componentsForRoute(path: "person/\(id)/images").url!
      case let .movieCredits(id, language):
        return componentsForRoute(path: "person/\(id)/movie_credits", queryItems: [
          "language": language,
        ]).url!
      case let .taggedImages(id, language, page):
        return componentsForRoute(path: "person/\(id)/tagged_images", queryItems: [
          "language": language,
          "page": page.map { String($0) },
        ]).url!
      case let .translations(id, language):
        return componentsForRoute(path: "person/\(id)/translations", queryItems: [
          "language": language,
        ]).url!
      case let .tvCredits(id, language):
        return componentsForRoute(path: "person/\(id)/tv_credits", queryItems: [
          "language": language,
        ]).url!

      case let .latest(language):
        return componentsForRoute(path: "person/latest", queryItems: [
          "language": language,
        ]).url!
      case let .popular(language, page):
        return componentsForRoute(path: "person/popular", queryItems: [
          "language": language,
          "page": page.map { String($0) },
        ]).url!
      }
    }
  }
}
