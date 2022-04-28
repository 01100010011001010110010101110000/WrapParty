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

// MARK: - MovieAlternativeTitle

public struct MovieAlternativeTitle: Codable {
  // MARK: Lifecycle

  public init(id: Int?, titles: [Title]) {
    self.id = id
    self.titles = titles
  }

  // MARK: Public

  public let id: Int?
  public let titles: [Title]

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case id
    case titles
  }
}

public extension MovieAlternativeTitle {
  struct Title: Codable {
    // MARK: Lifecycle

    public init(iso3166_1: String, title: String, type: String) {
      self.iso3166_1 = iso3166_1
      self.title = title
      self.type = type
    }

    // MARK: Public

    public let iso3166_1: String
    public let title: String
    public let type: String

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case iso3166_1 = "iso_3166_1"
      case title
      case type
    }
  }
}
