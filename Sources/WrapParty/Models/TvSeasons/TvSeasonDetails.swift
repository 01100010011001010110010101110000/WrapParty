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

// MARK: - TvSeasonDetails

public struct TvSeasonDetails: Codable {
  // MARK: Lifecycle

  public init(id: Int, aggregateCredits: TvAggregateCredits?, airDate: String, credits: MediaCredits?, episodes: [TvEpisodeDetails], externalIds: TvSeasonExternalIds?, images: TvSeasonImages?, name: String, overview: String, posterPath: URL?, seasonNumber: Int, translations: TvSeasonTranslations?, videos: Results<MediaVideo>?) {
    self.id = id
    self.aggregateCredits = aggregateCredits
    self.airDate = airDate
    self.credits = credits
    self.episodes = episodes
    self.externalIds = externalIds
    self.images = images
//    self.tvSeasonId = tvSeasonId
    self.name = name
    self.overview = overview
    self.posterPath = posterPath
    self.seasonNumber = seasonNumber
    self.translations = translations
    self.videos = videos
  }

  // MARK: Public

  public let id: Int
  public let aggregateCredits: TvAggregateCredits?
  public let airDate: String
  public let credits: MediaCredits?
  public let episodes: [TvEpisodeDetails]
  public let externalIds: TvSeasonExternalIds?
  public let images: TvSeasonImages?
//  public let tvSeasonId: Int
  public let name: String
  public let overview: String
  public let posterPath: URL?
  public let seasonNumber: Int
  public let translations: TvSeasonTranslations?
  public let videos: Results<MediaVideo>?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case id
    case aggregateCredits = "aggregate_credits"
    case airDate = "air_date"
    case credits
    case episodes
    case externalIds = "external_ids"
    case images
//    case tvSeasonId = "_id"
    case name
    case overview
    case posterPath = "poster_path"
    case seasonNumber = "season_number"
    case translations
    case videos
  }
}

// MARK: Identifiable

extension TvSeasonDetails: Identifiable {}

// MARK: - Crew

// public struct Crew: Codable {
//  public let adult: Bool
//  public let creditId: String
//  public let department: String?
//  public let gender: Int
//  public let id: Int
//  public let job: String?
//  public let knownForDepartment: String
//  public let name: String
//  public let originalName: String
//  public let popularity: Double
//  public let profilePath: String?
//  public let character: String?
//  public let order: Int?
//
//  enum CodingKeys: String, CodingKey {
//    case adult = "adult"
//    case creditId = "credit_id"
//    case department = "department"
//    case gender = "gender"
//    case id = "id"
//    case job = "job"
//    case knownForDepartment = "known_for_department"
//    case name = "name"
//    case originalName = "original_name"
//    case popularity = "popularity"
//    case profilePath = "profile_path"
//    case character = "character"
//    case order = "order"
//  }
//
//  public init(adult: Bool, creditId: String, department: String?, gender: Int, id: Int, job: String?, knownForDepartment: String, name: String, originalName: String, popularity: Double, profilePath: String?, character: String?, order: Int?) {
//    self.adult = adult
//    self.creditId = creditId
//    self.department = department
//    self.gender = gender
//    self.id = id
//    self.job = job
//    self.knownForDepartment = knownForDepartment
//    self.name = name
//    self.originalName = originalName
//    self.popularity = popularity
//    self.profilePath = profilePath
//    self.character = character
//    self.order = order
//  }
// }
