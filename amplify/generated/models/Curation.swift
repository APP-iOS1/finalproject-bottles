// swiftlint:disable all
import Amplify
import Foundation

public struct Curation: Embeddable {
  var shopCurationTitle: String?
  var shopCurationBody: String?
  var shopCurationImage: String?
  var shopCurationBottleID: [String?]?
}