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
import XCTest

final class MovieServiceIntegrationTests: XCTestCase {
  // MARK: Internal

  static let pulpFictionTmdbId = 680
  static let pulpFictionImdbId = "tt0110912"

  func testGetAlternativeTitles() async throws {
    let titles = try await Self.service.alternativeTitles(for: Self.pulpFictionTmdbId)

    XCTAssertNotNil(titles.id)
    XCTAssertGreaterThan(titles.titles.count, 0)
  }

  func testGetDetails() async throws {
    let movie = try await Self.service.details(for: Self.pulpFictionTmdbId)

    XCTAssertEqual(movie.id, Self.pulpFictionTmdbId)
  }

  func testGetChanges() async throws {
    let changes = try? await Self.service.changes(for: Self.pulpFictionTmdbId)

    XCTAssertNotNil(changes)
  }

  func testGetCredits() async throws {
    let credits = try? await Self.service.credits(for: Self.pulpFictionTmdbId)

    XCTAssertNotNil(credits)
  }

  func testGetExternalIds() async throws {
    let externalIds = try await Self.service.externalIds(for: Self.pulpFictionTmdbId)

    XCTAssertEqual(externalIds.imdbId, Self.pulpFictionImdbId)
  }

  func testGetImages() async throws {
    let images = try await Self.service.images(for: Self.pulpFictionTmdbId)

    XCTAssertFalse(images.posters.isEmpty)
  }

  func testGetKeywords() async throws {
    let keywords = try await Self.service.keywords(for: Self.pulpFictionTmdbId)

    XCTAssertTrue(keywords.keywords.contains { $0.id == 2231 })
  }

  func testGetListPage() async throws {
    let page = try await Self.service.lists(for: Self.pulpFictionTmdbId, page: 2)

    XCTAssertEqual(page.page, 2)
    XCTAssertFalse(page.results.isEmpty)
  }

  // Disabling this to not hammer TMDB during testing.
  // TODO: - Develop a flag to conditionally run this test
//  func testGetAllLists() async throws {
//    let lists = try await Self.service.allLists(for: Self.pulpFictionTmdbId)
//
//    XCTAssertFalse(lists.isEmpty)
//  }

  func testGetAllRecommendations() async throws {
    let recommendations = try await Self.service.allRecommendations(for: Self.pulpFictionTmdbId)

    XCTAssertFalse(recommendations.isEmpty)
  }

  func testGetRecommendationPage() async throws {
    let page = try await Self.service.recommendations(for: Self.pulpFictionTmdbId, page: 2)

    XCTAssertEqual(page.page, 2)
    XCTAssertFalse(page.results.isEmpty)
  }

  func testGetReleaseDates() async throws {
    let releaseDates = try await Self.service.releaseDates(for: Self.pulpFictionTmdbId)

    XCTAssertFalse(releaseDates.results.isEmpty)
    XCTAssertTrue(releaseDates.results.contains { $0.iso3166_1 == "US" })
  }

  func testGetReviews() async throws {
    let reviews = try await Self.service.reviews(for: Self.pulpFictionTmdbId)

    XCTAssertFalse(reviews.results.isEmpty)
  }

  func testGetSimilar() async throws {
    let similar = try await Self.service.similarMovies(for: Self.pulpFictionTmdbId)

    XCTAssertFalse(similar.results.isEmpty)
  }

  func testGetTranslations() async throws {
    let translations = try await Self.service.translations(for: Self.pulpFictionTmdbId)

    XCTAssertFalse(translations.translations.isEmpty)
  }

  func testGetVideos() async throws {
    let videos = try await Self.service.videos(for: Self.pulpFictionTmdbId)

    XCTAssertFalse(videos.results.isEmpty)
  }

  func testGetWatchProviders() async throws {
    let providers = try await Self.service.watchProviders(for: Self.pulpFictionTmdbId)

    XCTAssertFalse(providers.results.isEmpty)
  }

  func testGetLatest() async throws {
    let latest = try await Self.service.latest()

    XCTAssertGreaterThan(latest.id, 0)
  }

  func testGetNowPlaying() async throws {
    let nowPlaying = try await Self.service.nowPlaying()

    XCTAssertFalse(nowPlaying.results.isEmpty)
  }

  func testGetPopular() async throws {
    let popular = try await Self.service.popular()

    XCTAssertFalse(popular.results.isEmpty)
  }

  func testGetTopRated() async throws {
    let topRated = try await Self.service.topRated()

    XCTAssertFalse(topRated.results.isEmpty)
  }

  func testGetUpcoming() async throws {
    let upcoming = try await Self.service.upcoming()

    XCTAssertFalse(upcoming.results.isEmpty)
  }

  func testAppending() async throws {
    let movie = try await Self.service.details(for: Self.pulpFictionTmdbId,
                                               including: Set(MovieService.Appendable.allCases))

    // Alternative Titles
    XCTAssertNotNil(movie.alternativeTitles)
    XCTAssertNil(movie.alternativeTitles?.id)

    // Changes
    XCTAssertNotNil(movie.changes)

    // Credits
    XCTAssertNotNil(movie.credits)

    // External IDs
    XCTAssertNotNil(movie.externalIds)
    XCTAssertEqual(movie.externalIds?.imdbId, Self.pulpFictionImdbId)

    // Images
    XCTAssertNotNil(movie.images)
    XCTAssertNil(movie.images?.id)

    // Keywords
    XCTAssertNotNil(movie.keywords?.keywords)

    // Recommendations
    XCTAssertNotNil(movie.recommendations)
    XCTAssertFalse(movie.recommendations?.results.isEmpty ?? true)

    // Release dates
    XCTAssertNotNil(movie.releaseDates)
    XCTAssertFalse(movie.releaseDates?.results.isEmpty ?? true)

    // Reviews
    XCTAssertNotNil(movie.reviews)
    XCTAssertFalse(movie.reviews?.results.isEmpty ?? true)

    // Similar movies
    XCTAssertNotNil(movie.similar)
    XCTAssertFalse(movie.similar?.results.isEmpty ?? true)

    // Translations
    XCTAssertNotNil(movie.translations)
    XCTAssertFalse(movie.translations?.translations.isEmpty ?? true)

    // Videos
    XCTAssertNotNil(movie.videos)
    XCTAssertNil(movie.videos?.id)

    // Watch providers

    XCTAssertNotNil(movie.watchProviders)
    XCTAssertFalse(movie.watchProviders?.results.isEmpty ?? true)
  }

  // MARK: Private

  private static let service: MovieService = {
    let config = DefaultConfiguration()
    return MovieService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
