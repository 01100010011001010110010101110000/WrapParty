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

// MARK: - TvAggregateCredits

public struct TvAggregateCredits: Codable {
  // MARK: Lifecycle

  // TODO: Disambiguate cast/crew credit type
  public init(cast: [Cast], crew: [Cast], id: Int?) {
    self.cast = cast
    self.crew = crew
    self.id = id
  }

  // MARK: Public

  public let cast: [Cast]
  public let crew: [Cast]
  public let id: Int?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case cast
    case crew
    case id
  }
}

public extension TvAggregateCredits {
  // MARK: - Cast

  struct Cast: Codable {
    // MARK: Lifecycle

    public init(adult: Bool, gender: Int, id: Int, knownForDepartment: Department, name: String, order: Int?, originalName: String, popularity: Double, profilePath: URL?, roles: [Role]?, totalEpisodeCount: Int, department: Department?, jobs: [Job]?) {
      self.adult = adult
      self.gender = gender
      self.id = id
      self.knownForDepartment = knownForDepartment
      self.name = name
      self.order = order
      self.originalName = originalName
      self.popularity = popularity
      self.profilePath = profilePath
      self.roles = roles
      self.totalEpisodeCount = totalEpisodeCount
      self.department = department
      self.jobs = jobs
    }

    // MARK: Public

    public let adult: Bool
    public let gender: Int
    public let id: Int
    public let knownForDepartment: Department
    public let name: String
    public let order: Int?
    public let originalName: String
    public let popularity: Double
    public let profilePath: URL?
    public let roles: [Role]?
    public let totalEpisodeCount: Int
    public let department: Department?
    public let jobs: [Job]?

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case adult
      case gender
      case id
      case knownForDepartment = "known_for_department"
      case name
      case order
      case originalName = "original_name"
      case popularity
      case profilePath = "profile_path"
      case roles
      case totalEpisodeCount = "total_episode_count"
      case department
      case jobs
    }
  }

  enum Department: String, Codable {
    case acting = "Acting"
    case crew = "Crew"
    case directing = "Directing"
    case production = "Production"
    case sound = "Sound"
    case writing = "Writing"
  }

  // MARK: - Job

  struct Job: Codable {
    // MARK: Lifecycle

    public init(creditId: String, episodeCount: Int, job: String) {
      self.creditId = creditId
      self.episodeCount = episodeCount
      self.job = job
    }

    // MARK: Public

    public let creditId: String
    public let episodeCount: Int
    public let job: String

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case creditId = "credit_id"
      case episodeCount = "episode_count"
      case job
    }
  }

  // MARK: - Role

  struct Role: Codable {
    // MARK: Lifecycle

    public init(character: String, creditId: String, episodeCount: Int) {
      self.character = character
      self.creditId = creditId
      self.episodeCount = episodeCount
    }

    // MARK: Public

    public let character: String
    public let creditId: String
    public let episodeCount: Int

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case character
      case creditId = "credit_id"
      case episodeCount = "episode_count"
    }
  }
}
