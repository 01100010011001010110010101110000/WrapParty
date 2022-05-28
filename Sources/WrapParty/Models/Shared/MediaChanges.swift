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

// MARK: - MediaChanges

public struct MediaChanges: Codable {
  // MARK: Lifecycle

  public init(changes: [Change]) {
    self.changes = changes
  }

  // MARK: Public

  public let changes: [Change]

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case changes
  }
}

public extension MediaChanges {
  // MARK: - Change

  struct Change: Codable {
    // MARK: Lifecycle

    public init(items: [Item], key: String) {
      self.items = items
      self.key = key
    }

    // MARK: Public

    public let items: [Item]
    public let key: String

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case items
      case key
    }
  }
}

public extension MediaChanges.Change {
  // MARK: - Item

  struct Item: Codable {
    // MARK: Lifecycle

    public init(action: Action, id: String, iso3166_1: String, iso639_1: String, time: String) {
      self.action = action
      self.id = id
      self.iso3166_1 = iso3166_1
      self.iso639_1 = iso639_1
      self.time = time
//      self.value = value
//      self.originalValue = originalValue
    }

    // MARK: Public

    public let action: Action
    public let id: String
    public let iso3166_1: String
    public let iso639_1: String
    public let time: String

    // MARK: Internal

    // TODO: - Model these appropriately
//    public let value: Dictionary<String, Any>?
//    public let originalValue: Dictionary<String, Any>?

    enum CodingKeys: String, CodingKey {
      case action
      case id
      case iso3166_1 = "iso_3166_1"
      case iso639_1 = "iso_639_1"
      case time
//      case value = "value"
//      case originalValue = "original_value"
    }
  }

  enum Action: String, Codable {
    case added
    case deleted
    case updated
  }
}
