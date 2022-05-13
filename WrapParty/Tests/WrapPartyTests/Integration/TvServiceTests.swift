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

  // MARK: Private

  private static let service: TvService = {
    let config = DefaultConfiguration()
    return TvService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
