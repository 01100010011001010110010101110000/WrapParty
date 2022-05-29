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

// MARK: - TvSeasonServiceProviding

protocol TvSeasonServiceProviding: ServiceProviding & DetailAppendable {}

// MARK: - TvSeasonService

public struct TvSeasonService: TvSeasonServiceProviding {
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

  public func details(for id: Int, including: Set<Appendable> = []) async throws -> TvSeasonDetails {
    try await details(forShow: id, forSeason: 1, including: including, language: nil)
  }

  public func details(forShow id: Int, forSeason seasonNumber: Int, including: Set<Appendable> = []) async throws -> TvSeasonDetails {
    try await details(forShow: id, forSeason: seasonNumber, including: including, language: nil)
  }

  public func details(forShow id: Int, forSeason seasonNumber: Int, including: Set<Appendable> = [], language: String? = nil) async throws -> TvSeasonDetails {
    try await callEndpoint(routable: Router.details(showId: id, seasonNumber: seasonNumber, language: language, appending: including))
  }

  public func aggregateCredits(forShow id: Int, forSeason seasonNumber: Int, language: String? = nil) async throws -> TvAggregateCredits {
    try await callEndpoint(routable: Router.aggregateCredits(showId: id, seasonNumber: seasonNumber, language: language))
  }

  public func changes(forSeasonId seasonId: Int, startDate: Date? = nil, endDate: Date? = nil, page: Int? = nil) async throws -> MediaChanges {
    try await callEndpoint(routable: Router.changes(seasonId: seasonId, startDate: startDate, endDate: endDate, page: page))
  }

  public func credits(forShow id: Int, forSeason seasonNumber: Int, language: String? = nil) async throws -> MediaCredits {
    try await callEndpoint(routable: Router.credits(showId: id, seasonNumber: seasonNumber, language: language))
  }

  public func externalIds(forShow id: Int, forSeason seasonNumber: Int, language: String? = nil) async throws -> TvSeasonExternalIds {
    try await callEndpoint(routable: Router.externalIds(showId: id, seasonNumber: seasonNumber, language: language))
  }

  public func images(forShow id: Int, forSeason seasonNumber: Int, language: String? = nil, imageLanguages: Set<String>? = []) async throws -> TvSeasonImages {
    try await callEndpoint(routable: Router.images(id: id, seasonNumber: seasonNumber, language: language, imageLanguages: imageLanguages))
  }

  public func translations(forShow id: Int, forSeason seasonNumber: Int, language: String? = nil) async throws -> TvSeasonTranslations {
    try await callEndpoint(routable: Router.translations(id: id, seasonNumber: seasonNumber, language: language))
  }

  public func videos(forShow id: Int, forSeason seasonNumber: Int, language: String? = nil, videoLanguages: Set<String>? = []) async throws -> Results<MediaVideo> {
    try await callEndpoint(routable: Router.videos(id: id, seasonNumber: seasonNumber, language: language, videoLanguages: videoLanguages))
  }
}

extension TvSeasonService {
  public enum Appendable: String, CaseIterable {
    case aggregateCredits = "aggregate_credits"
    case credits
    case externalIds = "external_ids"
    case images
    case translations
    case videos
  }
}

extension TvSeasonService {
  enum Router: RequestRoutable {
    case aggregateCredits(showId: Int, seasonNumber: Int, language: String?)
    case changes(seasonId: Int, startDate: Date?, endDate: Date?, page: Int?)
    case credits(showId: Int, seasonNumber: Int, language: String?)
    case details(showId: Int, seasonNumber: Int, language: String?, appending: Set<Appendable>)
    case externalIds(showId: Int, seasonNumber: Int, language: String?)
    case images(id: Int, seasonNumber: Int, language: String?, imageLanguages: Set<String>?)
    case translations(id: Int, seasonNumber: Int, language: String?)
    case videos(id: Int, seasonNumber: Int, language: String?, videoLanguages: Set<String>?)

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .aggregateCredits(showId, seasonNumber, language):
        return componentsForRoute(path: "tv/\(showId)/season/\(seasonNumber)/aggregate_credits", queryItems: [
          "language": language,
        ]).url!
      case let .changes(seasonId, startDate, endDate, page):
        let dateFormat: Date.ISO8601FormatStyle = WrapParty.tmdbDefaultDateFormat
        return componentsForRoute(path: "tv/season/\(seasonId)/changes", queryItems: [
          "start_date": startDate?.formatted(dateFormat),
          "end_date": endDate?.formatted(dateFormat),
          "page": page.map { String($0) },
        ]).url!
      case let .credits(showId, seasonNumber, language):
        return componentsForRoute(path: "tv/\(showId)/season/\(seasonNumber)/credits", queryItems: [
          "language": language,
        ]).url!
      case let .details(showId, seasonNumber, language, appending):
        return componentsForRoute(path: "tv/\(showId)/season/\(seasonNumber)", queryItems: [
          "language": language,
          "append_to_response": appending.map(\.rawValue).joined(separator: ","),
        ]).url!
      case let .externalIds(showId, seasonNumber, language):
        return componentsForRoute(path: "tv/\(showId)/season/\(seasonNumber)/external_ids", queryItems: [
          "language": language,
        ]).url!
      case let .images(id, seasonNumber, language, imageLanguages):
        return componentsForRoute(path: "tv/\(id)/season/\(seasonNumber)/images", queryItems: [
          "language": language,
          "include_image_language": imageLanguages?.joined(separator: ","),
        ]).url!
      case let .translations(id, seasonNumber, language):
        return componentsForRoute(path: "tv/\(id)/season/\(seasonNumber)/translations", queryItems: [
          "language": language,
        ]).url!
      case let .videos(id, seasonNumber, language, videoLanguages):
        return componentsForRoute(path: "tv/\(id)/season/\(seasonNumber)/videos", queryItems: [
          "language": language,
          "include_video_language": videoLanguages?.joined(separator: ","),
        ]).url!
      }
    }
  }
}
