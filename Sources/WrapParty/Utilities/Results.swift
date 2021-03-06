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

// MARK: - Results

public struct Results<Result: Codable>: Codable {
  // MARK: Lifecycle

  init(id: Int?, results: [Result]) {
    self.id = id
    self.results = results
  }

  // MARK: Public

  public let id: Int?
  public let results: [Result]

  // MARK: Internal

  enum CodingKeys: String, CodingKey {
    case id
    case results
  }
}

// MARK: Collection

extension Results: Collection {
  public subscript(bounds: Range<Int>) -> ArraySlice<Result> {
    results[bounds]
  }
}

// MARK: RandomAccessCollection

extension Results: RandomAccessCollection {
  public typealias Element = Result

  public typealias Index = Array<Result>.Index

  public typealias SubSequence = Array<Result>.SubSequence

  public typealias Indices = Array<Result>.Indices

  public subscript(position: Array<Result>.Index) -> Array<Result>.Element {
    results[position]
  }

  public var startIndex: Array<Result>.Index {
    results.startIndex
  }

  public var endIndex: Array<Result>.Index {
    results.endIndex
  }
}
