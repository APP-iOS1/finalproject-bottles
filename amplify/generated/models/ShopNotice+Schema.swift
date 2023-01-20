// swiftlint:disable all
import Amplify
import Foundation

extension ShopNotice {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case title
    case body
    case Image
    case date
    case shopID
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let shopNotice = ShopNotice.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "ShopNotices"
    
    model.attributes(
      .index(fields: ["shopID"], name: "byShop"),
      .primaryKey(fields: [shopNotice.id])
    )
    
    model.fields(
      .field(shopNotice.id, is: .required, ofType: .string),
      .field(shopNotice.title, is: .optional, ofType: .string),
      .field(shopNotice.body, is: .optional, ofType: .string),
      .field(shopNotice.Image, is: .optional, ofType: .string),
      .field(shopNotice.date, is: .optional, ofType: .dateTime),
      .field(shopNotice.shopID, is: .required, ofType: .string),
      .field(shopNotice.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(shopNotice.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension ShopNotice: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}