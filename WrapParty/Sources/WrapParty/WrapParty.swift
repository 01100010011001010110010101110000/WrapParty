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

public class WrapParty {
  // MARK: Lifecycle

  init<C: Configuration>(configuration: C) {
    loader = configuration.loader
    logger = configuration.logger
    tokenManager = TokenManager(token: configuration.apiToken)
  }

  convenience init() {
    let configuration = DefaultConfiguration()
    self.init(configuration: configuration)
  }

  // MARK: Public

  public let loader: DataLoading
  public let logger: Logger

  // MARK: Internal

  static let baseUrl = URL(string: "https://api.themoviedb.org/3/")!
  static let tmdbDefaultDateFormat: Date.ISO8601FormatStyle = .iso8601.year().month().day()
  static let jsonDecoder = { () -> JSONDecoder in
    var decoder = JSONDecoder()
    return decoder
  }()

  // MARK: Private

  private let tokenManager: TokenManager
}
