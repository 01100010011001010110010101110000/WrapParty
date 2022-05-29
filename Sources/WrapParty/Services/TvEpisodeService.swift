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

// MARK: - TvEpisodeServiceProviding

protocol TvEpisodeServiceProviding: ServiceProviding & DetailAppendable {}

// MARK: - TvEpisodeService

public struct TvEpisodeService: TvEpisodeServiceProviding {
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

  public func details(for id: Int, including: Set<Appendable> = []) async throws -> TvEpisodeDetails {
    try await details(forShow: id, forSeason: 1, episodeNumber: 1, including: including, language: nil)
  }

  public func details(forShow id: Int, forSeason seasonNumber: Int, episodeNumber: Int, including: Set<Appendable> = []) async throws -> TvEpisodeDetails {
    try await details(forShow: id, forSeason: seasonNumber, episodeNumber: episodeNumber, including: including, language: nil)
  }

  public func details(forShow id: Int, forSeason seasonNumber: Int, episodeNumber: Int, including: Set<Appendable> = [], language: String? = nil) async throws -> TvEpisodeDetails {
    try await callEndpoint(routable: Router.details(showId: id, seasonNumber: seasonNumber, episodeNumber: episodeNumber, language: language, appending: including))
  }

  public func changes(forEpisodeId episodeId: Int, startDate: Date? = nil, endDate: Date? = nil, page: Int? = nil) async throws -> MediaChanges {
    try await callEndpoint(routable: Router.changes(episodeId: episodeId, startDate: startDate, endDate: endDate, page: page))
  }

  public func credits(forShow id: Int, forSeason seasonNumber: Int, episodeNumber: Int, language: String? = nil) async throws -> MediaCredits {
    try await callEndpoint(routable: Router.credits(showId: id, seasonNumber: seasonNumber, episodeNumber: episodeNumber, language: language))
  }

  public func externalIds(forShow id: Int, forSeason seasonNumber: Int, episodeNumber: Int, language: String? = nil) async throws -> TvEpisodeExternalIds {
    try await callEndpoint(routable: Router.externalIds(showId: id, seasonNumber: seasonNumber, episodeNumber: episodeNumber, language: language))
  }

  public func images(forShow id: Int, forSeason seasonNumber: Int, episodeNumber: Int, language: String? = nil, imageLanguages: Set<String>? = []) async throws -> TvEpisodeImages {
    try await callEndpoint(routable: Router.images(id: id, seasonNumber: seasonNumber, episodeNumber: episodeNumber, language: language, imageLanguages: imageLanguages))
  }

  public func translations(forShow id: Int, forSeason seasonNumber: Int, episodeNumber: Int, language: String? = nil) async throws -> TvEpisodeTranslations {
    try await callEndpoint(routable: Router.translations(id: id, seasonNumber: seasonNumber, episodeNumber: episodeNumber, language: language))
  }

  public func videos(forShow id: Int, forSeason seasonNumber: Int, episodeNumber: Int, language: String? = nil, videoLanguages: Set<String>? = []) async throws -> Results<MediaVideo> {
    try await callEndpoint(routable: Router.videos(id: id, seasonNumber: seasonNumber, episodeNumber: episodeNumber, language: language, videoLanguages: videoLanguages))
  }
}

extension TvEpisodeService {
  public enum Appendable: String, CaseIterable {
    case credits
    case externalIds = "external_ids"
    case images
    case translations
    case videos
  }
}

extension TvEpisodeService {
  enum Router: RequestRoutable {
    case changes(episodeId: Int, startDate: Date?, endDate: Date?, page: Int?)
    case credits(showId: Int, seasonNumber: Int, episodeNumber: Int, language: String?)
    case details(showId: Int, seasonNumber: Int, episodeNumber: Int, language: String?, appending: Set<Appendable>)
    case externalIds(showId: Int, seasonNumber: Int, episodeNumber: Int, language: String?)
    case images(id: Int, seasonNumber: Int, episodeNumber: Int, language: String?, imageLanguages: Set<String>?)
    case translations(id: Int, seasonNumber: Int, episodeNumber: Int, language: String?)
    case videos(id: Int, seasonNumber: Int, episodeNumber: Int, language: String?, videoLanguages: Set<String>?)

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .changes(episodeId, startDate, endDate, page):
        let dateFormat: Date.ISO8601FormatStyle = .iso8601.year().month().day()
        return componentsForRoute(path: "tv/episode/\(episodeId)/changes", queryItems: [
          "start_date": startDate?.formatted(dateFormat),
          "end_date": endDate?.formatted(dateFormat),
          "page": page.map { String($0) },
        ]).url!
      case let .credits(showId, seasonNumber, episodeNumber, language):
        return componentsForRoute(path: "\(episodePath(showId: showId, seasonNumber: seasonNumber, episodeNumber: episodeNumber))/credits", queryItems: [
          "language": language,
        ]).url!
      case let .details(showId, seasonNumber, episodeNumber, language, appending):
        return componentsForRoute(path: episodePath(showId: showId, seasonNumber: seasonNumber, episodeNumber: episodeNumber), queryItems: [
          "language": language,
          "append_to_response": appending.map(\.rawValue).joined(separator: ","),
        ]).url!
      case let .externalIds(showId, seasonNumber, episodeNumber, language):
        return componentsForRoute(path: "\(episodePath(showId: showId, seasonNumber: seasonNumber, episodeNumber: episodeNumber))/external_ids", queryItems: [
          "language": language,
        ]).url!
      case let .images(id, seasonNumber, episodeNumber, language, imageLanguages):
        return componentsForRoute(path: "\(episodePath(showId: id, seasonNumber: seasonNumber, episodeNumber: episodeNumber))/images", queryItems: [
          "language": language,
          "include_image_language": imageLanguages?.joined(separator: ","),
        ]).url!
      case let .translations(id, seasonNumber, episodeNumber, language):
        return componentsForRoute(path: "\(episodePath(showId: id, seasonNumber: seasonNumber, episodeNumber: episodeNumber))/translations", queryItems: [
          "language": language,
        ]).url!
      case let .videos(id, seasonNumber, episodeNumber, language, videoLanguages):
        return componentsForRoute(path: "\(episodePath(showId: id, seasonNumber: seasonNumber, episodeNumber: episodeNumber))/videos", queryItems: [
          "language": language,
          "include_video_language": videoLanguages?.joined(separator: ","),
        ]).url!
      }
    }

    // MARK: Private

    private func episodePath(showId: Int, seasonNumber: Int, episodeNumber: Int) -> String {
      "tv/\(showId)/season/\(seasonNumber)/episode/\(episodeNumber)"
    }
  }
}
