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
import Logging

// MARK: - CollectionServiceProviding

protocol CollectionServiceProviding: ServiceProviding {}

// MARK: - CollectionService

struct CollectionService: SearchServiceProviding {
  // MARK: Lifecycle

  init(dataLoader: DataLoading, logger: Logger, tokenManager: TokenManager) {
    self.dataLoader = dataLoader
    self.logger = logger
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  let dataLoader: DataLoading
  let logger: Logger
  let tokenManager: TokenManager

  func collection(id: Int, language: String? = nil) async throws -> CollectionDetails {
    try await callEndpoint(routable: Router.collection(id: id, language: language))
  }

  func images(id: Int, language: String? = nil) async throws -> CollectionImages {
    try await callEndpoint(routable: Router.images(id: id, language: language))
  }

  func translations(id: Int, language: String? = nil) async throws -> CollectionTranslations {
    try await callEndpoint(routable: Router.translations(id: id, language: language))
  }
}

extension CollectionService {
  enum Router: RequestRoutable {
    case collection(id: Int, language: String?)
    case images(id: Int, language: String?)
    case translations(id: Int, language: String?)

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .collection(id, language):
        return componentsForRoute(path: "collection/\(id)", queryItems: [
          "language": language,
        ]).url!
      case let .images(id, language):
        return componentsForRoute(path: "collection/\(id)/images", queryItems: [
          "language": language,
        ]).url!
      case let .translations(id, language):
        return componentsForRoute(path: "collection/\(id)/translations", queryItems: [
          "language": language,
        ]).url!
      }
    }
  }
}
