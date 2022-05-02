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

// MARK: - ResultPage

public struct ResultPage<Result: Codable>: Codable {
  // MARK: Lifecycle

  init(id: Int?, page: Int, results: [Result], totalPages: Int, totalResults: Int) {
    self.id = id
    self.page = page
    self.results = results
    self.totalPages = totalPages
    self.totalResults = totalResults
  }

  // MARK: Public

  public let id: Int?
  public let page: Int
  public let results: [Result]
  public let totalPages: Int
  public let totalResults: Int

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case id
    case page
    case results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - PagedQuerySequence

public struct PagedQuerySequence<Result: Codable>: AsyncSequence {
  public typealias Element = ResultPage<Result>

  public let initialRequest: URLRequest
  public let dataLoader: DataLoading

  public func makeAsyncIterator() -> PagedQueryIterator<Result> { PagedQueryIterator(initialRequest: initialRequest, dataLoader: dataLoader) }
}

public extension PagedQuerySequence {
  struct PagedQueryIterator<Result: Codable>: AsyncIteratorProtocol {
    // MARK: Lifecycle

    public init(initialRequest: URLRequest, dataLoader: DataLoading) {
      request = initialRequest
      self.dataLoader = dataLoader
    }

    // MARK: Public

    public let dataLoader: DataLoading
    public private(set) var request: URLRequest
    public private(set) var page = 0
    public private(set) var totalPages = Int.max
    public private(set) var totalResults = -1

    public mutating func next() async throws -> ResultPage<Result>? {
      guard page <= totalPages else { return nil }

      let (data, response) = try await dataLoader.loadData(for: request)
      let result = try WrapParty.jsonDecode(ResultPage<Result>.self, from: data)

      page = result.page + 1
      // This questionable, might need to set only once
      totalPages = result.totalPages
      totalResults = result.totalResults
      updateRequest()

      return result
    }

    // MARK: Private

    private mutating func updateRequest() {
      var components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!
      components.queryItems?.removeAll { $0.name.caseInsensitiveCompare("page") == .orderedSame }
      components.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
      var result = request
      result.url = components.url!
      request = result
    }
  }
}
