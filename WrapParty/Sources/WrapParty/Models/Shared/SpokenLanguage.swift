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

public struct SpokenLanguage: Codable {
  // MARK: Lifecycle

  public init(englishName: String, iso639_1: String, name: String) {
    self.englishName = englishName
    self.iso639_1 = iso639_1
    self.name = name
  }

  // MARK: Public

  public let englishName: String
  public let iso639_1: String
  public let name: String

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case englishName = "english_name"
    case iso639_1 = "iso_639_1"
    case name
  }
}
