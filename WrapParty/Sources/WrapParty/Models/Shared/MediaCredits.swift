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

// MARK: - MediaCredits

public struct MediaCredits: Codable {
  // MARK: Lifecycle

  public init(cast: [Credit], crew: [Credit], id: Int?) {
    self.cast = cast
    self.crew = crew
    self.id = id
  }

  // MARK: Public

  public let cast: [Credit]
  public let crew: [Credit]
  public let id: Int?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case cast
    case crew
    case id
  }
}

public extension MediaCredits {
  // MARK: - Cast

  struct Credit: Codable {
    // MARK: Lifecycle

    public init(adult: Bool, castId: Int?, character: String?, creditId: String, gender: Int, id: Int, knownForDepartment: String, name: String, order: Int?, originalName: String, popularity: Double, profilePath: URL?, department: String?, job: String?) {
      self.adult = adult
      self.castId = castId
      self.character = character
      self.creditId = creditId
      self.gender = gender
      self.id = id
      self.knownForDepartment = knownForDepartment
      self.name = name
      self.order = order
      self.originalName = originalName
      self.popularity = popularity
      self.profilePath = profilePath
      self.department = department
      self.job = job
    }

    // MARK: Public

    public let adult: Bool
    public let castId: Int?
    public let character: String?
    public let creditId: String
    public let gender: Int
    public let id: Int
    public let knownForDepartment: String
    public let name: String
    public let order: Int?
    public let originalName: String
    public let popularity: Double
    public let profilePath: URL?
    public let department: String?
    public let job: String?

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case adult
      case castId = "cast_id"
      case character
      case creditId = "credit_id"
      case gender
      case id
      case knownForDepartment = "known_for_department"
      case name
      case order
      case originalName = "original_name"
      case popularity
      case profilePath = "profile_path"
      case department
      case job
    }
  }
}
