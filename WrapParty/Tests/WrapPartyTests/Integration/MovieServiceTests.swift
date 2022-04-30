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

final class MoviceServiceIntegrationTests: XCTestCase {
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

    XCTAssertTrue(movie.id == Self.pulpFictionTmdbId)
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

    // Videos
    XCTAssertNotNil(movie.videos)
    XCTAssertNil(movie.videos?.id)
  }

  // MARK: Private

  private static let service: MovieService = {
    let config = DefaultConfiguration()
    return MovieService(dataLoader: config.loader, tokenManager: TokenManager(token: config.apiToken))
  }()
}
