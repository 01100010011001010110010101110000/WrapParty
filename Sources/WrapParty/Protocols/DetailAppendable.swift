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

/// Conforming services support TMDB's `append_to_response` query parameter on their detail endpoint
public protocol DetailAppendable: ServiceProviding {
  /// The model this service vends
  associatedtype DetailModel: Identifiable & Codable
  associatedtype Appendable: Hashable & RawRepresentable where Appendable.RawValue == String

  func details(for id: DetailModel.ID, including: Set<Appendable>) async throws -> DetailModel
}
