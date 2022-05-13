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

public struct MediaVideo: Codable {
  // MARK: Lifecycle

  public init(id: String, iso3166_1: String, iso639_1: String, key: String, name: String, official: Bool, publishedAt: String, site: String, size: Int, type: String) {
    self.id = id
    self.iso3166_1 = iso3166_1
    self.iso639_1 = iso639_1
    self.key = key
    self.name = name
    self.official = official
    self.publishedAt = publishedAt
    self.site = site
    self.size = size
    self.type = type
  }

  // MARK: Public

  public let id: String
  public let iso3166_1: String
  public let iso639_1: String
  public let key: String
  public let name: String
  public let official: Bool
  public let publishedAt: String
  public let site: String
  public let size: Int
  public let type: String

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case id
    case iso3166_1 = "iso_3166_1"
    case iso639_1 = "iso_639_1"
    case key
    case name
    case official
    case publishedAt = "published_at"
    case site
    case size
    case type
  }
}
