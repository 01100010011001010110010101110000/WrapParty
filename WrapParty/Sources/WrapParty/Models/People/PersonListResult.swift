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

public struct PersonListResult: Codable {
  // MARK: Lifecycle

  public init(adult: Bool, gender: Int, id: Int, knownFor: [InlineMediaListResult], knownForDepartment: String, name: String, popularity: Double, profilePath: URL?) {
    self.adult = adult
    self.gender = gender
    self.id = id
    self.knownFor = knownFor
    self.knownForDepartment = knownForDepartment
    self.name = name
    self.popularity = popularity
    self.profilePath = profilePath
  }

  // MARK: Public

  public let adult: Bool
  public let gender: Int
  public let id: Int
  public let knownFor: [InlineMediaListResult]
  public let knownForDepartment: String
  public let name: String
  public let popularity: Double
  public let profilePath: URL?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case adult
    case gender
    case id
    case knownFor = "known_for"
    case knownForDepartment = "known_for_department"
    case name
    case popularity
    case profilePath = "profile_path"
  }
}
