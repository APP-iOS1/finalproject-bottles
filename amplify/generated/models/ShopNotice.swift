// swiftlint:disable all
import Amplify
import Foundation

public struct ShopNotice: Model {
  public let id: String
  public var title: String?
  public var body: String?
  public var Image: String?
  public var date: Temporal.DateTime?
  public var shopID: String
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      title: String? = nil,
      body: String? = nil,
      Image: String? = nil,
      date: Temporal.DateTime? = nil,
      shopID: String) {
    self.init(id: id,
      title: title,
      body: body,
      Image: Image,
      date: date,
      shopID: shopID,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      title: String? = nil,
      body: String? = nil,
      Image: String? = nil,
      date: Temporal.DateTime? = nil,
      shopID: String,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.title = title
      self.body = body
      self.Image = Image
      self.date = date
      self.shopID = shopID
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}