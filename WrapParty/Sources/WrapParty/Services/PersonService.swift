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

// MARK: - PersonServiceProviding

protocol PersonServiceProviding: ServiceProviding {}

// MARK: - PersonService

struct PersonService: PersonServiceProviding {
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

  func changes(for id: Int, startDate: Date? = nil, endDate: Date? = nil, page: Int? = nil) async throws -> MediaChanges {
    try await callEndpoint(routable: Router.changes(id: id, startDate: startDate, endDate: endDate, page: page))
  }

  func details(for id: Int, including: Set<Appendable> = []) async throws -> Person {
    try await callEndpoint(routable: Router.details(id: id, appending: including, language: nil, page: nil))
  }

  func details(for id: Int, including: Set<Appendable> = [], language: String? = nil, page: Int? = nil) async throws -> Person {
    try await callEndpoint(routable: Router.details(id: id, appending: including, language: language, page: page))
  }
}

extension PersonService {
  enum Appendable: String, CaseIterable {
    case changes
  }
}

extension PersonService {
  enum Router: RequestRoutable {
    case changes(id: Int, startDate: Date?, endDate: Date?, page: Int?)
    case details(id: Int, appending: Set<Appendable>, language: String?, page: Int?)

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .changes(id, startDate, endDate, page):
        let dateFormat: Date.ISO8601FormatStyle = .iso8601.year().month().day()
        return componentsForRoute(path: "person/\(id)/changes", queryItems: [
          "start_date": startDate?.formatted(dateFormat),
          "end_date": endDate?.formatted(dateFormat),
          "page": page.map { String($0) },
        ]).url!
      case let .details(id, appending, language, page):
        return componentsForRoute(path: "person/\(id)", queryItems: [
          "append_to_response": appending.map(\.rawValue).joined(separator: ","),
          "language": language,
          "page": page.map { String($0) },
        ]).url!
      }
    }
  }
}
