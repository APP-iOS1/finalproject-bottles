// swiftlint:disable all
import Amplify
import Foundation

public struct ShopNotice: Embeddable {
  var id: String?
  var title: String?
  var body: String?
  var createDate: Temporal.DateTime?
}