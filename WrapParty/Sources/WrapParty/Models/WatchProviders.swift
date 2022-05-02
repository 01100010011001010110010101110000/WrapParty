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

// MARK: - WatchProviders

public struct WatchProviders: Codable {
  // MARK: Lifecycle

  public init(id: Int?, results: ProviderLocaleMap) {
    self.id = id
    self.results = results
  }

  // MARK: Public

  public typealias ProviderLocaleMap = [String: ProviderData]

  public let id: Int?
  public let results: ProviderLocaleMap

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case id
    case results
  }
}

public extension WatchProviders {
  struct ProviderData: Codable {
    // MARK: Lifecycle

    public init(buy: [Provider]?, flatRate: [Provider]?, link: URL, rent: [Provider]?) {
      self.buy = buy
      self.flatRate = flatRate
      self.link = link
      self.rent = rent
    }

    // MARK: Public

    public let buy: [Provider]?
    public let flatRate: [Provider]?
    public let link: URL
    public let rent: [Provider]?

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case buy
      case flatRate = "flatrate"
      case link
      case rent
    }
  }

  struct Provider: Codable {
    // MARK: Lifecycle

    public init(displayPriority: Int, logoPath: URL, providerId: Int, providerName: String) {
      self.displayPriority = displayPriority
      self.logoPath = logoPath
      self.providerId = providerId
      self.providerName = providerName
    }

    // MARK: Public

    public let displayPriority: Int
    public let logoPath: URL
    public let providerId: Int
    public let providerName: String

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
      case displayPriority = "display_priority"
      case logoPath = "logo_path"
      case providerId = "provider_id"
      case providerName = "provider_name"
    }
  }
}
