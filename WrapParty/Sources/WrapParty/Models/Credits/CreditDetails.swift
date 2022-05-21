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

public struct CreditDetails: Codable {
  // MARK: Lifecycle

  public init(creditType: CreditType, department: String, id: String, job: String, media: MediaListResult, mediaType: MediaType, person: PersonListResult) {
    self.creditType = creditType
    self.department = department
    self.id = id
    self.job = job
    self.media = media
    self.mediaType = mediaType
    self.person = person
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    creditType = try container.decode(CreditType.self, forKey: .creditType)
    department = try container.decode(String.self, forKey: .department)
    id = try container.decode(String.self, forKey: .id)
    job = try container.decode(String.self, forKey: .job)
    mediaType = try container.decode(MediaType.self, forKey: .mediaType)
    person = try container.decode(PersonListResult.self, forKey: .person)

    switch mediaType {
    case .tv:
      let result = try container.decode(TvListResult.self, forKey: .media)
      media = .tv(result)
    case .movie:
      let result = try container.decode(MovieListResult.self, forKey: .media)
      media = .movie(result)
    case .person:
      throw WrapPartyError.decodingError
    }
  }

  // MARK: Public

  public let creditType: CreditType
  public let department: String
  public let id: String
  public let job: String
  public let media: MediaListResult
  public let mediaType: MediaType
  public let person: PersonListResult

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case creditType = "credit_type"
    case department
    case id
    case job
    case media
    case mediaType = "media_type"
    case person
  }
}
