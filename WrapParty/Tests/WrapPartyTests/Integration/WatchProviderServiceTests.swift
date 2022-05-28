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

final class WatchProviderServiceTests: XCTestCase {
  // MARK: Internal

  func testGetRegions() async throws {
    let regions = try await Self.service.regions()

    XCTAssertFalse(regions.isEmpty)
  }

  func testGetMovieWatchProviders() async throws {
    let providers = try await Self.service.movieProviders()

    XCTAssertFalse(providers.isEmpty)
  }

  func testGetTvWatchProviders() async throws {
    let providers = try await Self.service.tvProviders()

    XCTAssertFalse(providers.isEmpty)
  }

  // MARK: Private

  private static let service: WatchProviderService = {
    let config = DefaultConfiguration()
    return WatchProviderService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
