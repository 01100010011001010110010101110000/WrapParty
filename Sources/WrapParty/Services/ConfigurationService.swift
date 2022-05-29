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

// MARK: - ConfigurationServiceProviding

protocol ConfigurationServiceProviding: ServiceProviding {}

// MARK: - ConfigurationService

public struct ConfigurationService: SearchServiceProviding {
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

  public func configuration() async throws -> TmdbConfiguration {
    try await callEndpoint(routable: Router.configuration)
  }

  public func countries() async throws -> [TmdbConfiguration.Country] {
    try await callEndpoint(routable: Router.countries)
  }

  public func jobs() async throws -> [TmdbConfiguration.DepartmentJobs] {
    try await callEndpoint(routable: Router.jobs)
  }

  public func languages() async throws -> [SpokenLanguage] {
    try await callEndpoint(routable: Router.languages)
  }

  public func primaryTranslations() async throws -> [String] {
    try await callEndpoint(routable: Router.primaryTranslations)
  }

  public func timezones() async throws -> [TmdbConfiguration.Timezones] {
    try await callEndpoint(routable: Router.timezones)
  }
}

extension ConfigurationService {
  enum Router: RequestRoutable {
    case configuration
    case countries
    case jobs
    case languages
    case primaryTranslations
    case timezones

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case .configuration:
        return componentsForRoute(path: "configuration").url!
      case .countries:
        return componentsForRoute(path: "configuration/countries").url!
      case .jobs:
        return componentsForRoute(path: "configuration/jobs").url!
      case .languages:
        return componentsForRoute(path: "configuration/languages").url!
      case .primaryTranslations:
        return componentsForRoute(path: "configuration/primary_translations").url!
      case .timezones:
        return componentsForRoute(path: "configuration/timezones").url!
      }
    }
  }
}
