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

final class CreditServiceIntegrationTests: XCTestCase {
  // MARK: Internal

  static let creditId = "5dcd747db76cbb001174c0a3"

  func testGetReview() async throws {
    let credit = try await Self.service.credit(id: Self.creditId)

    XCTAssertEqual(credit.id, Self.creditId)
    XCTAssertEqual(credit.person.id, 1_993_042)
    XCTAssertEqual(credit.mediaType, MediaType.tv)
  }

  // MARK: Private

  private static let service: CreditService = {
    let config = DefaultConfiguration()
    return CreditService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
