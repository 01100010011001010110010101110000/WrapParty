//
// Created by Tyler Gregory on 6/15/22.
//

extension Collection {
  var tail: SubSequence? {
    guard count > 1 else { return nil }
    let offset = index(startIndex, offsetBy: 1)
    return self[offset...]
  }
}
