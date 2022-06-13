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

// MARK: - CertificationServiceProviding

public protocol CertificationServiceProviding: ServiceProviding {}

// MARK: - CertificationService

public struct CertificationService: CertificationServiceProviding {
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

  public func movieCertifications() async throws -> CertificationList {
    try await callEndpoint(routable: Router.movie)
  }

  public func tvCertifications() async throws -> CertificationList {
    try await callEndpoint(routable: Router.tv)
  }
}

extension CertificationService {
  enum Router: RequestRoutable {
    case movie
    case tv

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case .movie:
        return componentsForRoute(path: "certification/movie/list").url!
      case .tv:
        return componentsForRoute(path: "certification/tv/list").url!
      }
    }
  }
}
