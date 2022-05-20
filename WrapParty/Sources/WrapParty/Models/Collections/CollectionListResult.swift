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

public struct CollectionListResult: Codable {
  // MARK: Lifecycle

  public init(adult: Bool, backdropPath: URL?, id: Int, name: String, originalLanguage: String, originalName: String, overview: String, posterPath: URL?) {
    self.adult = adult
    self.backdropPath = backdropPath
    self.id = id
    self.name = name
    self.originalLanguage = originalLanguage
    self.originalName = originalName
    self.overview = overview
    self.posterPath = posterPath
  }

  // MARK: Public

  public let adult: Bool
  public let backdropPath: URL?
  public let id: Int
  public let name: String
  public let originalLanguage: String
  public let originalName: String
  public let overview: String
  public let posterPath: URL?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case id
    case name
    case originalLanguage = "original_language"
    case originalName = "original_name"
    case overview
    case posterPath = "poster_path"
  }
}
