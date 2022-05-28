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

public struct TvScreenedEpisode: Codable {
  // MARK: Lifecycle

  public init(episodeNumber: Int, id: Int, seasonNumber: Int) {
    self.episodeNumber = episodeNumber
    self.id = id
    self.seasonNumber = seasonNumber
  }

  // MARK: Public

  public let episodeNumber: Int
  public let id: Int
  public let seasonNumber: Int

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case episodeNumber = "episode_number"
    case id
    case seasonNumber = "season_number"
  }
}
