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

public protocol TvServiceProviding: ServiceProviding & DetailAppendable {}

// MARK: - TvService

public struct TvService: TvServiceProviding {
  public let dataLoader: DataLoading
  public let logger: Logger
  public let tokenManager: TokenManager

  public func aggregateCredits(for id: Int, language: String? = nil) async throws -> TvAggregateCredits {
    try await callEndpoint(routable: Router.aggregateCredits(id: id, language: language))
  }

  public func alternativeTitles(for id: Int, language: String? = nil) async throws -> Results<AlternativeTitle> {
    try await callEndpoint(routable: Router.alternativeTitles(id: id, language: language))
  }

  public func changes(for id: Int, startDate: Date? = nil, endDate: Date? = nil, page: Int? = nil) async throws -> MediaChanges {
    try await callEndpoint(routable: Router.changes(id: id, startDate: startDate, endDate: endDate, page: page))
  }

  public func contentRatings(for id: Int, language: String? = nil) async throws -> Results<TvContentRating> {
    try await callEndpoint(routable: Router.contentRatings(id: id, language: language))
  }

  public func credits(for id: Int, language: String? = nil) async throws -> MediaCredits {
    try await callEndpoint(routable: Router.credits(id: id, language: language))
  }

  public func details(for id: Int, including: Set<Appendable> = []) async throws -> TvShow {
    try await details(for: id, including: including, language: nil, imageLanguages: [], videoLanguages: [], page: nil)
  }

  public func details(for id: Int, including: Set<Appendable> = [], language: String? = nil, imageLanguages: Set<String>? = [], videoLanguages: Set<String>? = [], page: Int? = nil) async throws -> TvShow {
    try await callEndpoint(routable: Router.details(id: id, appending: including, language: language, imageLanguages: imageLanguages, videoLanguages: videoLanguages, page: page))
  }

  public func episodeGroups(for id: Int, language: String? = nil) async throws -> Results<TvEpisodeGroup> {
    try await callEndpoint(routable: Router.episodeGroups(id: id, language: language))
  }

  public func externalIds(for id: Int, language: String? = nil) async throws -> ExternalIds {
    try await callEndpoint(routable: Router.externalIds(id: id, language: language))
  }

  public func images(for id: Int, language: String? = nil, imageLanguages: Set<String>? = []) async throws -> MediaImages {
    try await callEndpoint(routable: Router.images(id: id, language: language, imageLanguages: imageLanguages))
  }

  public func keywords(for id: Int) async throws -> Results<Keyword> {
    try await callEndpoint(routable: Router.keywords(id: id))
  }

  public func recommendations(for id: Int, page: Int = 1, language: String? = nil) async throws -> ResultPage<TvListResult> {
    try await callEndpoint(routable: Router.recommendations(id: id, language: language, page: page))
  }

  public func allRecommendations(for id: Int, language: String? = nil) async throws -> [TvListResult] {
    try await recommendationSequence(for: id, language: language).allResults()
  }

  public func recommendationSequence(for id: Int, language: String? = nil) async -> PagedQuerySequence<TvListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.recommendations(id: id, language: language, page: 1))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func reviews(for id: Int, page: Int = 1, language: String? = nil) async throws -> ResultPage<Review> {
    try await callEndpoint(routable: Router.reviews(id: id, language: language, page: page))
  }

  public func allReviews(for id: Int, language: String? = nil) async throws -> [Review] {
    try await reviewsSequence(for: id, language: language).allResults()
  }

  public func reviewsSequence(for id: Int, language: String? = nil) async -> PagedQuerySequence<Review> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.reviews(id: id, language: language, page: 1))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func episodesScreenedTheatrically(for id: Int) async throws -> Results<TvScreenedEpisode> {
    try await callEndpoint(routable: Router.screenedTheatrically(id: id))
  }

  public func similarTvShows(for id: Int, page: Int = 1, language: String? = nil) async throws -> ResultPage<TvListResult> {
    try await callEndpoint(routable: Router.similar(id: id, language: language, page: page))
  }

  public func allSimilarTvShows(for id: Int, language: String? = nil) async throws -> [TvListResult] {
    try await similarTvShowSequence(for: id, language: language).allResults()
  }

  public func similarTvShowSequence(for id: Int, language: String? = nil) async -> PagedQuerySequence<TvListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.similar(id: id, language: language, page: 1))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func translations(for id: Int) async throws -> MediaTranslations {
    try await callEndpoint(routable: Router.translations(id: id))
  }

  public func videos(for id: Int, language: String? = nil, videoLanguages: Set<String> = []) async throws -> Results<MediaVideo> {
    try await callEndpoint(routable: Router.videos(id: id, language: language, videoLanguages: videoLanguages))
  }

  public func watchProviders(for id: Int) async throws -> WatchProviders {
    try await callEndpoint(routable: Router.watchProviders(id: id))
  }

  // Meta endpoints

  public func latest(language: String? = nil) async throws -> TvShow {
    try await callEndpoint(routable: Router.latest(language: language))
  }

  public func popular(page: Int = 1, language: String? = nil, region _: String? = nil) async throws -> ResultPage<TvListResult> {
    try await callEndpoint(routable: Router.popular(page: page, language: language))
  }

  public func popularSequence(language: String? = nil, region _: String? = nil) async -> PagedQuerySequence<TvListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.popular(page: 1, language: language))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func airingToday(page: Int = 1, language: String? = nil, region _: String? = nil) async throws -> ResultPage<TvListResult> {
    try await callEndpoint(routable: Router.airingToday(page: page, language: language))
  }

  public func airingTodaySequence(language: String? = nil, region _: String? = nil) async -> PagedQuerySequence<TvListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.airingToday(page: 1, language: language))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func onTheAir(page: Int = 1, language: String? = nil, region _: String? = nil) async throws -> ResultPage<TvListResult> {
    try await callEndpoint(routable: Router.onTheAir(page: page, language: language))
  }

  public func onTheAirSequence(language: String? = nil, region _: String? = nil) async -> PagedQuerySequence<TvListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.onTheAir(page: 1, language: language))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func topRated(page: Int = 1, language: String? = nil, region _: String? = nil) async throws -> ResultPage<TvListResult> {
    try await callEndpoint(routable: Router.topRated(page: page, language: language))
  }

  public func topRatedSequence(language: String? = nil, region _: String? = nil) async -> PagedQuerySequence<TvListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.topRated(page: 1, language: language))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }
}

extension TvService {
  public enum Appendable: String, CaseIterable {
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
    case episodeGroups(id: Int, language: String?)
    case externalIds(id: Int, language: String?)
    case images(id: Int, language: String?, imageLanguages: Set<String>?)
    case keywords(id: Int)
    case recommendations(id: Int, language: String?, page: Int?)
    case reviews(id: Int, language: String?, page: Int?)
    case screenedTheatrically(id: Int)
    case similar(id: Int, language: String?, page: Int?)
    case translations(id: Int)
    case videos(id: Int, language: String?, videoLanguages: Set<String>?)
    case watchProviders(id: Int)

    case latest(language: String?)
    case airingToday(page: Int?, language: String?)
    case onTheAir(page: Int?, language: String?)
    case popular(page: Int?, language: String?)
    case topRated(page: Int?, language: String?)

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
        let dateFormat: Date.ISO8601FormatStyle = WrapParty.tmdbDefaultDateFormat
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
      case let .episodeGroups(id, language):
        return componentsForRoute(path: "tv/\(id)/episode_groups", queryItems: [
          "language": language,
        ]).url!
      case let .externalIds(id, language):
        return componentsForRoute(path: "tv/\(id)/external_ids", queryItems: [
          "language": language,
        ]).url!
      case let .images(id, language, imageLanguages):
        return componentsForRoute(path: "tv/\(id)/images", queryItems: [
          "language": language,
          "include_image_language": imageLanguages?.joined(separator: ","),
        ]).url!
      case let .keywords(id):
        return componentsForRoute(path: "tv/\(id)/keywords").url!
      case let .recommendations(id, language, page):
        return componentsForRoute(path: "tv/\(id)/recommendations", queryItems: [
          "language": language,
          "page": page.map { String($0) },
        ]).url!
      case let .reviews(id, language, page):
        return componentsForRoute(path: "tv/\(id)/reviews", queryItems: [
          "language": language,
          "page": page.map { String($0) },
        ]).url!
      case let .screenedTheatrically(id):
        return componentsForRoute(path: "tv/\(id)/screened_theatrically").url!
      case let .similar(id, language, page):
        return componentsForRoute(path: "tv/\(id)/similar", queryItems: [
          "language": language,
          "page": page.map { String($0) },
        ]).url!
      case let .translations(id):
        return componentsForRoute(path: "tv/\(id)/translations").url!
      case let .videos(id, language, videoLanguages):
        return componentsForRoute(path: "tv/\(id)/videos", queryItems: [
          "language": language,
          "include_video_language": videoLanguages?.joined(separator: ","),
        ]).url!
      case let .watchProviders(id):
        return componentsForRoute(path: "tv/\(id)/watch/providers").url!
      case let .latest(language):
        return componentsForRoute(path: "tv/latest", queryItems: [
          "language": language,
        ]).url!
      case let .airingToday(page, language):
        return componentsForRoute(path: "tv/airing_today", queryItems: [
          "page": page.map { String($0) },
          "language": language,
        ]).url!
      case let .onTheAir(page, language):
        return componentsForRoute(path: "tv/on_the_air", queryItems: [
          "page": page.map { String($0) },
          "language": language,
        ]).url!
      case let .popular(page, language):
        return componentsForRoute(path: "tv/popular", queryItems: [
          "page": page.map { String($0) },
          "language": language,
        ]).url!
      case let .topRated(page, language):
        return componentsForRoute(path: "tv/top_rated", queryItems: [
          "page": page.map { String($0) },
          "language": language,
        ]).url!
      }
    }
  }
}
