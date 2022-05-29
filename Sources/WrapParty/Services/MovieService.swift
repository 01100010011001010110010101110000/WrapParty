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

// MARK: - MovieServiceProviding

protocol MovieServiceProviding: ServiceProviding & DetailAppendable {
  func details(for id: Int, including: Set<Appendable>, language: String?, imageLanguages: Set<String>?, page: Int?) async throws -> Movie
}

// MARK: - MovieService

public struct MovieService: MovieServiceProviding {
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

  public func alternativeTitles(for id: Int, inCountry code: String? = nil) async throws -> MovieAlternativeTitles {
    try await callEndpoint(routable: Router.alternativeTitles(id: id, countryCode: code))
  }

  public func changes(for id: Int, startDate: Date? = nil, endDate: Date? = nil, page: Int? = nil) async throws -> MediaChanges {
    try await callEndpoint(routable: Router.changes(id: id, startDate: startDate, endDate: endDate, page: page))
  }

  public func credits(for id: Int, language: String? = nil) async throws -> MediaCredits {
    try await callEndpoint(routable: Router.credits(id: id, language: language))
  }

  public func externalIds(for id: Int) async throws -> ExternalIds {
    try await callEndpoint(routable: Router.externalIds(id: id))
  }

  public func details(for id: Int, including: Set<Appendable> = [], language: String? = nil, imageLanguages: Set<String>? = [], page: Int? = nil) async throws -> Movie {
    try await callEndpoint(routable: Router.details(id: id, appending: including, language: language, imageLanguages: imageLanguages, page: page))
  }

  public func details(for id: Int, including: Set<Appendable> = []) async throws -> Movie {
    try await details(for: id, including: including, language: nil)
  }

  public func keywords(for id: Int) async throws -> MovieKeywords {
    try await callEndpoint(routable: Router.keywords(id: id))
  }

  public func images(for id: Int, language: String? = nil, imageLanguages: Set<String>? = []) async throws -> MediaImages {
    try await callEndpoint(routable: Router.images(id: id, language: language, imageLanguages: imageLanguages))
  }

  public func lists(for id: Int, page: Int = 1, language: String? = nil) async throws -> ResultPage<MovieList> {
    try await callEndpoint(routable: Router.lists(id: id, language: language, page: page))
  }

  public func allLists(for id: Int, language: String? = nil) async throws -> [MovieList] {
    try await listSequence(for: id, language: language).allResults()
  }

  public func listSequence(for id: Int, language: String? = nil) async -> PagedQuerySequence<MovieList> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.lists(id: id, language: language, page: 1))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func recommendations(for id: Int, page: Int = 1, language: String? = nil) async throws -> ResultPage<MovieListResult> {
    try await callEndpoint(routable: Router.recommendations(id: id, language: language, page: page))
  }

  public func allRecommendations(for id: Int, language: String? = nil) async throws -> [MovieListResult] {
    try await recommendationSequence(for: id, language: language).allResults()
  }

  public func recommendationSequence(for id: Int, language: String? = nil) async -> PagedQuerySequence<MovieListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.recommendations(id: id, language: language, page: 1))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func releaseDates(for id: Int) async throws -> Results<CountryRelease> {
    try await callEndpoint(routable: Router.releaseDates(id: id))
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

  public func similarMovies(for id: Int, page: Int = 1, language: String? = nil) async throws -> ResultPage<MovieListResult> {
    try await callEndpoint(routable: Router.similar(id: id, language: language, page: page))
  }

  public func allSimilarMovies(for id: Int, language: String? = nil) async throws -> [MovieListResult] {
    try await similarMovieSequence(for: id, language: language).allResults()
  }

  public func similarMovieSequence(for id: Int, language: String? = nil) async -> PagedQuerySequence<MovieListResult> {
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

  public func latest(language: String? = nil) async throws -> Movie {
    try await callEndpoint(routable: Router.latest(language: language))
  }

  public func nowPlaying(page: Int = 1, language: String? = nil, region: String? = nil) async throws -> ResultPage<Movie> {
    try await callEndpoint(routable: Router.nowPlaying(page: page, language: language, region: region))
  }

  public func nowPlayingSequence(language: String? = nil, region: String? = nil) async -> PagedQuerySequence<Movie> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.nowPlaying(page: 1, language: language, region: region))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func popular(page: Int = 1, language: String? = nil, region: String? = nil) async throws -> ResultPage<Movie> {
    try await callEndpoint(routable: Router.popular(page: page, language: language, region: region))
  }

  public func popularSequence(language: String? = nil, region: String? = nil) async -> PagedQuerySequence<Movie> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.popular(page: 1, language: language, region: region))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func topRated(page: Int = 1, language: String? = nil, region: String? = nil) async throws -> ResultPage<Movie> {
    try await callEndpoint(routable: Router.topRated(page: page, language: language, region: region))
  }

  public func topRatedSequence(language: String? = nil, region: String? = nil) async -> PagedQuerySequence<Movie> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.topRated(page: 1, language: language, region: region))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func upcoming(page: Int = 1, language: String? = nil, region: String? = nil) async throws -> ResultPage<Movie> {
    try await callEndpoint(routable: Router.upcoming(page: page, language: language, region: region))
  }

  public func upcomingSequence(language: String? = nil, region: String? = nil) async -> PagedQuerySequence<Movie> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.upcoming(page: 1, language: language, region: region))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }
}

extension MovieService {
  public enum Appendable: String, CaseIterable {
    case alternativeTitles = "alternative_titles"
    case changes
    case credits
    case externalIds = "external_ids"
    case images
    case keywords
    case lists
    case recommendations
    case releaseDates = "release_dates"
    case reviews
    case similar
    case translations
    case videos
    case watchProviders = "watch/providers"
  }
}

extension MovieService {
  enum Router: RequestRoutable {
    case alternativeTitles(id: Int, countryCode: String?)
    case changes(id: Int, startDate: Date?, endDate: Date?, page: Int?)
    case credits(id: Int, language: String?)
    case details(id: Int, appending: Set<Appendable>, language: String?, imageLanguages: Set<String>?, page: Int?)
    case externalIds(id: Int)
    case images(id: Int, language: String?, imageLanguages: Set<String>?)
    case keywords(id: Int)
    case lists(id: Int, language: String?, page: Int?)
    case recommendations(id: Int, language: String?, page: Int?)
    case releaseDates(id: Int)
    case reviews(id: Int, language: String?, page: Int?)
    case similar(id: Int, language: String?, page: Int?)
    case translations(id: Int)
    case videos(id: Int, language: String?, videoLanguages: Set<String>?)
    case watchProviders(id: Int)

    case latest(language: String?)
    case nowPlaying(page: Int?, language: String?, region: String?)
    case popular(page: Int?, language: String?, region: String?)
    case topRated(page: Int?, language: String?, region: String?)
    case upcoming(page: Int?, language: String?, region: String?)

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .alternativeTitles(id, countryCode):
        let components = componentsForRoute(path: "movie/\(id)/alternative_titles", queryItems: [
          "country": countryCode,
        ])
        return components.url!
      case let .changes(id, startDate, endDate, page):
        let dateFormat: Date.ISO8601FormatStyle = .iso8601.year().month().day()
        let components = componentsForRoute(path: "movie/\(id)/changes", queryItems: [
          "start_date": startDate?.formatted(dateFormat),
          "end_date": endDate?.formatted(dateFormat),
          "page": page.map { String($0) },
        ])
        return components.url!
      case let .credits(id, language):
        let components = componentsForRoute(path: "movie/\(id)/credits", queryItems: [
          "language": language,
        ])
        return components.url!
      case let .details(id, appending, language, imageLanguages, page):
        let components = componentsForRoute(path: "movie/\(id)", queryItems: [
          "append_to_response": appending.map(\.rawValue).joined(separator: ","),
          "language": language,
          "include_image_language": imageLanguages?.joined(separator: ","),
          "page": page.map { String($0) },
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
      case let .lists(id, language, page):
        return componentsForRoute(path: "movie/\(id)/lists", queryItems: [
          "language": language,
          "page": page.map { String($0) },
        ]).url!
      case let .recommendations(id, language, page):
        return componentsForRoute(path: "movie/\(id)/recommendations", queryItems: [
          "language": language,
          "page": page.map { String($0) },
        ]).url!
      case let .releaseDates(id):
        return componentsForRoute(path: "movie/\(id)/release_dates").url!
      case let .reviews(id, language, page):
        return componentsForRoute(path: "movie/\(id)/reviews", queryItems: [
          "language": language,
          "page": page.map { String($0) },
        ]).url!
      case let .similar(id, language, page):
        return componentsForRoute(path: "movie/\(id)/similar", queryItems: [
          "language": language,
          "page": page.map { String($0) },
        ]).url!
      case let .translations(id):
        return componentsForRoute(path: "movie/\(id)/translations").url!
      case let .videos(id, language, videoLanguages):
        return componentsForRoute(path: "movie/\(id)/videos", queryItems: [
          "language": language,
          "include_video_language": videoLanguages?.joined(separator: ","),
        ]).url!
      case let .watchProviders(id):
        return componentsForRoute(path: "movie/\(id)/watch/providers").url!
      case let .latest(language):
        return componentsForRoute(path: "movie/latest", queryItems: [
          "language": language,
        ]).url!
      case let .nowPlaying(page, language, region):
        return componentsForRoute(path: "movie/now_playing", queryItems: [
          "page": page.map { String($0) },
          "language": language,
          "region": region,
        ]).url!
      case let .popular(page, language, region):
        return componentsForRoute(path: "movie/popular", queryItems: [
          "page": page.map { String($0) },
          "language": language,
          "region": region,
        ]).url!
      case let .topRated(page, language, region):
        return componentsForRoute(path: "movie/top_rated", queryItems: [
          "page": page.map { String($0) },
          "language": language,
          "region": region,
        ]).url!
      case let .upcoming(page, language, region):
        return componentsForRoute(path: "movie/upcoming", queryItems: [
          "page": page.map { String($0) },
          "language": language,
          "region": region,
        ]).url!
      }
    }
  }
}
