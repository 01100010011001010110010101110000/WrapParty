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

final class ConfigurationServiceIntegrationTests: XCTestCase {
  // MARK: Internal

  func testGetConfiguration() async throws {
    let configuration = try await Self.service.configuration()

    XCTAssertFalse(configuration.changeKeys.isEmpty)
  }

  func testGetCountries() async throws {
    let countries = try await Self.service.countries()

    XCTAssertFalse(countries.isEmpty)
    XCTAssertNotNil(countries.first { $0.iso3166_1 == "US" })
  }

  func testGetJobs() async throws {
    let jobs = try await Self.service.jobs()

    XCTAssertFalse(jobs.isEmpty)
    XCTAssertNotNil(jobs.first { $0.department == "Lighting" })
  }

  func testGetLanguages() async throws {
    let languages = try await Self.service.languages()

    XCTAssertFalse(languages.isEmpty)
    XCTAssertNotNil(languages.first { $0.iso639_1 == "en" })
  }

  func testGetPrimaryTranslations() async throws {
    let primaryTranslations = try await Self.service.primaryTranslations()

    XCTAssertFalse(primaryTranslations.isEmpty)
    XCTAssertTrue(primaryTranslations.contains("en-US"))
  }

  func testGetTimezones() async throws {
    let timezones = try await Self.service.timezones()

    XCTAssertFalse(timezones.isEmpty)
    XCTAssertNotNil(timezones.first { $0.iso3166_1 == "US" })
  }

  // MARK: Private

  private static let service: ConfigurationService = {
    let config = DefaultConfiguration()
    return ConfigurationService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
