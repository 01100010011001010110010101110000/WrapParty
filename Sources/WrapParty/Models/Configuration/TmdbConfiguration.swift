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

// MARK: - TmdbConfiguration

public struct TmdbConfiguration: Codable {
  // MARK: Lifecycle

  public init(changeKeys: [String], images: Images) {
    self.changeKeys = changeKeys
    self.images = images
  }

  // MARK: Public

  public let changeKeys: [String]
  public let images: Images

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case changeKeys = "change_keys"
    case images
  }
}

public extension TmdbConfiguration {
  /// The dimension that was fixed when resizing occurred
  enum ImageSizeDimension: String, Codable {
    /// The image was resized with a fixed height
    case height = "h"
    /// The image was resized with a fixed width
    case width = "w"

    init?(character: Character) {
      switch character {
      case "h":
        self = .height
      case "w":
        self = .width
      default:
        return nil
      }
    }
  }

  /// An enum wrapping the available sizes TMDB offers for its images
  enum ImageSize: Codable {
    /// The original image asset, without resizing
    case original
    /// A resized image
    case resized(fixedDimension: ImageSizeDimension, length: Int)

    public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()

      let dimensionString = try container.decode(String.self)
      if dimensionString == "original" {
        self = .original
      } else {
        guard let dimensionChar = dimensionString.first,
              let dimension = ImageSizeDimension(character: dimensionChar),
              let tail = dimensionString.tail,
              let length = Int(tail) else { throw WrapPartyError.decodingError }
        self = .resized(fixedDimension: dimension, length: length)
      }
    }

    public var tmdbSizeSlug: String {
      switch self {
      case .original:
        return "original"
      case let .resized(fixedDimension, length):
        return "\(fixedDimension.rawValue)\(length)"
      }
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      
      try container.encode(tmdbSizeSlug)
    }
  }

  // MARK: - Images

  struct Images: Codable {
    // MARK: Lifecycle

    public init(backdropSizes: [ImageSize], baseUrl: URL, logoSizes: [ImageSize], posterSizes: [ImageSize], profileSizes: [ImageSize], secureBaseUrl: URL, stillSizes: [ImageSize]) {
      self.backdropSizes = backdropSizes
      self.baseUrl = baseUrl
      self.logoSizes = logoSizes
      self.posterSizes = posterSizes
      self.profileSizes = profileSizes
      self.secureBaseUrl = secureBaseUrl
      self.stillSizes = stillSizes
    }

    // MARK: Public

    public let backdropSizes: [ImageSize]
    public let baseUrl: URL
    public let logoSizes: [ImageSize]
    public let posterSizes: [ImageSize]
    public let profileSizes: [ImageSize]
    public let secureBaseUrl: URL
    public let stillSizes: [ImageSize]

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case backdropSizes = "backdrop_sizes"
      case baseUrl = "base_url"
      case logoSizes = "logo_sizes"
      case posterSizes = "poster_sizes"
      case profileSizes = "profile_sizes"
      case secureBaseUrl = "secure_base_url"
      case stillSizes = "still_sizes"
    }
  }
}
