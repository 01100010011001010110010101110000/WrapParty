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

// MARK: - CountryRelease

public struct CountryRelease: Codable {
  // MARK: Lifecycle

  public init(iso3166_1: String, releaseDates: [ReleaseDate]) {
    self.iso3166_1 = iso3166_1
    self.releaseDates = releaseDates
  }

  // MARK: Public

  public let iso3166_1: String
  public let releaseDates: [ReleaseDate]

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case iso3166_1 = "iso_3166_1"
    case releaseDates = "release_dates"
  }
}

public extension CountryRelease {
  // MARK: - ReleaseDate

  struct ReleaseDate: Codable {
    // MARK: Lifecycle

    public init(certification: String, iso639_1: String?, note: String?, releaseDate: String, type: ReleaseType) {
      self.certification = certification
      self.iso639_1 = iso639_1
      self.note = note
      self.releaseDate = releaseDate
      self.type = type
    }

    // MARK: Public

    public enum ReleaseType: Int, Codable {
      case premiere = 1
      case limitedTheatrical = 2
      case theatrical = 3
      case digital = 4
      case physical = 5
      case tv = 6
    }

    public let certification: String
    public let iso639_1: String?
    public let note: String?
    public let releaseDate: String
    public let type: ReleaseType

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case certification
      case iso639_1 = "iso_639_1"
      case note
      case releaseDate = "release_date"
      case type
    }
  }
}
