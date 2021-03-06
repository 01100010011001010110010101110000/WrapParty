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

// MARK: - Movie

public struct Movie: Codable {
  // MARK: Lifecycle

  public init(adult: Bool, alternativeTitles: MovieAlternativeTitles?, backdropPath: URL?, belongsToCollection: [MovieCollection]?, budget: Int?, changes: MediaChanges?, credits: MediaCredits?, externalIds: ExternalIds?, genres: [Genre]?, homepage: String?, id: Int, images: MediaImages?, imdbId: String?, keywords: MovieKeywords?, lists: ResultPage<MovieList>?, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: URL?, productionCompanies: [ProductionCompany]?, productionCountries: [ProductionCountry]?, recommendations: ResultPage<MovieListResult>?, releaseDate: String?, releaseDates: Results<CountryRelease>?, revenue: Int?, reviews: ResultPage<Review>?, runtime: Int?, similar: ResultPage<MovieListResult>?, spokenLanguages: [SpokenLanguage]?, status: MediaStatus?, tagline: String?, title: String, translations: MediaTranslations?, video: Bool, videos: Results<MediaVideo>?, voteAverage: Double, voteCount: Int, watchProviders: WatchProviders?) {
    self.adult = adult
    self.alternativeTitles = alternativeTitles
    self.backdropPath = backdropPath
    self.belongsToCollection = belongsToCollection
    self.budget = budget
    self.changes = changes
    self.credits = credits
    self.externalIds = externalIds
    self.genres = genres
    self.homepage = homepage
    self.id = id
    self.images = images
    self.imdbId = imdbId
    self.keywords = keywords
    self.lists = lists
    self.originalLanguage = originalLanguage
    self.originalTitle = originalTitle
    self.overview = overview
    self.popularity = popularity
    self.posterPath = posterPath
    self.productionCompanies = productionCompanies
    self.productionCountries = productionCountries
    self.recommendations = recommendations
    self.releaseDate = releaseDate
    self.releaseDates = releaseDates
    self.revenue = revenue
    self.reviews = reviews
    self.runtime = runtime
    self.similar = similar
    self.spokenLanguages = spokenLanguages
    self.status = status
    self.tagline = tagline
    self.title = title
    self.translations = translations
    self.video = video
    self.videos = videos
    self.voteAverage = voteAverage
    self.voteCount = voteCount
    self.watchProviders = watchProviders
  }

  // MARK: Public

  /// Whether the movie is an adult title
  public let adult: Bool
  /// The movie's alternative titles in various localities
  public let alternativeTitles: MovieAlternativeTitles?
  public let backdropPath: URL?
  public let belongsToCollection: [MovieCollection]?
  public let budget: Int?
  public let changes: MediaChanges?
  public let credits: MediaCredits?
  public let externalIds: ExternalIds?
  public let genres: [Genre]?
  public let homepage: String?
  /// The movie's TMDB ID
  public let id: Int
  public let images: MediaImages?
  public let imdbId: String?
  public let keywords: MovieKeywords?
  public let lists: ResultPage<MovieList>?
  public let originalLanguage: String
  public let originalTitle: String
  public let overview: String
  public let popularity: Double
  public let posterPath: URL?
  public let productionCompanies: [ProductionCompany]?
  public let productionCountries: [ProductionCountry]?
  public let recommendations: ResultPage<MovieListResult>?
  /// The movie's release date
  /// - Note: May be `nil` when the movie is not yet released
  public let releaseDate: String?
  public let releaseDates: Results<CountryRelease>?
  public let revenue: Int?
  public let reviews: ResultPage<Review>?
  public let runtime: Int?
  public let similar: ResultPage<MovieListResult>?
  public let spokenLanguages: [SpokenLanguage]?
  public let status: MediaStatus?
  public let tagline: String?
  /// The movie's primary title
  public let title: String
  public let translations: MediaTranslations?
  public let video: Bool
  public let videos: Results<MediaVideo>?
  public let voteAverage: Double
  public let voteCount: Int
  public let watchProviders: WatchProviders?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case adult
    case alternativeTitles = "alternative_titles"
    case backdropPath = "backdrop_path"
    case belongsToCollection = "belongs_to_collection"
    case budget
    case changes
    case credits
    case externalIds = "external_ids"
    case genres
    case homepage
    case id
    case images
    case imdbId = "imdb_id"
    case keywords
    case lists
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview
    case popularity
    case posterPath = "poster_path"
    case productionCompanies = "production_companies"
    case productionCountries = "production_countries"
    case recommendations
    case releaseDate = "release_date"
    case releaseDates = "release_dates"
    case revenue
    case reviews
    case runtime
    case similar
    case spokenLanguages = "spoken_languages"
    case status
    case tagline
    case title
    case translations
    case video
    case videos
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    case watchProviders = "watch/providers"
  }
}

// MARK: - MovieCollection

public struct MovieCollection: Codable {
  // MARK: Lifecycle

  public init(id: Int, name: String, posterPath: URL?, backdropPath: URL?) {
    self.id = id
    self.name = name
    self.posterPath = posterPath
    self.backdropPath = backdropPath
  }

  // MARK: Public

  public let id: Int
  public let name: String
  public let posterPath: URL?
  public let backdropPath: URL?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
  }
}
