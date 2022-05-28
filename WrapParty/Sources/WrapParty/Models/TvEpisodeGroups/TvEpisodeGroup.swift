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

// MARK: - TvEpisodeGroup

public struct TvEpisodeGroup: Codable {
  // MARK: Lifecycle

  public init(description: String, episodeCount: Int, groupCount: Int, groups: [EpisodeGroup]?, id: String, name: String, network: NetworkListResult?, type: GroupType) {
    self.description = description
    self.episodeCount = episodeCount
    self.groupCount = groupCount
    self.groups = groups
    self.id = id
    self.name = name
    self.network = network
    self.type = type
  }

  // MARK: Public

  public let description: String
  public let episodeCount: Int
  public let groupCount: Int
  public let groups: [EpisodeGroup]?
  public let id: String
  public let name: String
  public let network: NetworkListResult?
  public let type: GroupType

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case description
    case episodeCount = "episode_count"
    case groupCount = "group_count"
    case groups
    case id
    case name
    case network
    case type
  }
}

public extension TvEpisodeGroup {
  struct EpisodeGroup: Codable {
    public let episodes: [RecentEpisode]
    public let id: String
    public let locked: Bool
    public let name: String
    public let order: Int
  }
}

public extension TvEpisodeGroup {
  enum GroupType: Int, Codable {
    case originalAirDate = 1
    case absolute = 2
    case dvd = 3
    case digital = 4
    case storyArc = 5
    case production = 6
    case tv = 7
  }
}
