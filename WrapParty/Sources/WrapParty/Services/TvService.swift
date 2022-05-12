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

// MARK: - TvServiceProviding

protocol TvServiceProviding: ServiceProviding & DetailAppendable {}

// MARK: - TvService

struct TvService: TvServiceProviding {
  let dataLoader: DataLoading
  let logger: Logger
  let tokenManager: TokenManager

  func aggregateCredits(for id: Int, language: String? = nil) async throws -> TvAggregateCredits {
    try await callEndpoint(routable: Router.aggregateCredits(id: id, language: language))
  }

  func alternativeTitles(for id: Int, language: String? = nil) async throws -> TvAlternativeTitles {
    try await callEndpoint(routable: Router.alternativeTitles(id: id, language: language))
  }

  func changes(for id: Int, startDate: Date? = nil, endDate: Date? = nil, page: Int? = nil) async throws -> MediaChanges {
    try await callEndpoint(routable: Router.changes(id: id, startDate: startDate, endDate: endDate, page: page))
  }

  func contentRatings(for id: Int, language: String? = nil) async throws -> TvContentRatings {
    try await callEndpoint(routable: Router.contentRatings(id: id, language: language))
  }

  func credits(for id: Int, language: String? = nil) async throws -> Credits {
    try await callEndpoint(routable: Router.credits(id: id, language: language))
  }

  func details(for id: Int, including: Set<Appendable> = []) async throws -> TvShow {
    try await details(for: id, including: including, language: nil, imageLanguages: [], videoLanguages: [], page: nil)
  }

  func details(for id: Int, including: Set<Appendable> = [], language: String? = nil, imageLanguages: Set<String>? = [], videoLanguages: Set<String>? = [], page: Int? = nil) async throws -> TvShow {
    try await callEndpoint(routable: Router.details(id: id, appending: including, language: language, imageLanguages: imageLanguages, videoLanguages: videoLanguages, page: page))
  }
}

extension TvService {
  enum Appendable: String, CaseIterable {
    case aggregateCredits = "aggregate_credits"
    case alternativeTitles = "alternative_titles"
    case changes
    case contentRatings = "content_ratings"
    case credits
    case episodeGroups = "episode_groups"
    case externalIds = "external_ids"
    case images
    case keywords
    case recommendations
    case reviews
    case screenedTheatrically = "screened_theatrically"
    case similar
    case translations
    case videos
    case watchProviders = "watch/providers"
  }
}

extension TvService {
  enum Router: RequestRoutable {
    case aggregateCredits(id: Int, language: String?)
    case alternativeTitles(id: Int, language: String?)
    case changes(id: Int, startDate: Date?, endDate: Date?, page: Int?)
    case contentRatings(id: Int, language: String?)
    case credits(id: Int, language: String?)
    case details(id: Int, appending: Set<Appendable>, language: String?, imageLanguages: Set<String>?, videoLanguages: Set<String>?, page: Int?)

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .aggregateCredits(id, language):
        return componentsForRoute(path: "tv/\(id)/aggregate_credits", queryItems: [
          "language": language,
        ]).url!
      case let .alternativeTitles(id, language):
        return componentsForRoute(path: "tv/\(id)/alternative_titles", queryItems: [
          "language": language,
        ]).url!
      case let .changes(id, startDate, endDate, page):
        let dateFormat: Date.ISO8601FormatStyle = .iso8601.year().month().day()
        return componentsForRoute(path: "tv/\(id)/changes", queryItems: [
          "start_date": startDate?.formatted(dateFormat),
          "end_date": endDate?.formatted(dateFormat),
          "page": page.map { String($0) },
        ]).url!
      case let .contentRatings(id, language):
        return componentsForRoute(path: "tv/\(id)/content_ratings", queryItems: [
          "language": language,
        ]).url!
      case let .credits(id, language):
        return componentsForRoute(path: "tv/\(id)/credits", queryItems: [
          "language": language,
        ]).url!
      case let .details(id, appending, language, imageLanguages, videoLanguages, page):
        return componentsForRoute(path: "tv/\(id)", queryItems: [
          "append_to_response": appending.map(\.rawValue).joined(separator: ","),
          "language": language,
          "include_image_language": imageLanguages?.joined(separator: ","),
          "include_video_language": videoLanguages?.joined(separator: ","),
          "page": page.map { String($0) },
        ]).url!
      }
    }
  }
}
