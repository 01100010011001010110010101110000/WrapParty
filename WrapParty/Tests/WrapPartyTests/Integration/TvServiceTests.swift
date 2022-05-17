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

@testable import WrapParty

import Foundation
import XCTest

final class TvServiceIntegrationTests: XCTestCase {
  // MARK: Internal

  /// TMDB ID for the Wheel of Time series
  static let wotId = 71914
  static let wotImdbId = "tt7462410"
  static let metalFamilyId = 123_566

  func testGetAggregateCredits() async throws {
    let credits = try await Self.service.aggregateCredits(for: Self.wotId)

    XCTAssertFalse(credits.cast.isEmpty)
    XCTAssertFalse(credits.crew.isEmpty)
  }

  func testGetAlternativeTitles() async throws {
    let alternativeTitles = try await Self.service.alternativeTitles(for: Self.wotId)

    XCTAssertFalse(alternativeTitles.results.isEmpty)
  }

  func testGetChanges() async throws {
    let changes = try? await Self.service.changes(for: Self.wotId)

    XCTAssertNotNil(changes)
  }

  func testGetContentRatings() async throws {
    let ratings = try await Self.service.contentRatings(for: Self.wotId)

    XCTAssertFalse(ratings.results.isEmpty)
  }

  func testGetCredits() async throws {
    let credits = try await Self.service.credits(for: Self.wotId)

    XCTAssertFalse(credits.cast.isEmpty)
    XCTAssertFalse(credits.crew.isEmpty)
  }

  func testGetDetails() async throws {
    let details = try await Self.service.details(for: Self.wotId)

    XCTAssertTrue(details.id == Self.wotId)
  }

  func testGetEpisodeGroups() async throws {
    let episodeGroups = try await Self.service.episodeGroups(for: Self.wotId)

    XCTAssertTrue(episodeGroups.id == Self.wotId)
    XCTAssertFalse(episodeGroups.results.isEmpty)
  }

  func testGetExternalIds() async throws {
    let externalIds = try await Self.service.externalIds(for: Self.wotId)

    XCTAssertTrue(externalIds.imdbId == "tt7462410")
    XCTAssertTrue(externalIds.tvdbId == 355_730)
  }

  func testGetImages() async throws {
    let images = try await Self.service.images(for: Self.wotId)

    XCTAssertFalse(images.posters.isEmpty)
    XCTAssertFalse(images.logos.isEmpty)
    XCTAssertFalse(images.backdrops.isEmpty)
  }

  func testGetKeywords() async throws {
    let keywords = try await Self.service.keywords(for: Self.wotId)

    XCTAssertFalse(keywords.results.isEmpty)
  }

  func testGetRecommendations() async throws {
    let recommendations = try await Self.service.recommendations(for: Self.wotId)

    XCTAssertFalse(recommendations.results.isEmpty)
  }

  func testGetReviews() async throws {
    let reviews = try await Self.service.reviews(for: Self.wotId)

    XCTAssertFalse(reviews.results.isEmpty)
  }

  func testGetTheatricallyScreenedEpisodes() async throws {
    let episodes = try await Self.service.episodesScreenedTheatrically(for: Self.metalFamilyId)

    XCTAssertFalse(episodes.results.isEmpty)
  }

  func testGetSimilarShows() async throws {
    let similarShows = try await Self.service.similarTvShows(for: Self.wotId)

    XCTAssertFalse(similarShows.results.isEmpty)
  }

  func testGetTranslations() async throws {
    let translations = try await Self.service.translations(for: Self.wotId)

    XCTAssertFalse(translations.translations.isEmpty)
  }

  func testGetVideos() async throws {
    let videos = try await Self.service.videos(for: Self.wotId)

    XCTAssertFalse(videos.results.isEmpty)
  }

  func testGetWatchProviders() async throws {
    let providers = try await Self.service.watchProviders(for: Self.wotId)

    XCTAssertFalse(providers.results.isEmpty)
  }

  func testGetLatest() async throws {
    let latest = try await Self.service.latest()

    XCTAssertGreaterThan(latest.id, 0)
  }

  func testGetPopular() async throws {
    let popular = try await Self.service.popular()

    XCTAssertFalse(popular.results.isEmpty)
  }

  func testGetAiringToday() async throws {
    let airingToday = try await Self.service.airingToday()

    XCTAssertFalse(airingToday.results.isEmpty)
  }

  func testGetOnTheAir() async throws {
    let onTheAir = try await Self.service.onTheAir()

    XCTAssertFalse(onTheAir.results.isEmpty)
  }

  func testGetTopRated() async throws {
    let topRated = try await Self.service.topRated()

    XCTAssertFalse(topRated.results.isEmpty)
  }

  func testAppending() async throws {
    let tvShow = try await Self.service.details(for: Self.wotId,
                                                including: Set(TvService.Appendable.allCases))

    // Alternative Titles
    XCTAssertNotNil(tvShow.aggregateCredits)
    XCTAssertNil(tvShow.aggregateCredits?.id)

    XCTAssertNotNil(tvShow.alternativeTitles)
    XCTAssertNil(tvShow.alternativeTitles?.id)

    // Changes
    XCTAssertNotNil(tvShow.changes)

    // Content ratings
    XCTAssertNotNil(tvShow.contentRatings)
    XCTAssertNil(tvShow.contentRatings?.id)

    // Credits
    XCTAssertNotNil(tvShow.credits)

    // Episode groups
    XCTAssertNotNil(tvShow.episodeGroups)
    XCTAssertNil(tvShow.episodeGroups?.id)

    // External IDs
    XCTAssertNotNil(tvShow.externalIds)
    XCTAssertEqual(tvShow.externalIds?.imdbId, Self.wotImdbId)

    // Images
    XCTAssertNotNil(tvShow.images)
    XCTAssertNil(tvShow.images?.id)

    // Keywords
    XCTAssertNotNil(tvShow.keywords?.results)

    // Recommendations
    XCTAssertNotNil(tvShow.recommendations)
    XCTAssertFalse(tvShow.recommendations?.results.isEmpty ?? true)

    // Reviews
    XCTAssertNotNil(tvShow.reviews)
    XCTAssertFalse(tvShow.reviews?.results.isEmpty ?? true)

    // Screened theatrically
    XCTAssertNotNil(tvShow.screenedTheatrically)

    // Similar movies
    XCTAssertNotNil(tvShow.similar)
    XCTAssertFalse(tvShow.similar?.results.isEmpty ?? true)

    // Translations
    XCTAssertNotNil(tvShow.translations)
    XCTAssertFalse(tvShow.translations?.translations.isEmpty ?? true)

    // Videos
    XCTAssertNotNil(tvShow.videos)
    XCTAssertNil(tvShow.videos?.id)

    // Watch providers

    XCTAssertNotNil(tvShow.watchProviders)
    XCTAssertFalse(tvShow.watchProviders?.results.isEmpty ?? true)
  }

  // MARK: Private

  private static let service: TvService = {
    let config = DefaultConfiguration()
    return TvService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
