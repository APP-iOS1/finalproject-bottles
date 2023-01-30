// swiftlint:disable all
import Amplify
import Foundation

extension Shop {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case shopName
    case shopAddress
    case longitude
    case latitude
    case shopPhoneNumber
    case shopIntroduction
    case registration
    case Bottles
    case followerUserList
    case shopGrade
    case ShopNotices
    case shopOpenCloseTime
    case shopImage
    case shopSNS
    case shopTitleImage
    case shopCuration
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let shop = Shop.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Shops"
    
    model.attributes(
      .primaryKey(fields: [shop.id])
    )
    
    model.fields(
      .field(shop.id, is: .required, ofType: .string),
      .field(shop.shopName, is: .optional, ofType: .string),
      .field(shop.shopAddress, is: .optional, ofType: .string),
      .field(shop.longitude, is: .optional, ofType: .double),
      .field(shop.latitude, is: .optional, ofType: .double),
      .field(shop.shopPhoneNumber, is: .optional, ofType: .string),
      .field(shop.shopIntroduction, is: .optional, ofType: .string),
      .field(shop.registration, is: .optional, ofType: .bool),
      .hasMany(shop.Bottles, is: .optional, ofType: Bottle.self, associatedWith: Bottle.keys.shopID),
      .field(shop.followerUserList, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(shop.shopGrade, is: .optional, ofType: .double),
      .hasMany(shop.ShopNotices, is: .optional, ofType: ShopNotice.self, associatedWith: ShopNotice.keys.shopID),
      .field(shop.shopOpenCloseTime, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(shop.shopImage, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(shop.shopSNS, is: .optional, ofType: .string),
      .field(shop.shopTitleImage, is: .optional, ofType: .string),
      .field(shop.shopCuration, is: .optional, ofType: .embedded(type: Curation.self)),
      .field(shop.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(shop.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Shop: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
