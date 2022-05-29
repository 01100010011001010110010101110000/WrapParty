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

// MARK: - CreditServiceProviding

protocol CreditServiceProviding: ServiceProviding {}

// MARK: - CreditService

public struct CreditService: SearchServiceProviding {
  // MARK: Lifecycle

  public init(dataLoader: DataLoading, logger: Logger, tokenManager: TokenManager) {
    self.dataLoader = dataLoader
    self.logger = logger
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  public let dataLoader: DataLoading
  public let logger: Logger
  public let tokenManager: TokenManager

  public func credit(id: String) async throws -> CreditDetails {
    try await callEndpoint(routable: Router.credit(id: id))
  }
}

extension CreditService {
  enum Router: RequestRoutable {
    case credit(id: String)

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .credit(id):
        return componentsForRoute(path: "credit/\(id)").url!
      }
    }
  }
}
