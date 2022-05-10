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

// MARK: - MovieReview

public struct MovieReview: Codable {
  // MARK: Lifecycle

  public init(author: String, authorDetails: AuthorDetails, content: String, createdAt: String, id: String, updatedAt: String, url: URL) {
    self.author = author
    self.authorDetails = authorDetails
    self.content = content
    self.createdAt = createdAt
    self.id = id
    self.updatedAt = updatedAt
    self.url = url
  }

  // MARK: Public

  public let author: String
  public let authorDetails: AuthorDetails
  public let content: String
  public let createdAt: String
  public let id: String
  public let updatedAt: String
  public let url: URL

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case author
    case authorDetails = "author_details"
    case content
    case createdAt = "created_at"
    case id
    case updatedAt = "updated_at"
    case url
  }
}

public extension MovieReview {
  // MARK: - AuthorDetails

  struct AuthorDetails: Codable {
    // MARK: Lifecycle

    public init(avatarPath: URL, name: String, rating: Int, username: String) {
      self.avatarPath = avatarPath
      self.name = name
      self.rating = rating
      self.username = username
    }

    // MARK: Public

    public let avatarPath: URL
    public let name: String
    public let rating: Int
    public let username: String

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case avatarPath = "avatar_path"
      case name
      case rating
      case username
    }
  }
}
