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

final class TvEpisodeGroupServiceTests: XCTestCase {
  // MARK: Internal

  static let originStoriesGroupId = "61c91097647654008fd495d5"

  func testGetDetails() async throws {
    let details = try await Self.service.details(for: Self.originStoriesGroupId)

    XCTAssertNotNil(details.groups)
    XCTAssertFalse(details.groups!.isEmpty)
  }

  // MARK: Private

  private static let service: TvEpisodeGroupService = {
    let config = DefaultConfiguration()
    return TvEpisodeGroupService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
