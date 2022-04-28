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

  public init(adult: Bool, alternativeTitles: MovieAlternativeTitle?, backdropPath: URL, belongsToCollection: [Collection]?, budget: Int, genres: [Genre], homepage: URL, id: Int, images: MovieImages?, imdbId: String, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: URL, productionCompanies: [ProductionCompany], productionCountries: [ProductionCountry], releaseDate: String, revenue: Int, runtime: Int, spokenLanguages: [SpokenLanguage], status: MediaStatus, tagline: String, title: String, video: Bool, videos: MovieVideos, voteAverage: Double, voteCount: Int) {
    self.adult = adult
    self.alternativeTitles = alternativeTitles
    self.backdropPath = backdropPath
    self.belongsToCollection = belongsToCollection
    self.budget = budget
    self.genres = genres
    self.homepage = homepage
    self.id = id
    self.images = images
    self.imdbId = imdbId
    self.originalLanguage = originalLanguage
    self.originalTitle = originalTitle
    self.overview = overview
    self.popularity = popularity
    self.posterPath = posterPath
    self.productionCompanies = productionCompanies
    self.productionCountries = productionCountries
    self.releaseDate = releaseDate
    self.revenue = revenue
    self.runtime = runtime
    self.spokenLanguages = spokenLanguages
    self.status = status
    self.tagline = tagline
    self.title = title
    self.video = video
    self.videos = videos
    self.voteAverage = voteAverage
    self.voteCount = voteCount
  }

  // MARK: Public

  public let adult: Bool
  public let alternativeTitles: MovieAlternativeTitle?
  public let backdropPath: URL
  public let belongsToCollection: [Collection]?
  public let budget: Int
  public let genres: [Genre]
  public let homepage: URL
  public let id: Int
  public let images: MovieImages?
  public let imdbId: String
  public let originalLanguage: String
  public let originalTitle: String
  public let overview: String
  public let popularity: Double
  public let posterPath: URL
  public let productionCompanies: [ProductionCompany]
  public let productionCountries: [ProductionCountry]
  public let releaseDate: String
  public let revenue: Int
  public let runtime: Int
  public let spokenLanguages: [SpokenLanguage]
  public let status: MediaStatus
  public let tagline: String
  public let title: String
  public let video: Bool
  public let videos: MovieVideos
  public let voteAverage: Double
  public let voteCount: Int

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case adult
    case alternativeTitles = "alternative_titles"
    case backdropPath = "backdrop_path"
    case belongsToCollection = "belongs_to_collection"
    case budget
    case genres
    case homepage
    case id
    case images
    case imdbId = "imdb_id"
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview
    case popularity
    case posterPath = "poster_path"
    case productionCompanies = "production_companies"
    case productionCountries = "production_countries"
    case releaseDate = "release_date"
    case revenue
    case runtime
    case spokenLanguages = "spoken_languages"
    case status
    case tagline
    case title
    case video
    case videos
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

// MARK: - Genre

public struct Genre: Codable {
  // MARK: Lifecycle

  public init(id: Int, name: String) {
    self.id = id
    self.name = name
  }

  // MARK: Public

  public let id: Int
  public let name: String

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case id
    case name
  }
}

// MARK: - ProductionCompany

public struct ProductionCompany: Codable {
  // MARK: Lifecycle

  public init(id: Int, logoPath: URL?, name: String, originCountry: String) {
    self.id = id
    self.logoPath = logoPath
    self.name = name
    self.originCountry = originCountry
  }

  // MARK: Public

  public let id: Int
  public let logoPath: URL?
  public let name: String
  public let originCountry: String

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case id
    case logoPath = "logo_path"
    case name
    case originCountry = "origin_country"
  }
}

// MARK: - ProductionCountry

public struct ProductionCountry: Codable {
  // MARK: Lifecycle

  public init(iso3166_1: String, name: String) {
    self.iso3166_1 = iso3166_1
    self.name = name
  }

  // MARK: Public

  public let iso3166_1: String
  public let name: String

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case iso3166_1 = "iso_3166_1"
    case name
  }
}

// MARK: - SpokenLanguage

public struct SpokenLanguage: Codable {
  // MARK: Lifecycle

  public init(englishName: String, iso639_1: String, name: String) {
    self.englishName = englishName
    self.iso639_1 = iso639_1
    self.name = name
  }

  // MARK: Public

  public let englishName: String
  public let iso639_1: String
  public let name: String

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case englishName = "english_name"
    case iso639_1 = "iso_639_1"
    case name
  }
}

// MARK: - Collection

public struct Collection: Codable {
  // MARK: Lifecycle

  public init(id: Int, name: String, posterPath: String?, backdropPath: String?) {
    self.id = id
    self.name = name
    self.posterPath = posterPath
    self.backdropPath = backdropPath
  }

  // MARK: Public

  public let id: Int
  public let name: String
  public let posterPath: String?
  public let backdropPath: String?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
  }
}

// MARK: - Movie + Identifiable

extension Movie: Identifiable {}
