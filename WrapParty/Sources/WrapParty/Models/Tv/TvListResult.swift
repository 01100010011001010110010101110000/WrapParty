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

public struct TvListResult: Codable {
  // MARK: Lifecycle

  public init(adult: Bool, backdropPath: URL?, firstAirDate: String, genreIds: [Int], id: Int, mediaType: MediaType?, name: String, originCountry: [String], originalLanguage: String, originalName: String, overview: String, popularity: Double, posterPath: URL?, voteAverage: Double, voteCount: Int) {
    self.adult = adult
    self.backdropPath = backdropPath
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

  public let adult: Bool
  public let backdropPath: URL?
  public let firstAirDate: String
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
    case adult
    case backdropPath = "backdrop_path"
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
