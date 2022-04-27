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

// MARK: - Configuration

public protocol Configuration {
  var logger: Logger { get }
  var loader: DataLoading { get }
  var apiToken: String { get }
}

// MARK: - DefaultConfiguration

public struct DefaultConfiguration: Configuration {
  // MARK: Lifecycle

  init() {
    logger = Logger(label: "com.knossos.WrapParty.logger")
    loader = DataLoader()
    apiToken = ProcessInfo.processInfo.environment[Self.apiTokenEnvVar, default: ""]
  }

  init(apiToken: String) {
    logger = Logger(label: "com.knossos.WrapParty.logger")
    loader = DataLoader()
    self.apiToken = apiToken
  }

  // MARK: Public

  public let logger: Logger
  public let loader: DataLoading
  public let apiToken: String

  // MARK: Private

  private static let apiTokenEnvVar: String = "TMDB_API_READ_ACCESS_TOKEN"
}
