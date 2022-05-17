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

// MARK: - MediaTranslations

public struct MediaTranslations: Codable {
  // MARK: Lifecycle

  public init(id: Int?, translations: [Translation]) {
    self.id = id
    self.translations = translations
  }

  // MARK: Public

  public let id: Int?
  public let translations: [Translation]

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case id
    case translations
  }
}

// MARK: - Translation

public struct Translation: Codable {
  // MARK: Lifecycle

  public init(data: TranslationData, englishName: String, iso3166_1: String, iso639_1: String, name: String) {
    self.data = data
    self.englishName = englishName
    self.iso3166_1 = iso3166_1
    self.iso639_1 = iso639_1
    self.name = name
  }

  // MARK: Public

  public let data: TranslationData
  public let englishName: String
  public let iso3166_1: String
  public let iso639_1: String
  public let name: String

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case data
    case englishName = "english_name"
    case iso3166_1 = "iso_3166_1"
    case iso639_1 = "iso_639_1"
    case name
  }
}

// MARK: - TranslationData

public struct TranslationData: Codable {
  // MARK: Lifecycle

  public init(homepage: String, overview: String, runtime: Int?, tagline: String, title: String?) {
    self.homepage = homepage
    self.overview = overview
    self.runtime = runtime
    self.tagline = tagline
    self.title = title
  }

  // MARK: Public

  public let homepage: String
  public let overview: String
  public let runtime: Int?
  public let tagline: String
  public let title: String?

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case homepage
    case overview
    case runtime
    case tagline
    case title
  }
}
