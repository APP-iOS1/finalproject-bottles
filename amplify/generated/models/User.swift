// swiftlint:disable all
import Amplify
import Foundation

public struct User: Model {
  public let id: String
  public var email: String?
  public var followShopList: [String?]?
  public var recentlyItem: [String?]?
  public var followItemList: [String?]?
  public var pickupItemList: [String?]?
  public var userPhoneNumber: [String?]?
  public var recentlySearch: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      email: String? = nil,
      followShopList: [String?]? = nil,
      recentlyItem: [String?]? = nil,
      followItemList: [String?]? = nil,
      pickupItemList: [String?]? = nil,
      userPhoneNumber: [String?]? = nil,
      recentlySearch: String? = nil) {
    self.init(id: id,
      email: email,
      followShopList: followShopList,
      recentlyItem: recentlyItem,
      followItemList: followItemList,
      pickupItemList: pickupItemList,
      userPhoneNumber: userPhoneNumber,
      recentlySearch: recentlySearch,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      email: String? = nil,
      followShopList: [String?]? = nil,
      recentlyItem: [String?]? = nil,
      followItemList: [String?]? = nil,
      pickupItemList: [String?]? = nil,
      userPhoneNumber: [String?]? = nil,
      recentlySearch: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.email = email
      self.followShopList = followShopList
      self.recentlyItem = recentlyItem
      self.followItemList = followItemList
      self.pickupItemList = pickupItemList
      self.userPhoneNumber = userPhoneNumber
      self.recentlySearch = recentlySearch
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}