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

final class CollectionServiceIntegrationTests: XCTestCase {
  // MARK: Internal

  static let collectionId = 247_559

  func testGetCollection() async throws {
    let collection = try await Self.service.collection(id: Self.collectionId)

    XCTAssertEqual(collection.id, Self.collectionId)
  }

  func testGetCollectionImages() async throws {
    let images = try await Self.service.images(id: Self.collectionId)

    XCTAssertEqual(images.id, Self.collectionId)
  }

  func testGetCollectionTranslations() async throws {
    let translations = try await Self.service.translations(id: Self.collectionId)

    XCTAssertEqual(translations.id, Self.collectionId)
  }

  // MARK: Private

  private static let service: CollectionService = {
    let config = DefaultConfiguration()
    return CollectionService(dataLoader: config.loader, logger: config.logger, tokenManager: TokenManager(token: config.apiToken))
  }()
}
