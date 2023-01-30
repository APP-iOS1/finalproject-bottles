// swiftlint:disable all
import Amplify
import Foundation

public struct Bottle: Model {
  public let id: String
  public var shopID: String
  public var itemName: String?
  public var itemImage: String?
  public var itemPrice: Int?
  public var itemML: Double?
  public var itemNation: String?
  public var itemProducer: String?
  public var itemLocal: [String?]?
  public var itemVarities: [String?]?
  public var itemType: String?
  public var itemAdv: Double?
  public var itemDegree: Double?
  public var itemTag: [String?]?
  public var itemAroma: [String?]?
  public var itemTaste: [String?]?
  public var itemFinish: [String?]?
  public var itemPairing: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      shopID: String,
      itemName: String? = nil,
      itemImage: String? = nil,
      itemPrice: Int? = nil,
      itemML: Double? = nil,
      itemNation: String? = nil,
      itemProducer: String? = nil,
      itemLocal: [String?]? = nil,
      itemVarities: [String?]? = nil,
      itemType: String? = nil,
      itemAdv: Double? = nil,
      itemDegree: Double? = nil,
      itemTag: [String?]? = nil,
      itemAroma: [String?]? = nil,
      itemTaste: [String?]? = nil,
      itemFinish: [String?]? = nil,
      itemPairing: String? = nil) {
    self.init(id: id,
      shopID: shopID,
      itemName: itemName,
      itemImage: itemImage,
      itemPrice: itemPrice,
      itemML: itemML,
      itemNation: itemNation,
      itemProducer: itemProducer,
      itemLocal: itemLocal,
      itemVarities: itemVarities,
      itemType: itemType,
      itemAdv: itemAdv,
      itemDegree: itemDegree,
      itemTag: itemTag,
      itemAroma: itemAroma,
      itemTaste: itemTaste,
      itemFinish: itemFinish,
      itemPairing: itemPairing,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      shopID: String,
      itemName: String? = nil,
      itemImage: String? = nil,
      itemPrice: Int? = nil,
      itemML: Double? = nil,
      itemNation: String? = nil,
      itemProducer: String? = nil,
      itemLocal: [String?]? = nil,
      itemVarities: [String?]? = nil,
      itemType: String? = nil,
      itemAdv: Double? = nil,
      itemDegree: Double? = nil,
      itemTag: [String?]? = nil,
      itemAroma: [String?]? = nil,
      itemTaste: [String?]? = nil,
      itemFinish: [String?]? = nil,
      itemPairing: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.shopID = shopID
      self.itemName = itemName
      self.itemImage = itemImage
      self.itemPrice = itemPrice
      self.itemML = itemML
      self.itemNation = itemNation
      self.itemProducer = itemProducer
      self.itemLocal = itemLocal
      self.itemVarities = itemVarities
      self.itemType = itemType
      self.itemAdv = itemAdv
      self.itemDegree = itemDegree
      self.itemTag = itemTag
      self.itemAroma = itemAroma
      self.itemTaste = itemTaste
      self.itemFinish = itemFinish
      self.itemPairing = itemPairing
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}