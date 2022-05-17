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

// MARK: - TvShow

public struct TvShow: Codable {
  // MARK: Lifecycle

  public init(adult: Bool, backdropPath: URL?, createdBy: [CreatedBy], episodeRunTime: [Int], firstAirDate: String?, genres: [Genre], homepage: String, id: Int, inProduction: Bool, languages: [String], lastAirDate: String?, lastEpisodeToAir: RecentEpisode?, name: String, networks: [Network], nextEpisodeToAir: RecentEpisode?, numberOfEpisodes: Int, numberOfSeasons: Int, originCountry: [String], originalLanguage: String, originalName: String, overview: String, popularity: Double, posterPath: URL?, productionCompanies: [ProductionCompany], productionCountries: [ProductionCountry], seasons: [Season], spokenLanguages: [SpokenLanguage], status: String, tagline: String, type: String, voteAverage: Double, voteCount: Int) {
    self.adult = adult
    self.backdropPath = backdropPath
    self.createdBy = createdBy
    self.episodeRunTime = episodeRunTime
    self.firstAirDate = firstAirDate
    self.genres = genres
    self.homepage = homepage
    self.id = id
    self.inProduction = inProduction
    self.languages = languages
    self.lastAirDate = lastAirDate
    self.lastEpisodeToAir = lastEpisodeToAir
    self.name = name
    self.networks = networks
    self.nextEpisodeToAir = nextEpisodeToAir
    self.numberOfEpisodes = numberOfEpisodes
    self.numberOfSeasons = numberOfSeasons
    self.originCountry = originCountry
    self.originalLanguage = originalLanguage
    self.originalName = originalName
    self.overview = overview
    self.popularity = popularity
    self.posterPath = posterPath
    self.productionCompanies = productionCompanies
    self.productionCountries = productionCountries
    self.seasons = seasons
    self.spokenLanguages = spokenLanguages
    self.status = status
    self.tagline = tagline
    self.type = type
    self.voteAverage = voteAverage
    self.voteCount = voteCount
  }

  // MARK: Public

  public let adult: Bool
  public let backdropPath: URL?
  public let createdBy: [CreatedBy]
  public let episodeRunTime: [Int]
  public let firstAirDate: String?
  public let genres: [Genre]
  public let homepage: String
  public let id: Int
  public let inProduction: Bool
  public let languages: [String]
  public let lastAirDate: String?
  public let lastEpisodeToAir: RecentEpisode?
  public let name: String
  public let networks: [Network]
  public let nextEpisodeToAir: RecentEpisode?
  public let numberOfEpisodes: Int
  public let numberOfSeasons: Int
  public let originCountry: [String]
  public let originalLanguage: String
  public let originalName: String
  public let overview: String
  public let popularity: Double
  public let posterPath: URL?
  public let productionCompanies: [ProductionCompany]
  public let productionCountries: [ProductionCountry]
  public let seasons: [Season]
  public let spokenLanguages: [SpokenLanguage]
  public let status: String
  public let tagline: String
  public let type: String
  public let voteAverage: Double
  public let voteCount: Int

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case createdBy = "created_by"
    case episodeRunTime = "episode_run_time"
    case firstAirDate = "first_air_date"
    case genres
    case homepage
    case id
    case inProduction = "in_production"
    case languages
    case lastAirDate = "last_air_date"
    case lastEpisodeToAir = "last_episode_to_air"
    case name
    case networks
    case nextEpisodeToAir = "next_episode_to_air"
    case numberOfEpisodes = "number_of_episodes"
    case numberOfSeasons = "number_of_seasons"
    case originCountry = "origin_country"
    case originalLanguage = "original_language"
    case originalName = "original_name"
    case overview
    case popularity
    case posterPath = "poster_path"
    case productionCompanies = "production_companies"
    case productionCountries = "production_countries"
    case seasons
    case spokenLanguages = "spoken_languages"
    case status
    case tagline
    case type
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

// MARK: - CreatedBy

public struct CreatedBy: Codable {
  // MARK: Lifecycle

  public init(creditId: String, gender: Int, id: Int, name: String, profilePath: URL?) {
    self.creditId = creditId
    self.gender = gender
    self.id = id
    self.name = name
    self.profilePath = profilePath
  }

  // MARK: Public

  public let creditId: String
  public let gender: Int
  public let id: Int
  public let name: String
  public let profilePath: URL?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case creditId = "credit_id"
    case gender
    case id
    case name
    case profilePath = "profile_path"
  }
}

// MARK: - RecentEpisode

public struct RecentEpisode: Codable {
  // MARK: Lifecycle

  public init(airDate: String, episodeNumber: Int, id: Int, name: String, overview: String, productionCode: String, runtime: Int, seasonNumber: Int, stillPath: URL?, voteAverage: Double, voteCount: Int) {
    self.airDate = airDate
    self.episodeNumber = episodeNumber
    self.id = id
    self.name = name
    self.overview = overview
    self.productionCode = productionCode
    self.runtime = runtime
    self.seasonNumber = seasonNumber
    self.stillPath = stillPath
    self.voteAverage = voteAverage
    self.voteCount = voteCount
  }

  // MARK: Public

  public let airDate: String
  public let episodeNumber: Int
  public let id: Int
  public let name: String
  public let overview: String
  public let productionCode: String
  public let runtime: Int
  public let seasonNumber: Int
  public let stillPath: URL?
  public let voteAverage: Double
  public let voteCount: Int

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case airDate = "air_date"
    case episodeNumber = "episode_number"
    case id
    case name
    case overview
    case productionCode = "production_code"
    case runtime
    case seasonNumber = "season_number"
    case stillPath = "still_path"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

// MARK: - TvShow + Identifiable

extension TvShow: Identifiable {}
