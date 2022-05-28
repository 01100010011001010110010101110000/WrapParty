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

import Foundation

final class DiscoveryServiceIntegrationTests: XCTestCase {
  // MARK: Internal

  func testDiscoverMovie() async throws {
    let resultPage = try await Self.service.discoverMovie()

    XCTAssertFalse(resultPage.results.isEmpty)
  }

  func testDiscoverTv() async throws {
    let resultPage = try await Self.service.discoverTv()

    XCTAssertFalse(resultPage.results.isEmpty)
  }

  // MARK: Private

  private static let service: DiscoveryService = {
    let config = DefaultConfiguration()
    return DiscoveryService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
