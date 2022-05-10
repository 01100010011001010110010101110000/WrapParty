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

// MARK: - ServiceProviding

protocol ServiceProviding {
  var dataLoader: DataLoading { get }
  var logger: Logger { get }
  var tokenManager: TokenManager { get }
}

extension ServiceProviding {
  func callEndpoint<R: RequestRoutable, Result: Codable>(routable: R) async throws -> Result {
    let request = await tokenManager.vendAuthenticatedRequest(for: routable)
    // TODO: - Implement response status code checking
    logger.log(level: .debug, "Fetching \(request)")
    let (data, response) = try await dataLoader.loadData(for: request)
    logger.log(level: .debug, "Completed fetching \(request)")
    return try jsonDecode(Result.self, from: data)
  }

  func jsonDecode<T>(_ type: T.Type, with decoder: JSONDecoder = WrapParty.jsonDecoder, from data: Data) throws -> T where T: Decodable {
    do {
      return try decoder.decode(type, from: data)
    } catch let error as DecodingError {
      logger.log(level: .error, "\(error.localizedDescription)")
      throw error
    }
  }
}
