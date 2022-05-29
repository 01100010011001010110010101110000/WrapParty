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
import Logging

public class WrapParty {
  // MARK: Lifecycle

  public init<C: Configuration>(configuration: C) {
    loader = configuration.loader
    logger = configuration.logger
    tokenManager = TokenManager(token: configuration.apiToken)
  }

  public convenience init() {
    let configuration = DefaultConfiguration()
    self.init(configuration: configuration)
  }

  // MARK: Public

  public let loader: DataLoading
  public let logger: Logger

  // MARK: Internal

  static let baseUrl = URL(string: "https://api.themoviedb.org/3/")!
  static let tmdbDefaultDateFormat: Date.ISO8601FormatStyle = .iso8601.year().month().day()
  static let jsonDecoder = { () -> JSONDecoder in
    var decoder = JSONDecoder()
    return decoder
  }()

  // MARK: Private

  private let tokenManager: TokenManager
}

public extension WrapParty {
  func tmdbConfiguration() async throws -> TmdbConfiguration {
    try await configurationService().configuration()
  }
}

public extension WrapParty {
  func certificationService() -> CertificationService { CertificationService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func changesService() -> ChangesService { ChangesService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func collectionService() -> CollectionService { CollectionService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func companyService() -> CompanyService { CompanyService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func configurationService() -> ConfigurationService { ConfigurationService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func creditService() -> CreditService { CreditService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func discoveryService() -> DiscoveryService { DiscoveryService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func findService() -> FindService { FindService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func genreService() -> GenreService { GenreService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func keywordService() -> KeywordService { KeywordService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func movieService() -> MovieService { MovieService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func networkService() -> NetworkService { NetworkService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func personService() -> PersonService { PersonService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func reviewService() -> ReviewService { ReviewService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func searchService() -> SearchService { SearchService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func trendingService() -> TrendingService { TrendingService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func tvEpisodeGroupService() -> TvEpisodeGroupService { TvEpisodeGroupService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func tvEpisodeService() -> TvEpisodeService { TvEpisodeService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func tvSeasonService() -> TvSeasonService { TvSeasonService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func tvService() -> TvService { TvService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
  func watchProviderService() -> WatchProviderService { WatchProviderService(dataLoader: loader, logger: logger, tokenManager: tokenManager) }
}
