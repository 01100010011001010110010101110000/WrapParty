//
// Created by Tyler Gregory on 5/31/22.
//

import Foundation

public protocol WrapPartyProviding {
  func certificationService() -> CertificationService
  func changesService() -> ChangesService
  func collectionService() -> CollectionService
  func companyService() -> CompanyService
  func configurationService() -> ConfigurationService
  func creditService() -> CreditService
  func discoveryService() -> DiscoveryService
  func findService() -> FindService
  func genreService() -> GenreService
  func keywordService() -> KeywordService
  func movieService() -> MovieService
  func networkService() -> NetworkService
  func personService() -> PersonService
  func reviewService() -> ReviewService
  func searchService() -> SearchService
  func trendingService() -> TrendingService
  func tvEpisodeGroupService() -> TvEpisodeGroupService
  func tvEpisodeService() -> TvEpisodeService
  func tvSeasonService() -> TvSeasonService
  func tvService() -> TvService
  func watchProviderService() -> WatchProviderService
}

public extension WrapPartyProviding {
  func tmdbConfiguration() async throws -> TmdbConfiguration {
    try await configurationService().configuration()
  }
}
