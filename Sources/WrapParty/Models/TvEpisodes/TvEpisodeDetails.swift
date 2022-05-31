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

// MARK: - TvEpisodeDetails

public struct TvEpisodeDetails: Codable {
  // MARK: Public

  public let airDate: String
  public let crew: [MediaCredits.Credit]
  public let credits: MediaCredits?
  public let episodeNumber: Int
  public let externalIds: TvEpisodeExternalIds?
  public let guestStars: [MediaCredits.Credit]
  public let id: Int
  public let images: TvEpisodeImages?
  public let name: String
  public let overview: String
  public let productionCode: String
  public let runtime: Int
  public let seasonNumber: Int
  public let stillPath: URL?
  public let translations: TvEpisodeTranslations?
  public let videos: Results<MediaVideo>?
  public let voteAverage: Double
  public let voteCount: Int

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case airDate = "air_date"
    case crew
    case credits
    case episodeNumber = "episode_number"
    case externalIds = "external_ids"
    case guestStars = "guest_stars"
    case id
    case images
    case name
    case overview
    case productionCode = "production_code"
    case runtime
    case seasonNumber = "season_number"
    case stillPath = "still_path"
    case translations
    case videos
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}
