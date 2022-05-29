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

// MARK: - DiscoveryServiceProviding

protocol DiscoveryServiceProviding: ServiceProviding {}

// MARK: - DiscoveryService

public struct DiscoveryService: DiscoveryServiceProviding {
  // MARK: Lifecycle

  public init(dataLoader: DataLoading, logger: Logger, tokenManager: TokenManager) {
    self.dataLoader = dataLoader
    self.logger = logger
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  public let dataLoader: DataLoading
  public let logger: Logger
  public let tokenManager: TokenManager

  public func discoverMovie(parameters: [MovieDiscoveryParameters] = []) async throws -> ResultPage<MovieListResult> {
    try await callEndpoint(routable: Router.movie(parameters: parameters))
  }

  public func discoverMovieSequence(parameters: [MovieDiscoveryParameters] = []) async throws -> PagedQuerySequence<MovieListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.movie(parameters: parameters))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func discoverTv(parameters: [TvDiscoveryParameters] = []) async throws -> ResultPage<TvListResult> {
    try await callEndpoint(routable: Router.tv(parameters: parameters))
  }

  public func discoverTvSequence(parameters: [TvDiscoveryParameters] = []) async throws -> PagedQuerySequence<TvListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.tv(parameters: parameters))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }
}

extension DiscoveryService {
  public enum MovieDiscoverySort: String {
    case popularityAscending = "popularity.asc"
    case popularityDescending = "popularity.desc"
    case releaseDateAscending = "release_date.asc"
    case releaseDateDescending = "release_date.desc"
    case revenueAscending = "revenue.asc"
    case revenueDescending = "revenue.desc"
    case primaryReleaseDateAscending = "primary_release_date.asc"
    case primaryReleaseDateDescending = "primary_release_date.desc"
    case originalTitleAscending = "original_title.asc"
    case originalTitleDescending = "original_title.desc"
    case voteAverageAscending = "vote_average.asc"
    case voteAverageDescending = "vote_average.desc"
    case voteCountAscending = "vote_count.asc"
    case voteCountDescending = "vote_count.desc"
  }

  public enum MovieDiscoveryParameters: UrlQueryElement {
    case language(String)
    case region(String)
    case sortBy(MovieDiscoverySort)
    case certificationCountry(String)
    case certification(String)
    case certificationLessThan(String)
    case certificationGreaterThan(String)
    case includeAdult(Bool)
    case includeVideo(Bool)
    case page(Int)
    case primaryReleaseYear(Int)
    case primaryReleaseDateLessThan(Date)
    case primaryReleaseDateGreaterThan(Date)
    case releaseDateLessThan(Date)
    case releaseDateGreaterThan(Date)
    case withReleaseType(CountryRelease.ReleaseDate.ReleaseType)
    case year(Int)
    case voteCountLessThan(Int)
    case voteCountGreaterThan(Int)
    case voteAverageLessThan(Int)
    case voteAverageGreaterThan(Int)
    case withCast(Set<Int>)
    case withCrew(Set<Int>)
    case withPeople(Set<Int>)
    case withCompanies(Set<Int>)
    case withoutCompanies(Set<Int>)
    case withGenres(Set<Int>)
    case withoutGenres(Set<Int>)
    case withKeywords(Set<Int>)
    case withoutKeywords(Set<Int>)
    case withRuntimeGreaterThan(Int)
    case withRuntimeLessThan(Int)
    case withOriginalLanguage(String)
    case withWatchProviders(Set<Int>)
    case watchRegion(String)
    case withWatchMonetizationTypes(Set<WatchProviders.MonetizationType>)

    // MARK: Internal

    var queryKey: String {
      switch self {
      case .language:
        return "language"
      case .region:
        return "region"
      case .sortBy:
        return "sort_by"
      case .certificationCountry:
        return "certification_country"
      case .certification:
        return "certification"
      case .certificationLessThan:
        return "certification.lte"
      case .certificationGreaterThan:
        return "certification.gte"
      case .includeAdult:
        return "include_adult"
      case .includeVideo:
        return "include_video"
      case .page:
        return "page"
      case .primaryReleaseYear:
        return "primary_release_year"
      case .primaryReleaseDateLessThan:
        return "primary_release_year.lte"
      case .primaryReleaseDateGreaterThan:
        return "primary_release_year.get"
      case .releaseDateLessThan:
        return "release_year.lte"
      case .releaseDateGreaterThan:
        return "release_year.gte"
      case .withReleaseType:
        return "with_release_type"
      case .year:
        return "year"
      case .voteCountLessThan:
        return "vote_count.lte"
      case .voteCountGreaterThan:
        return "vote_count.gte"
      case .voteAverageLessThan:
        return "vote_average.lte"
      case .voteAverageGreaterThan:
        return "vote_average.gte"
      case .withCast:
        return "with_case"
      case .withCrew:
        return "with_crew"
      case .withPeople:
        return "with_people"
      case .withCompanies:
        return "with_companies"
      case .withoutCompanies:
        return "without_companies"
      case .withGenres:
        return "with_genres"
      case .withoutGenres:
        return "without_genres"
      case .withKeywords:
        return "with_keywords"
      case .withoutKeywords:
        return "without_keywords"
      case .withRuntimeGreaterThan:
        return "with_runtime.gte"
      case .withRuntimeLessThan:
        return "with_runtime.lte"
      case .withOriginalLanguage:
        return "with_original_language"
      case .withWatchProviders:
        return "with_watch_providers"
      case .watchRegion:
        return "watch_region"
      case .withWatchMonetizationTypes:
        return "with_watch_monetization_types"
      }
    }

    var queryValue: String {
      switch self {
      case let .language(language):
        return language
      case let .region(region):
        return region
      case let .sortBy(sortBy):
        return sortBy.rawValue
      case let .certificationCountry(certificationCountry):
        return certificationCountry
      case let .certification(certification):
        return certification
      case let .certificationLessThan(certification):
        return certification
      case let .certificationGreaterThan(certification):
        return certification
      case let .includeAdult(includeAdult):
        return String(includeAdult)
      case let .includeVideo(video):
        return String(video)
      case let .page(page):
        return String(page)
      case let .primaryReleaseYear(year):
        return String(year)
      case let .primaryReleaseDateLessThan(date):
        return date.formatted(WrapParty.tmdbDefaultDateFormat)
      case let .primaryReleaseDateGreaterThan(date):
        return date.formatted(WrapParty.tmdbDefaultDateFormat)
      case let .releaseDateLessThan(date):
        return date.formatted(WrapParty.tmdbDefaultDateFormat)
      case let .releaseDateGreaterThan(date):
        return date.formatted(WrapParty.tmdbDefaultDateFormat)
      case let .withReleaseType(type):
        return String(type.rawValue)
      case let .year(year):
        return String(year)
      case let .voteCountLessThan(count):
        return String(count)
      case let .voteCountGreaterThan(count):
        return String(count)
      case let .voteAverageLessThan(average):
        return String(average)
      case let .voteAverageGreaterThan(average):
        return String(average)
      case let .withCast(castIds):
        return castIds.map(String.init).joined(separator: ",")
      case let .withCrew(crewIds):
        return crewIds.map(String.init).joined(separator: ",")
      case let .withPeople(peopleIds):
        return peopleIds.map(String.init).joined(separator: ",")
      case let .withCompanies(companyIds):
        return companyIds.map(String.init).joined(separator: ",")
      case let .withoutCompanies(companyIds):
        return companyIds.map(String.init).joined(separator: ",")
      case let .withGenres(genreIds):
        return genreIds.map(String.init).joined(separator: ",")
      case let .withoutGenres(genreIds):
        return genreIds.map(String.init).joined(separator: ",")
      case let .withKeywords(keywords):
        return keywords.map(String.init).joined(separator: ",")
      case let .withoutKeywords(keywords):
        return keywords.map(String.init).joined(separator: ",")
      case let .withRuntimeGreaterThan(runtime):
        return String(runtime)
      case let .withRuntimeLessThan(runtime):
        return String(runtime)
      case let .withOriginalLanguage(language):
        return language
      case let .withWatchProviders(providerIds):
        return providerIds.map(String.init).joined(separator: ",")
      case let .watchRegion(region):
        return region
      case let .withWatchMonetizationTypes(types):
        return types.map(\.rawValue).joined(separator: ",")
      }
    }
  }

  public enum TvDiscoverySort: String {
    case popularityAscending = "popularity.asc"
    case popularityDescending = "popularity.desc"
    case firstAirDateAscending = "first_air_date.asc"
    case firstAirDateDescending = "first_air_date.desc"
    case voteAverageAscending = "vote_average.asc"
    case voteAverageDescending = "vote_average.desc"
  }

  public enum TvDiscoveryParameters: UrlQueryElement {
    case language(String)
    case sortBy(TvDiscoverySort)
    case page(Int)
    case airDateLessThan(Date)
    case airDateGreaterThan(Date)
    case firstAirDateLessThan(Date)
    case firstAirDateGreaterThan(Date)
    case firstAirDateYear(Int)
    case includeNullFirstAirDate(Bool)
    case screenedTheatrically(Bool)
    case timezone(String)
    case voteCountLessThan(Int)
    case voteCountGreaterThan(Int)
    case voteAverageLessThan(Int)
    case voteAverageGreaterThan(Int)
    case withCast(Set<Int>)
    case withCrew(Set<Int>)
    case withPeople(Set<Int>)
    case withCompanies(Set<Int>)
    case withoutCompanies(Set<Int>)
    case withNetworks(Set<Int>)
    case withGenres(Set<Int>)
    case withoutGenres(Set<Int>)
    case withKeywords(Set<Int>)
    case withoutKeywords(Set<Int>)
    case withRuntimeGreaterThan(Int)
    case withRuntimeLessThan(Int)
    case withOriginalLanguage(String)
    case withWatchProviders(Set<Int>)
    case watchRegion(String)
    case withStatus(TvShow.ShowStatus)
    case withType(TvShow.ShowType)
    case withWatchMonetizationTypes(Set<WatchProviders.MonetizationType>)

    // MARK: Internal

    var queryKey: String {
      switch self {
      case .language:
        return "language"
      case .page:
        return "page"
      case .voteCountLessThan:
        return "vote_count.lte"
      case .voteCountGreaterThan:
        return "vote_count.gte"
      case .voteAverageLessThan:
        return "vote_average.lte"
      case .voteAverageGreaterThan:
        return "vote_average.gte"
      case .withCast:
        return "with_case"
      case .withCrew:
        return "with_crew"
      case .withPeople:
        return "with_people"
      case .withCompanies:
        return "with_companies"
      case .withoutCompanies:
        return "without_companies"
      case .withGenres:
        return "with_genres"
      case .withoutGenres:
        return "without_genres"
      case .withKeywords:
        return "with_keywords"
      case .withoutKeywords:
        return "without_keywords"
      case .withRuntimeGreaterThan:
        return "with_runtime.gte"
      case .withRuntimeLessThan:
        return "with_runtime.lte"
      case .withOriginalLanguage:
        return "with_original_language"
      case .withWatchProviders:
        return "with_watch_providers"
      case .watchRegion:
        return "watch_region"
      case .withWatchMonetizationTypes:
        return "with_watch_monetization_types"
      case .sortBy:
        return "sort_by"
      case .airDateLessThan:
        return "air_date.lte"
      case .airDateGreaterThan:
        return "air_date.gte"
      case .firstAirDateLessThan:
        return "first_air_date.lte"
      case .firstAirDateGreaterThan:
        return "first_air_date.gte"
      case .firstAirDateYear:
        return "first_air_date_year"
      case .includeNullFirstAirDate:
        return "include_null_first_air_dates"
      case .screenedTheatrically:
        return "screened_theatrically"
      case .timezone:
        return "timezone"
      case .withNetworks:
        return "with_networks"
      case .withStatus:
        return "with_status"
      case .withType:
        return "with_type"
      }
    }

    var queryValue: String {
      switch self {
      case let .language(language):
        return language
      case let .sortBy(sortBy):
        return sortBy.rawValue
      case let .page(page):
        return String(page)
      case let .firstAirDateYear(year):
        return String(year)
      case let .firstAirDateLessThan(date):
        return date.formatted(WrapParty.tmdbDefaultDateFormat)
      case let .firstAirDateGreaterThan(date):
        return date.formatted(WrapParty.tmdbDefaultDateFormat)
      case let .includeNullFirstAirDate(include):
        return String(include)
      case let .voteCountLessThan(count):
        return String(count)
      case let .voteCountGreaterThan(count):
        return String(count)
      case let .voteAverageLessThan(average):
        return String(average)
      case let .voteAverageGreaterThan(average):
        return String(average)
      case let .withCast(castIds):
        return castIds.map(String.init).joined(separator: ",")
      case let .withCrew(crewIds):
        return crewIds.map(String.init).joined(separator: ",")
      case let .withPeople(peopleIds):
        return peopleIds.map(String.init).joined(separator: ",")
      case let .withCompanies(companyIds):
        return companyIds.map(String.init).joined(separator: ",")
      case let .withoutCompanies(companyIds):
        return companyIds.map(String.init).joined(separator: ",")
      case let .withGenres(genreIds):
        return genreIds.map(String.init).joined(separator: ",")
      case let .withoutGenres(genreIds):
        return genreIds.map(String.init).joined(separator: ",")
      case let .withKeywords(keywords):
        return keywords.map(String.init).joined(separator: ",")
      case let .withoutKeywords(keywords):
        return keywords.map(String.init).joined(separator: ",")
      case let .withRuntimeGreaterThan(runtime):
        return String(runtime)
      case let .withRuntimeLessThan(runtime):
        return String(runtime)
      case let .withOriginalLanguage(language):
        return language
      case let .withWatchProviders(providerIds):
        return providerIds.map(String.init).joined(separator: ",")
      case let .watchRegion(region):
        return region
      case let .withWatchMonetizationTypes(types):
        return types.map(\.rawValue).joined(separator: ",")
      case let .airDateLessThan(date):
        return date.formatted(WrapParty.tmdbDefaultDateFormat)
      case let .airDateGreaterThan(date):
        return date.formatted(WrapParty.tmdbDefaultDateFormat)
      case let .screenedTheatrically(screenedTheatrically):
        return String(screenedTheatrically)
      case let .timezone(tz):
        return tz
      case let .withNetworks(networkIds):
        return networkIds.map(String.init).joined(separator: ",")
      case let .withStatus(status):
        return String(status.rawValue)
      case let .withType(type):
        return String(type.rawValue)
      }
    }
  }
}

extension DiscoveryService {
  enum Router: RequestRoutable {
    case movie(parameters: [MovieDiscoveryParameters])
    case tv(parameters: [TvDiscoveryParameters])

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .movie(parameters):
        return componentsForRoute(path: "discover/movie", queryItems: parameters.toQueryItems()).url!
      case let .tv(parameters):
        return componentsForRoute(path: "discover/tv", queryItems: parameters.toQueryItems()).url!
      }
    }
  }
}
