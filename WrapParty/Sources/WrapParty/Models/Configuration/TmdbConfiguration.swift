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

// MARK: - TmdbConfiguration

public struct TmdbConfiguration: Codable {
  // MARK: Lifecycle

  public init(changeKeys: [String], images: Images) {
    self.changeKeys = changeKeys
    self.images = images
  }

  // MARK: Public

  public let changeKeys: [String]
  public let images: Images

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case changeKeys = "change_keys"
    case images
  }
}

public extension TmdbConfiguration {
  // MARK: - Images

  struct Images: Codable {
    // MARK: Lifecycle

    public init(backdropSizes: [String], baseUrl: URL, logoSizes: [String], posterSizes: [String], profileSizes: [String], secureBaseUrl: URL, stillSizes: [String]) {
      self.backdropSizes = backdropSizes
      self.baseUrl = baseUrl
      self.logoSizes = logoSizes
      self.posterSizes = posterSizes
      self.profileSizes = profileSizes
      self.secureBaseUrl = secureBaseUrl
      self.stillSizes = stillSizes
    }

    // MARK: Public

    public let backdropSizes: [String]
    public let baseUrl: URL
    public let logoSizes: [String]
    public let posterSizes: [String]
    public let profileSizes: [String]
    public let secureBaseUrl: URL
    public let stillSizes: [String]

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case backdropSizes = "backdrop_sizes"
      case baseUrl = "base_url"
      case logoSizes = "logo_sizes"
      case posterSizes = "poster_sizes"
      case profileSizes = "profile_sizes"
      case secureBaseUrl = "secure_base_url"
      case stillSizes = "still_sizes"
    }
  }
}
