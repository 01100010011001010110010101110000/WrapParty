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

  func testGetAggregateCredits() async throws {
    let credits = try await Self.service.aggregateCredits(for: Self.wotId)

    XCTAssertFalse(credits.cast.isEmpty)
    XCTAssertFalse(credits.crew.isEmpty)
  }

  func testGetAlternativeTitles() async throws {
    let alternativeTitles = try await Self.service.alternativeTitles(for: Self.wotId)

    XCTAssertFalse(alternativeTitles.results.isEmpty)
  }

  func testGetDetails() async throws {
    let details = try await Self.service.details(for: Self.wotId)

    XCTAssertTrue(details.id == Self.wotId)
  }

  // MARK: Private

  private static let service: TvService = {
    let config = DefaultConfiguration()
    return TvService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
