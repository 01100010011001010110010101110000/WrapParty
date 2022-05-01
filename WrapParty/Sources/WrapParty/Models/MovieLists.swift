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

public struct MovieList: Codable {
  // MARK: Lifecycle

  public init(resultDescription: String, favoriteCount: Int, id: Int, iso639_1: String, itemCount: Int, listType: ListType, name: String, posterPath: URL?) {
    self.resultDescription = resultDescription
    self.favoriteCount = favoriteCount
    self.id = id
    self.iso639_1 = iso639_1
    self.itemCount = itemCount
    self.listType = listType
    self.name = name
    self.posterPath = posterPath
  }

  // MARK: Public

  public enum ListType: String, Codable {
    case movie
  }

  public let resultDescription: String
  public let favoriteCount: Int
  public let id: Int
  public let iso639_1: String
  public let itemCount: Int
  public let listType: ListType
  public let name: String
  public let posterPath: URL?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case resultDescription = "description"
    case favoriteCount = "favorite_count"
    case id
    case iso639_1 = "iso_639_1"
    case itemCount = "item_count"
    case listType = "list_type"
    case name
    case posterPath = "poster_path"
  }
}
