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

// MARK: - MovieExternalId

public struct ExternalIds: Codable {
  // MARK: Lifecycle

  public init(facebookId: String?, id: Int?, imdbId: String?, instagramId: String?, tvdbId: Int?, twitterId: String?) {
    self.facebookId = facebookId
    self.id = id
    self.imdbId = imdbId
    self.instagramId = instagramId
    self.tvdbId = tvdbId
    self.twitterId = twitterId
  }

  // MARK: Public

  public let facebookId: String?
  public let id: Int?
  public let imdbId: String?
  public let instagramId: String?
  public let tvdbId: Int?
  public let twitterId: String?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case facebookId = "facebook_id"
    case id
    case imdbId = "imdb_id"
    case instagramId = "instagram_id"
    case tvdbId = "tvdb_id"
    case twitterId = "twitter_id"
  }
}
