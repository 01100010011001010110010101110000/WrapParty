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

  func testGetAlternativeTitles() async throws {
    let movieId = 680
    let titles = try await Self.service.alternativeTitles(for: 680)

    XCTAssertNotNil(titles.id)
    XCTAssertGreaterThan(titles.titles.count, 0)
  }

  func testGetDetails() async throws {
    let movieId = 680
    let movie = try await Self.service.details(for: movieId)

    XCTAssertTrue(movie.id == movieId)
  }

  func testGetChanges() async throws {
    let movieId = 680
    let changes = try? await Self.service.changes(for: movieId)

    XCTAssertNotNil(changes)
  }

  func testAppending() async throws {
    let movieId = 680
    let movie = try await Self.service.details(for: movieId, including: [.alternativeTitles, .changes, .images, .videos])

    // Alternative Titles
    XCTAssertNotNil(movie.alternativeTitles)
    XCTAssertNil(movie.alternativeTitles?.id)

    // Changes
    XCTAssertNotNil(movie.changes)

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
