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

// MARK: - TvContentRatings

public struct TvContentRatings: Codable {
  // MARK: Lifecycle

  public init(id: Int?, results: [Rating]) {
    self.id = id
    self.results = results
  }

  // MARK: Public

  public let id: Int?
  public let results: [Rating]

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case id
    case results
  }
}

// MARK: - Rating

public struct Rating: Codable {
  // MARK: Lifecycle

  public init(iso3166_1: String, rating: String) {
    self.iso3166_1 = iso3166_1
    self.rating = rating
  }

  // MARK: Public

  public let iso3166_1: String
  public let rating: String

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case iso3166_1 = "iso_3166_1"
    case rating
  }
}
