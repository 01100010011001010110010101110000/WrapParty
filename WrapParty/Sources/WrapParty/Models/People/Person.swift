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

// MARK: - Person

public struct Person: Codable {
  // MARK: Lifecycle

  public init(adult: Bool, alsoKnownAs: [String], biography: String, birthday: String?, changes: MediaChanges?, deathday: String?, gender: Gender, homepage: URL?, id: Int, imdbId: String?, knownForDepartment: String, name: String, placeOfBirth: String?, popularity: Double, profilePath: URL?) {
    self.adult = adult
    self.alsoKnownAs = alsoKnownAs
    self.biography = biography
    self.birthday = birthday
    self.changes = changes
    self.deathday = deathday
    self.gender = gender
    self.homepage = homepage
    self.id = id
    self.imdbId = imdbId
    self.knownForDepartment = knownForDepartment
    self.name = name
    self.placeOfBirth = placeOfBirth
    self.popularity = popularity
    self.profilePath = profilePath
  }

  // MARK: Public

  public let adult: Bool
  public let alsoKnownAs: [String]
  public let biography: String
  public let birthday: String?
  public let changes: MediaChanges?
  public let deathday: String?
  public let gender: Gender
  public let homepage: URL?
  public let id: Int
  public let imdbId: String?
  public let knownForDepartment: String
  public let name: String
  public let placeOfBirth: String?
  public let popularity: Double
  public let profilePath: URL?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case adult
    case alsoKnownAs = "also_known_as"
    case biography
    case birthday
    case changes
    case deathday
    case gender
    case homepage
    case id
    case imdbId = "imdb_id"
    case knownForDepartment = "known_for_department"
    case name
    case placeOfBirth = "place_of_birth"
    case popularity
    case profilePath = "profile_path"
  }
}

public extension Person {
  enum Gender: Int, Codable {
    case unknown = 0
    case female = 1
    case male = 2
  }
}
