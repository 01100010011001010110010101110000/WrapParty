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

// MARK: - Season

public struct Season: Codable {
  // MARK: Lifecycle

  public init(airDate: String?, episodeCount: Int, id: Int, name: String, overview: String, posterPath: URL?, seasonNumber: Int) {
    self.airDate = airDate
    self.episodeCount = episodeCount
    self.id = id
    self.name = name
    self.overview = overview
    self.posterPath = posterPath
    self.seasonNumber = seasonNumber
  }

  // MARK: Public

  public let airDate: String?
  public let episodeCount: Int
  public let id: Int
  public let name: String
  public let overview: String
  public let posterPath: URL?
  public let seasonNumber: Int

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case airDate = "air_date"
    case episodeCount = "episode_count"
    case id
    case name
    case overview
    case posterPath = "poster_path"
    case seasonNumber = "season_number"
  }
}
