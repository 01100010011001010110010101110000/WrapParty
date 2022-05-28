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

// MARK: - MediaListResult

public enum MediaListResult: Codable {
  case tv(TvListResult)
  case movie(MovieListResult)
  case person(PersonListResult)
}

// MARK: - InlineMediaListResult

public enum InlineMediaListResult: Codable {
  case tv(TvListResult)
  case movie(MovieListResult)
  case person(PersonListResult)

  // MARK: Lifecycle

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let typeDecoder = try decoder.singleValueContainer()
    let mediaType = try container.decode(MediaType.self, forKey: .mediaType)

    switch mediaType {
    case .tv:
      self = .tv(try typeDecoder.decode(TvListResult.self))
    case .movie:
      self = .movie(try typeDecoder.decode(MovieListResult.self))
    case .person:
      self = .person(try typeDecoder.decode(PersonListResult.self))
    }
  }

  // MARK: Public

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case let .movie(movie):
      try container.encode(movie)
    case let .tv(tv):
      try container.encode(tv)
    case let .person(person):
      try container.encode(person)
    }
  }

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case mediaType = "media_type"
  }
}

// MARK: - PersonTaggedImageAsset

public struct PersonTaggedImageAsset: Codable {
  // MARK: Lifecycle

  public init(aspectRatio: Double, filePath: String, height: Int, iso639_1: String?, media: MediaListResult, mediaType: MediaType, voteAverage: Double, voteCount: Int, width: Int) {
    self.aspectRatio = aspectRatio
    self.filePath = filePath
    self.height = height
    self.iso639_1 = iso639_1
    self.media = media
    self.mediaType = mediaType
    self.voteAverage = voteAverage
    self.voteCount = voteCount
    self.width = width
  }

  // TODO: Implement encoding

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    aspectRatio = try container.decode(Double.self, forKey: .aspectRatio)
    filePath = try container.decode(String.self, forKey: .filePath)
    height = try container.decode(Int.self, forKey: .height)
    iso639_1 = try container.decodeIfPresent(String.self, forKey: .iso639_1)
    mediaType = try container.decode(MediaType.self, forKey: .mediaType)
    voteAverage = try container.decode(Double.self, forKey: .voteAverage)
    voteCount = try container.decode(Int.self, forKey: .voteCount)
    width = try container.decode(Int.self, forKey: .width)

    switch mediaType {
    case .tv:
      let result = try container.decode(TvListResult.self, forKey: .media)
      media = .tv(result)
    case .movie:
      let result = try container.decode(MovieListResult.self, forKey: .media)
      media = .movie(result)
    case .person:
      let result = try container.decode(PersonListResult.self, forKey: .media)
      media = .person(result)
    }
  }

  // MARK: Public

  public let aspectRatio: Double
  public let filePath: String
  public let height: Int
  public let iso639_1: String?
  public let media: MediaListResult
  public let mediaType: MediaType
  public let voteAverage: Double
  public let voteCount: Int
  public let width: Int

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case aspectRatio = "aspect_ratio"
    case filePath = "file_path"
    case height
    case iso639_1 = "iso_639_1"
    case media
    case mediaType = "media_type"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    case width
  }
}
