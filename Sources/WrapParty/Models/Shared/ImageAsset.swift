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

// MARK: - ImageAsset

public struct ImageAsset: Codable {
  // MARK: Lifecycle

  public init(aspectRatio: Double, filePath: String, fileType: FileType, height: Int, iso639_1: String?, voteAverage: Double, voteCount: Int, width: Int) {
    self.aspectRatio = aspectRatio
    self.filePath = filePath
    self.fileType = fileType
    self.height = height
    self.iso639_1 = iso639_1
    self.voteAverage = voteAverage
    self.voteCount = voteCount
    self.width = width
  }

  // MARK: Public

  public let aspectRatio: Double
  public let filePath: String
  public let fileType: FileType?
  public let height: Int
  public let iso639_1: String?
  public let voteAverage: Double
  public let voteCount: Int
  public let width: Int

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case aspectRatio = "aspect_ratio"
    case filePath = "file_path"
    case fileType = "file_type"
    case height
    case iso639_1 = "iso_639_1"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    case width
  }
}

public extension ImageAsset {
  /// File type of the originally uploaded asset
  enum FileType: String, Codable {
    case png = ".png"
    case svg = ".svg"
  }
}
