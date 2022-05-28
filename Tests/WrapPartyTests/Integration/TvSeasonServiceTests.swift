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
import XCTest

@testable import WrapParty

final class TvSeasonServiceIntegrationTests: XCTestCase {
  // MARK: Internal

  static let wotId = 71914
  static let wotSeasonOneId = 88733

  func testGetSeasonDetails() async throws {
    let season = try await Self.service.details(forShow: Self.wotId, forSeason: 1)

    XCTAssertTrue(season.seasonNumber == 1)
  }

  func testGetAggregateCredits() async throws {
    let credits = try await Self.service.aggregateCredits(forShow: Self.wotId, forSeason: 1)

    XCTAssertFalse(credits.crew.isEmpty)
  }

  func testGetChanges() async throws {
    let changes = try await Self.service.changes(forSeasonId: Self.wotSeasonOneId)

    XCTAssertNotNil(changes)
  }

  func testGetCredits() async throws {
    let credits = try await Self.service.credits(forShow: Self.wotId, forSeason: 1)

    XCTAssertFalse(credits.cast.isEmpty)
  }

  func testGetExternalIds() async throws {
    let externalIds = try await Self.service.externalIds(forShow: Self.wotId, forSeason: 1)

    XCTAssertNotNil(externalIds.tvdbId)
  }

  func testGetImages() async throws {
    let images = try await Self.service.images(forShow: Self.wotId, forSeason: 1)

    XCTAssertFalse(images.posters.isEmpty)
  }

  func testGetTranslations() async throws {
    let translations = try await Self.service.translations(forShow: Self.wotId, forSeason: 1)

    XCTAssertFalse(translations.translations.isEmpty)
  }

  func testGetVideos() async throws {
    let videos = try await Self.service.videos(forShow: Self.wotId, forSeason: 1)

    XCTAssert(videos.id == Self.wotSeasonOneId)
  }

  func testAppendable() async throws {
    let tvSeason = try await Self.service.details(forShow: Self.wotId, forSeason: 1, including: Set(TvSeasonService.Appendable.allCases))

    XCTAssertNotNil(tvSeason.aggregateCredits)
    XCTAssertNotNil(tvSeason.credits)
    XCTAssertNotNil(tvSeason.externalIds)
    XCTAssertNotNil(tvSeason.images)
    XCTAssertNotNil(tvSeason.translations)
    XCTAssertNotNil(tvSeason.videos)
  }

  // MARK: Private

  private static let service: TvSeasonService = {
    let config = DefaultConfiguration()
    return TvSeasonService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
