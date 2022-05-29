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

// MARK: - SearchServiceProviding

protocol SearchServiceProviding: ServiceProviding {}

// MARK: - SearchService

public struct SearchService: SearchServiceProviding {
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

  public func searchMovies(matching query: String, parameters: [MovieSearchParams] = []) async throws -> ResultPage<Movie> {
    try await callEndpoint(routable: Router.movies(query: query, parameters: parameters))
  }

  public func allMovieSearchResults(matching query: String, parameters: [MovieSearchParams] = []) async throws -> [Movie] {
    try await searchMovieSequence(matching: query, parameters: parameters).allResults()
  }

  public func searchMovieSequence(matching query: String, parameters: [MovieSearchParams] = []) async -> PagedQuerySequence<Movie> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.movies(query: query, parameters: parameters))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func searchMultiple(matching query: String, parameters: [MultiSearchParams] = []) async throws -> ResultPage<InlineMediaListResult> {
    try await callEndpoint(routable: Router.multiple(query: query, parameters: parameters))
  }

  public func allMultiSearchResults(matching query: String, parameters: [MultiSearchParams] = []) async throws -> [InlineMediaListResult] {
    try await searchMultipleSequence(matching: query, parameters: parameters).allResults()
  }

  public func searchMultipleSequence(matching query: String, parameters: [MultiSearchParams] = []) async -> PagedQuerySequence<InlineMediaListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.multiple(query: query, parameters: parameters))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func searchPeople(matching query: String, parameters: [PeopleSearchParams] = []) async throws -> ResultPage<PersonListResult> {
    try await callEndpoint(routable: Router.people(query: query, parameters: parameters))
  }

  public func allPeopleSearchResults(matching query: String, parameters: [PeopleSearchParams] = []) async throws -> [PersonListResult] {
    try await searchPeopleSequence(matching: query, parameters: parameters).allResults()
  }

  public func searchPeopleSequence(matching query: String, parameters: [PeopleSearchParams] = []) async -> PagedQuerySequence<PersonListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.people(query: query, parameters: parameters))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func searchTv(matching query: String, parameters: [TvSearchParams] = []) async throws -> ResultPage<TvListResult> {
    try await callEndpoint(routable: Router.tv(query: query, parameters: parameters))
  }

  public func allTvSearchResults(matching query: String, parameters: [TvSearchParams] = []) async throws -> [TvListResult] {
    try await searchTvSequence(matching: query, parameters: parameters).allResults()
  }

  public func searchTvSequence(matching query: String, parameters: [TvSearchParams] = []) async -> PagedQuerySequence<TvListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.tv(query: query, parameters: parameters))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func searchCompanies(matching query: String, page: Int? = nil) async throws -> ResultPage<CompanyListResult> {
    try await callEndpoint(routable: Router.companies(query: query, page: page))
  }

  public func allCompanySearchResults(matching query: String) async throws -> [CompanyListResult] {
    try await searchCompaniesSequence(matching: query, page: 1).allResults()
  }

  public func searchCompaniesSequence(matching query: String, page: Int? = nil) async throws -> PagedQuerySequence<CompanyListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.companies(query: query, page: page))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func searchCollections(matching query: String, language: String? = nil, page: Int? = nil) async throws -> ResultPage<CollectionListResult> {
    try await callEndpoint(routable: Router.collections(query: query, language: language, page: page))
  }

  public func allCollectionSearchResults(matching query: String, language: String? = nil) async throws -> [CollectionListResult] {
    try await searchCollectionsSequence(matching: query, language: language).allResults()
  }

  public func searchCollectionsSequence(matching query: String, language: String? = nil, page: Int? = nil) async throws -> PagedQuerySequence<CollectionListResult> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.collections(query: query, language: language, page: page))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }

  public func searchKeywords(matching query: String, page: Int? = nil) async throws -> ResultPage<Keyword> {
    try await callEndpoint(routable: Router.keywords(query: query, page: page))
  }

  public func allKeywordSearchResults(matching query: String) async throws -> [Keyword] {
    try await searchKeywordsSequence(matching: query).allResults()
  }

  public func searchKeywordsSequence(matching query: String, page: Int? = nil) async throws -> PagedQuerySequence<Keyword> {
    let request = await tokenManager.vendAuthenticatedRequest(for: Router.keywords(query: query, page: page))
    return .init(initialRequest: request, dataLoader: dataLoader, logger: logger)
  }
}

// MARK: - UrlQueryElement

protocol UrlQueryElement {
  var queryKey: String { get }
  var queryValue: String { get }
}

extension SearchService {
  public enum TvSearchParams: UrlQueryElement {
    case language(String)
    case page(Int)
    case includeAdult(Bool)
    case firstAirDateYear(Int)

    // MARK: Internal

    var queryKey: String {
      switch self {
      case .language:
        return "language"
      case .page:
        return "page"
      case .includeAdult:
        return "include_adult"
      case .firstAirDateYear:
        return "first_air_date_year"
      }
    }

    var queryValue: String {
      switch self {
      case let .language(language):
        return language
      case let .page(page):
        return String(page)
      case let .includeAdult(includeAdult):
        return String(includeAdult)
      case let .firstAirDateYear(year):
        return String(year)
      }
    }
  }

  public enum PeopleSearchParams: UrlQueryElement {
    case language(String)
    case page(Int)
    case includeAdult(Bool)
    case region(String)

    // MARK: Internal

    var queryKey: String {
      switch self {
      case .language:
        return "language"
      case .page:
        return "page"
      case .includeAdult:
        return "include_adult"
      case .region:
        return "region"
      }
    }

    var queryValue: String {
      switch self {
      case let .language(language):
        return language
      case let .page(page):
        return String(page)
      case let .includeAdult(includeAdult):
        return String(includeAdult)
      case let .region(region):
        return region
      }
    }
  }

  public enum MultiSearchParams: UrlQueryElement {
    case language(String)
    case page(Int)
    case includeAdult(Bool)
    case region(String)

    // MARK: Internal

    var queryKey: String {
      switch self {
      case .language:
        return "language"
      case .page:
        return "page"
      case .includeAdult:
        return "include_adult"
      case .region:
        return "region"
      }
    }

    var queryValue: String {
      switch self {
      case let .language(language):
        return language
      case let .page(page):
        return String(page)
      case let .includeAdult(includeAdult):
        return String(includeAdult)
      case let .region(region):
        return region
      }
    }
  }

  public enum MovieSearchParams: UrlQueryElement {
    case language(String)
    case page(Int)
    case includeAdult(Bool)
    case region(String)
    case year(Int)
    case primaryReleaseYear(Int)

    // MARK: Internal

    var queryKey: String {
      switch self {
      case .language:
        return "language"
      case .page:
        return "page"
      case .includeAdult:
        return "include_adult"
      case .region:
        return "region"
      case .year:
        return "year"
      case .primaryReleaseYear:
        return "primary_release_year"
      }
    }

    var queryValue: String {
      switch self {
      case let .language(language):
        return language
      case let .page(page):
        return String(page)
      case let .includeAdult(includeAdult):
        return String(includeAdult)
      case let .region(region):
        return region
      case let .year(year):
        return String(year)
      case let .primaryReleaseYear(primaryReleaseYear):
        return String(primaryReleaseYear)
      }
    }
  }
}

extension Collection where Element: UrlQueryElement {
  func toQueryItems() -> [String: String] {
    var results: [String: String] = Dictionary(minimumCapacity: count)
    forEach { results[$0.queryKey] = $0.queryValue }
    return results
  }
}

extension SearchService {
  enum Router: RequestRoutable {
    case movies(query: String, parameters: [MovieSearchParams])
    case tv(query: String, parameters: [TvSearchParams])
    case people(query: String, parameters: [PeopleSearchParams])
    case multiple(query: String, parameters: [MultiSearchParams])
    case companies(query: String, page: Int?)
    case collections(query: String, language: String?, page: Int?)
    case keywords(query: String, page: Int?)

    // MARK: Internal

    func asUrl() -> URL {
      switch self {
      case let .movies(query, parameters):
        var queryItems = parameters.toQueryItems()
        queryItems["query"] = query
        return componentsForRoute(path: "search/movie", queryItems: queryItems).url!
      case let .tv(query, parameters):
        var queryItems = parameters.toQueryItems()
        queryItems["query"] = query
        return componentsForRoute(path: "search/tv", queryItems: queryItems).url!
      case let .people(query, parameters):
        var queryItems = parameters.toQueryItems()
        queryItems["query"] = query
        return componentsForRoute(path: "search/person", queryItems: queryItems).url!
      case let .multiple(query, parameters):
        var queryItems = parameters.toQueryItems()
        queryItems["query"] = query
        return componentsForRoute(path: "search/multi", queryItems: queryItems).url!
      case let .companies(query, page):
        return componentsForRoute(path: "search/company", queryItems: [
          "page": page.map { String($0) },
          "query": query,
        ]).url!
      case let .collections(query, language, page):
        return componentsForRoute(path: "search/collection", queryItems: [
          "page": page.map { String($0) },
          "query": query,
          "language": language,
        ]).url!
      case let .keywords(query, page):
        return componentsForRoute(path: "search/keyword", queryItems: [
          "page": page.map { String($0) },
          "query": query,
        ]).url!
      }
    }
  }
}
