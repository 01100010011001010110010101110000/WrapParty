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

public typealias PersonCombinedCredits = PersonCredits<Person.CombinedCastCredit, Person.CombinedCrewCredit>
public typealias PersonMovieCredits = PersonCredits<Person.MovieCast, Person.MovieCrew>
public typealias PersonTvCredits = PersonCredits<Person.TvCast, Person.TvCrew>

// MARK: - PersonCredits

public struct PersonCredits<Cast, Crew> {
  // MARK: Lifecycle

  public init(cast: [Cast], crew: [Crew], id: Int) {
    self.cast = cast
    self.crew = crew
    self.id = id
  }

  // MARK: Public

  public let cast: [Cast]
  public let crew: [Crew]
  public let id: Int
}

// MARK: Codable

extension PersonCredits: Codable where Cast: Codable, Crew: Codable {
  enum CodingKeys: String, CodingKey {
    case cast
    case crew
    case id
  }
}

public extension Person {
  enum CombinedCastCredit: Codable {
    case tv(credit: TvCast)
    case movie(credit: MovieCast)

    // MARK: Lifecycle

    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)

      let mediaType = try container.decode(MediaType.self, forKey: .mediaType)
      switch mediaType {
      case .tv:
        let tvContainer = try decoder.singleValueContainer()
        let credit = try tvContainer.decode(TvCast.self)
        self = .tv(credit: credit)
      case .movie:
        let movieContainer = try decoder.singleValueContainer()
        let credit = try movieContainer.decode(MovieCast.self)
        self = .movie(credit: credit)
      }
    }

    // MARK: Public

    public func encode(to _: Encoder) throws {}

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case mediaType = "media_type"
    }
  }

  enum CombinedCrewCredit: Codable {
    case tv(credit: TvCrew)
    case movie(credit: MovieCrew)

    // MARK: Lifecycle

    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)

      let mediaType = try container.decode(MediaType.self, forKey: .mediaType)
      switch mediaType {
      case .tv:
        let tvContainer = try decoder.singleValueContainer()
        let credit = try tvContainer.decode(TvCrew.self)
        self = .tv(credit: credit)
      case .movie:
        let movieContainer = try decoder.singleValueContainer()
        let credit = try movieContainer.decode(MovieCrew.self)
        self = .movie(credit: credit)
      }
    }

    // MARK: Public

    public func encode(to _: Encoder) throws {}

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case mediaType = "media_type"
    }
  }
}

public extension Person {
  struct TvCast: Codable {
    // MARK: Lifecycle

    public init(backdropPath: URL?, character: String, creditId: String, episodeCount: Int?, firstAirDate: String?, genreIds: [Int], id: Int, mediaType: MediaType?, name: String, originCountry: [String], originalLanguage: String, originalName: String, overview: String, popularity: Double, posterPath: URL?, voteAverage: Double, voteCount: Int) {
      self.backdropPath = backdropPath
      self.character = character
      self.creditId = creditId
      self.episodeCount = episodeCount
      self.firstAirDate = firstAirDate
      self.genreIds = genreIds
      self.id = id
      self.mediaType = mediaType
      self.name = name
      self.originCountry = originCountry
      self.originalLanguage = originalLanguage
      self.originalName = originalName
      self.overview = overview
      self.popularity = popularity
      self.posterPath = posterPath
      self.voteAverage = voteAverage
      self.voteCount = voteCount
    }

    // MARK: Public

    public let backdropPath: URL?
    public let character: String
    public let creditId: String
    public let episodeCount: Int?
    public let firstAirDate: String?
    public let genreIds: [Int]
    public let id: Int
    public let mediaType: MediaType?
    public let name: String
    public let originCountry: [String]
    public let originalLanguage: String
    public let originalName: String
    public let overview: String
    public let popularity: Double
    public let posterPath: URL?
    public let voteAverage: Double
    public let voteCount: Int

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case backdropPath = "backdrop_path"
      case character
      case creditId = "credit_id"
      case episodeCount = "episode_count"
      case firstAirDate = "first_air_date"
      case genreIds = "genre_ids"
      case id
      case mediaType = "media_type"
      case name
      case originCountry = "origin_country"
      case originalLanguage = "original_language"
      case originalName = "original_name"
      case overview
      case popularity
      case posterPath = "poster_path"
      case voteAverage = "vote_average"
      case voteCount = "vote_count"
    }
  }

  struct TvCrew: Codable {
    // MARK: Lifecycle

    public init(backdropPath: URL?, creditId: String, department: String, episodeCount: Int?, firstAirDate: String?, genreIds: [Int], id: Int, job: String, mediaType: MediaType?, name: String, originCountry: [String], originalLanguage: String, originalName: String, overview: String, popularity: Double, posterPath: URL?, voteAverage: Double, voteCount: Int) {
      self.backdropPath = backdropPath
      self.creditId = creditId
      self.department = department
      self.episodeCount = episodeCount
      self.firstAirDate = firstAirDate
      self.genreIds = genreIds
      self.id = id
      self.job = job
      self.mediaType = mediaType
      self.name = name
      self.originCountry = originCountry
      self.originalLanguage = originalLanguage
      self.originalName = originalName
      self.overview = overview
      self.popularity = popularity
      self.posterPath = posterPath
      self.voteAverage = voteAverage
      self.voteCount = voteCount
    }

    // MARK: Public

    public let backdropPath: URL?
    public let creditId: String
    public let department: String
    public let episodeCount: Int?
    public let firstAirDate: String?
    public let genreIds: [Int]
    public let id: Int
    public let job: String
    public let mediaType: MediaType?
    public let name: String
    public let originCountry: [String]
    public let originalLanguage: String
    public let originalName: String
    public let overview: String
    public let popularity: Double
    public let posterPath: URL?
    public let voteAverage: Double
    public let voteCount: Int

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case backdropPath = "backdrop_path"
      case creditId = "credit_id"
      case department
      case episodeCount = "episode_count"
      case firstAirDate = "first_air_date"
      case genreIds = "genre_ids"
      case id
      case job
      case mediaType = "media_type"
      case name
      case originCountry = "origin_country"
      case originalLanguage = "original_language"
      case originalName = "original_name"
      case overview
      case popularity
      case posterPath = "poster_path"
      case voteAverage = "vote_average"
      case voteCount = "vote_count"
    }
  }
}

public extension Person {
  // MARK: - MovieCast

  struct MovieCast: Codable {
    // MARK: Lifecycle

    public init(adult: Bool, backdropPath: URL?, character: String, creditId: String, genreIds: [Int], id: Int, mediaType: MediaType?, order: Int, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: URL?, releaseDate: String?, title: String, video: Bool, voteAverage: Double, voteCount: Int) {
      self.adult = adult
      self.backdropPath = backdropPath
      self.character = character
      self.creditId = creditId
      self.genreIds = genreIds
      self.id = id
      self.mediaType = mediaType
      self.order = order
      self.originalLanguage = originalLanguage
      self.originalTitle = originalTitle
      self.overview = overview
      self.popularity = popularity
      self.posterPath = posterPath
      self.releaseDate = releaseDate
      self.title = title
      self.video = video
      self.voteAverage = voteAverage
      self.voteCount = voteCount
    }

    // MARK: Public

    public let adult: Bool
    public let backdropPath: URL?
    public let character: String
    public let creditId: String
    public let genreIds: [Int]
    public let id: Int
    public let mediaType: MediaType?
    public let order: Int
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String
    public let popularity: Double
    public let posterPath: URL?
    public let releaseDate: String?
    public let title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case adult
      case backdropPath = "backdrop_path"
      case character
      case creditId = "credit_id"
      case genreIds = "genre_ids"
      case id
      case mediaType = "media_type"
      case order
      case originalLanguage = "original_language"
      case originalTitle = "original_title"
      case overview
      case popularity
      case posterPath = "poster_path"
      case releaseDate = "release_date"
      case title
      case video
      case voteAverage = "vote_average"
      case voteCount = "vote_count"
    }
  }

  struct MovieCrew: Codable {
    // MARK: Lifecycle

    public init(adult: Bool, backdropPath: URL?, creditId: String, department: String, genreIds: [Int], id: Int, job: String, mediaType: MediaType?, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: URL?, releaseDate: String?, title: String, video: Bool, voteAverage: Double, voteCount: Int) {
      self.adult = adult
      self.backdropPath = backdropPath
      self.creditId = creditId
      self.department = department
      self.genreIds = genreIds
      self.id = id
      self.job = job
      self.mediaType = mediaType
      self.originalLanguage = originalLanguage
      self.originalTitle = originalTitle
      self.overview = overview
      self.popularity = popularity
      self.posterPath = posterPath
      self.releaseDate = releaseDate
      self.title = title
      self.video = video
      self.voteAverage = voteAverage
      self.voteCount = voteCount
    }

    // MARK: Public

    public let adult: Bool
    public let backdropPath: URL?
    public let creditId: String
    public let department: String
    public let genreIds: [Int]
    public let id: Int
    public let job: String
    public let mediaType: MediaType?
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String
    public let popularity: Double
    public let posterPath: URL?
    public let releaseDate: String?
    public let title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case adult
      case backdropPath = "backdrop_path"
      case creditId = "credit_id"
      case department
      case genreIds = "genre_ids"
      case id
      case job
      case mediaType = "media_type"
      case originalLanguage = "original_language"
      case originalTitle = "original_title"
      case overview
      case popularity
      case posterPath = "poster_path"
      case releaseDate = "release_date"
      case title
      case video
      case voteAverage = "vote_average"
      case voteCount = "vote_count"
    }
  }
}
