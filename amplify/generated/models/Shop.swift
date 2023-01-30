// swiftlint:disable all
import Amplify
import Foundation

public struct Shop: Model {
  public let id: String
  public var shopName: String?
  public var shopAddress: String?
  public var longitude: Double?
  public var latitude: Double?
  public var shopPhoneNumber: String?
  public var shopIntroduction: String?
  public var registration: Bool?
  public var Bottles: List<Bottle>?
  public var followerUserList: [String?]?

  public var shopGrade: Double?
  public var ShopNotices: List<ShopNotice>?
  public var shopOpenCloseTime: [String?]?

  public var shopOpenCloseTime: String?

  public var shopImage: [String?]?
  public var shopSNS: String?
  public var shopTitleImage: String?
  public var shopCuration: Curation?

  public var shopNotice: [ShopNotice?]?

  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      shopName: String? = nil,
      shopAddress: String? = nil,
      longitude: Double? = nil,
      latitude: Double? = nil,
      shopPhoneNumber: String? = nil,
      shopIntroduction: String? = nil,
      registration: Bool? = nil,
      Bottles: List<Bottle>? = [],
      followerUserList: [String?]? = nil,
      shopGrade: Double? = nil,
      ShopNotices: List<ShopNotice>? = [],
      shopOpenCloseTime: [String?]? = nil,
      shopImage: [String?]? = nil,
      shopSNS: String? = nil,
      shopTitleImage: String? = nil,
      shopCuration: Curation? = nil) {

      shopOpenCloseTime: String? = nil,
      shopImage: [String?]? = nil,
      shopSNS: String? = nil,
      shopTitleImage: String? = nil,
      shopCuration: Curation? = nil,
      shopNotice: [ShopNotice?]? = nil) {
    self.init(id: id,
      shopName: shopName,
      shopAddress: shopAddress,
      longitude: longitude,
      latitude: latitude,
      shopPhoneNumber: shopPhoneNumber,
      shopIntroduction: shopIntroduction,
      registration: registration,
      Bottles: Bottles,
      followerUserList: followerUserList,
      shopGrade: shopGrade,
      ShopNotices: ShopNotices,

      shopOpenCloseTime: shopOpenCloseTime,
      shopImage: shopImage,
      shopSNS: shopSNS,
      shopTitleImage: shopTitleImage,
      shopCuration: shopCuration,

      shopNotice: shopNotice,

      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      shopName: String? = nil,
      shopAddress: String? = nil,
      longitude: Double? = nil,
      latitude: Double? = nil,
      shopPhoneNumber: String? = nil,
      shopIntroduction: String? = nil,
      registration: Bool? = nil,
      Bottles: List<Bottle>? = [],
      followerUserList: [String?]? = nil,

      shopGrade: Double? = nil,
      ShopNotices: List<ShopNotice>? = [],
      shopOpenCloseTime: [String?]? = nil,

      shopOpenCloseTime: String? = nil,

      shopImage: [String?]? = nil,
      shopSNS: String? = nil,
      shopTitleImage: String? = nil,
      shopCuration: Curation? = nil,

      shopNotice: [ShopNotice?]? = nil,

      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.shopName = shopName
      self.shopAddress = shopAddress
      self.longitude = longitude
      self.latitude = latitude
      self.shopPhoneNumber = shopPhoneNumber
      self.shopIntroduction = shopIntroduction
      self.registration = registration
      self.Bottles = Bottles
      self.followerUserList = followerUserList

      self.shopGrade = shopGrade
      self.ShopNotices = ShopNotices

      self.shopOpenCloseTime = shopOpenCloseTime
      self.shopImage = shopImage
      self.shopSNS = shopSNS
      self.shopTitleImage = shopTitleImage
      self.shopCuration = shopCuration

      self.shopNotice = shopNotice

      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}