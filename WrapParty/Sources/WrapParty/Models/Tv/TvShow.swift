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

  public init(adult: Bool, aggregateCredits: TvAggregateCredits?, alternativeTitles: Results<AlternativeTitle>?, backdropPath: URL?, changes: MediaChanges?, contentRatings: Results<TvContentRating>?, createdBy: [CreatedBy], credits: MediaCredits?, episodeGroups: Results<TvEpisodeGroup>?, episodeRunTime: [Int], externalIds: ExternalIds?, firstAirDate: String?, genres: [Genre], homepage: String, id: Int, images: MediaImages?, inProduction: Bool, keywords: Results<Keyword>?, languages: [String], lastAirDate: String?, lastEpisodeToAir: RecentEpisode?, name: String, networks: [Network], nextEpisodeToAir: RecentEpisode?, numberOfEpisodes: Int, numberOfSeasons: Int, originCountry: [String], originalLanguage: String, originalName: String, overview: String, popularity: Double, posterPath: URL?, productionCompanies: [ProductionCompany], productionCountries: [ProductionCountry], recommendations: ResultPage<TvListResult>?, reviews: ResultPage<Review>?, screenedTheatrically: Results<TvScreenedEpisode>?, seasons: [TvSeason], similar: ResultPage<TvListResult>?, spokenLanguages: [SpokenLanguage], status: String, tagline: String, translations: MediaTranslations?, type: String, videos: Results<MediaVideo>?, voteAverage: Double, voteCount: Int, watchProviders: WatchProviders?) {
    self.adult = adult
    self.aggregateCredits = aggregateCredits
    self.alternativeTitles = alternativeTitles
    self.backdropPath = backdropPath
    self.changes = changes
    self.contentRatings = contentRatings
    self.createdBy = createdBy
    self.credits = credits
    self.episodeGroups = episodeGroups
    self.episodeRunTime = episodeRunTime
    self.externalIds = externalIds
    self.firstAirDate = firstAirDate
    self.genres = genres
    self.homepage = homepage
    self.id = id
    self.images = images
    self.inProduction = inProduction
    self.keywords = keywords
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
    self.recommendations = recommendations
    self.reviews = reviews
    self.screenedTheatrically = screenedTheatrically
    self.seasons = seasons
    self.similar = similar
    self.spokenLanguages = spokenLanguages
    self.status = status
    self.tagline = tagline
    self.translations = translations
    self.type = type
    self.videos = videos
    self.voteAverage = voteAverage
    self.voteCount = voteCount
    self.watchProviders = watchProviders
  }

  // MARK: Public

  public let adult: Bool
  public let aggregateCredits: TvAggregateCredits?
  public let alternativeTitles: Results<AlternativeTitle>?
  public let backdropPath: URL?
  public let changes: MediaChanges?
  public let contentRatings: Results<TvContentRating>?
  public let createdBy: [CreatedBy]
  public let credits: MediaCredits?
  public let episodeGroups: Results<TvEpisodeGroup>?
  public let episodeRunTime: [Int]
  public let externalIds: ExternalIds?
  public let firstAirDate: String?
  public let genres: [Genre]
  public let homepage: String
  public let id: Int
  public let images: MediaImages?
  public let inProduction: Bool
  public let keywords: Results<Keyword>?
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
  public let recommendations: ResultPage<TvListResult>?
  public let reviews: ResultPage<Review>?
  public let screenedTheatrically: Results<TvScreenedEpisode>?
  public let seasons: [TvSeason]
  public let similar: ResultPage<TvListResult>?
  public let spokenLanguages: [SpokenLanguage]
  public let status: String
  public let tagline: String
  public let translations: MediaTranslations?
  public let type: String
  public let videos: Results<MediaVideo>?
  public let voteAverage: Double
  public let voteCount: Int
  public let watchProviders: WatchProviders?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case adult
    case aggregateCredits = "aggregate_credits"
    case alternativeTitles = "alternative_titles"
    case backdropPath = "backdrop_path"
    case changes
    case contentRatings = "content_ratings"
    case createdBy = "created_by"
    case credits
    case episodeGroups = "episode_groups"
    case episodeRunTime = "episode_run_time"
    case externalIds = "external_ids"
    case firstAirDate = "first_air_date"
    case genres
    case homepage
    case id
    case images
    case inProduction = "in_production"
    case keywords
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
    case recommendations
    case reviews
    case screenedTheatrically = "screened_theatrically"
    case seasons
    case similar
    case spokenLanguages = "spoken_languages"
    case status
    case tagline
    case translations
    case type
    case videos
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    case watchProviders = "watch/providers"
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

  public init(airDate: String, episodeNumber: Int, id: Int, name: String, overview: String, productionCode: String, runtime: Int?, seasonNumber: Int, stillPath: URL?, voteAverage: Double, voteCount: Int) {
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
  public let runtime: Int?
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

public extension TvShow {
  enum ShowStatus: Int {
    case returningSeries = 0
    case planned = 1
    case inProduction = 2
    case ended = 3
    case canceled = 4
    case pilot = 5
  }

  enum ShowType: Int {
    case documentary = 0
    case news = 1
    case miniseries = 2
    case reality = 3
    case scripted = 4
    case talkShow = 5
    case video = 6
  }
}
