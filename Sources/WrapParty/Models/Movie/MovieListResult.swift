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

public struct MovieListResult: Codable {
  // MARK: Lifecycle

  public init(adult: Bool, backdropPath: URL?, genreIds: [Int], id: Int, mediaType: MediaType?, originalLanguage: String, originalTitle: String, overview: String, popularity: Double?, posterPath: URL?, releaseDate: String, title: String, video: Bool, voteAverage: Double, voteCount: Int) {
    self.adult = adult
    self.backdropPath = backdropPath
    self.genreIds = genreIds
    self.id = id
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
  public let genreIds: [Int]
  public let id: Int
  public let mediaType: MediaType?
  public let originalLanguage: String
  public let originalTitle: String
  public let overview: String
  public let popularity: Double?
  public let posterPath: URL?
  public let releaseDate: String
  public let title: String
  public let video: Bool
  public let voteAverage: Double
  public let voteCount: Int

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genreIds = "genre_ids"
    case id
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
