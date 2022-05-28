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

final class FindServiceIntegrationTests: XCTestCase {
  // MARK: Internal

  static let wotEpisodeOneTvdbId = 7_062_009
  static let wotSeasonOneTvdbId = 800_200
  static let pulpFictionImdbId = "tt0110912"

  func testFindImdbMovie() async throws {
    let results = try await Self.service.find(externalId: Self.pulpFictionImdbId, externalSource: .imdb)

    XCTAssertFalse(results.movieResults.isEmpty)
    XCTAssertNotNil(results.movieResults.first { $0.originalTitle == "Pulp Fiction" })
  }

  func testFindTvdbEpisode() async throws {
    let results = try await Self.service.find(externalId: String(Self.wotEpisodeOneTvdbId), externalSource: .tvdb)

    XCTAssertFalse(results.tvEpisodeResults.isEmpty)
    XCTAssertNotNil(results.tvEpisodeResults.first { $0.showId == 71914 && $0.name == "Leavetaking" })
  }

  func testFindTvdbSeason() async throws {
    let results = try await Self.service.find(externalId: String(Self.wotSeasonOneTvdbId), externalSource: .tvdb)

    XCTAssertFalse(results.tvSeasonResults.isEmpty)
    XCTAssertNotNil(results.tvSeasonResults.first { $0.showId == 71914 && $0.name == "Season 1" })
  }

  // MARK: Private

  private static let service: FindService = {
    let config = DefaultConfiguration()
    return FindService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
