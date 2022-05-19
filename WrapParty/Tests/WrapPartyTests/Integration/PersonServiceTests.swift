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

final class PersonServiceIntegrationTests: XCTestCase {
  // MARK: Internal

  static let georgeLucasTmdbId = 1
  static let georgeLucasImdbId = "nm0000184"

  func testGetChanges() async throws {
    let changes = try await Self.service.changes(for: Self.georgeLucasTmdbId)

    XCTAssertNotNil(changes)
  }

  func testGetDetails() async throws {
    let person = try await Self.service.details(for: Self.georgeLucasTmdbId)

    XCTAssertTrue(person.id == Self.georgeLucasTmdbId)
    XCTAssertTrue(person.birthday == "1944-05-14")
  }

  // MARK: Private

  private static let service: PersonService = {
    let config = DefaultConfiguration()
    return PersonService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
