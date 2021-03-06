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
  static let tomHollandTmdbId = 1_136_406

  func testGetChanges() async throws {
    let changes = try await Self.service.changes(for: Self.georgeLucasTmdbId)

    XCTAssertNotNil(changes)
  }

  func testGetCredits() async throws {
    let allCredits = try await Self.service.combinedCredits(for: Self.georgeLucasTmdbId)
    let movieCredits = try await Self.service.movieCredits(for: Self.georgeLucasTmdbId)
    let tvCredits = try await Self.service.tvCredits(for: Self.georgeLucasTmdbId)

    let obiWanKenobiTvShowTmdbId = 92830
    let empireStrikesBackMovieTmdbId = 1891

    XCTAssertNotNil(movieCredits.crew.first(where: { $0.id == empireStrikesBackMovieTmdbId }))
    XCTAssertNotNil(tvCredits.crew.first(where: { $0.id == obiWanKenobiTvShowTmdbId }))
    XCTAssertNotNil(allCredits.crew.first(where: { combinedCredit in
      if case let .movie(credit) = combinedCredit, credit.id == empireStrikesBackMovieTmdbId { return true }
      return false
    }))
    XCTAssertNotNil(allCredits.crew.first(where: { combinedCredit in
      if case let .tv(credit) = combinedCredit, credit.id == obiWanKenobiTvShowTmdbId { return true }
      return false
    }))
  }

  func testGetDetails() async throws {
    let person = try await Self.service.details(for: Self.georgeLucasTmdbId)

    XCTAssertEqual(person.id, Self.georgeLucasTmdbId)
    XCTAssertEqual(person.birthday, "1944-05-14")
  }

  func testGetExternalIds() async throws {
    let externalIds = try await Self.service.externalIds(for: Self.georgeLucasTmdbId)

    XCTAssertEqual(externalIds.imdbId, "nm0000184")
  }

  func testGetImages() async throws {
    let images = try await Self.service.images(for: Self.georgeLucasTmdbId)

    XCTAssertFalse(images.profiles.isEmpty)
  }

  func testGetTaggedImages() async throws {
    let taggedImages = try await Self.service.taggedImages(for: Self.tomHollandTmdbId)

    XCTAssertFalse(taggedImages.results.isEmpty)
  }

  func testGetTranslations() async throws {
    let translations = try await Self.service.translations(for: Self.georgeLucasTmdbId)
    let knownTranslationsIso639: Set<String> = ["en", "de", "ru"]
    let foundTranslations = Set(translations.translations.map(\.iso639_1))

    for iso639 in knownTranslationsIso639 {
      XCTAssertTrue(foundTranslations.contains(iso639))
    }
  }

  func testGetLatest() async throws {
    let latest = try await Self.service.latest()

    XCTAssertNotNil(latest)
  }

//  func testGetAllPopular() async throws {
//    let allPopular = try await Self.service.allPopular()
//
//    XCTAssertFalse(allPopular.isEmpty)
//  }

  func testGetPopular() async throws {
    let popular = try await Self.service.popular()

    XCTAssertFalse(popular.results.isEmpty)
  }

  func testAppending() async throws {
    let person = try await Self.service.details(for: Self.georgeLucasTmdbId, including: Set(PersonService.Appendable.allCases))

    XCTAssertNotNil(person.changes)
    XCTAssertNotNil(person.combinedCredits)
    XCTAssertNotNil(person.externalIds)
    XCTAssertNotNil(person.images)
    XCTAssertNotNil(person.movieCredits)
    XCTAssertNotNil(person.taggedImages)
    XCTAssertNotNil(person.translations)
    XCTAssertNotNil(person.tvCredits)
  }

  // MARK: Private

  private static let service: PersonService = {
    let config = DefaultConfiguration()
    return PersonService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
