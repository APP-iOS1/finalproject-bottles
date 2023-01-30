// swiftlint:disable all
import Amplify
import Foundation

extension Bottle {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case shopID
    case itemName
    case itemImage
    case itemPrice
    case itemML
    case itemNation
    case itemProducer
    case itemLocal
    case itemVarities
    case itemType
    case itemAdv
    case itemDegree
    case itemTag
    case itemAroma
    case itemTaste
    case itemFinish
    case itemPairing
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let bottle = Bottle.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Bottles"
    
    model.attributes(
      .index(fields: ["shopID"], name: "byShop"),
      .primaryKey(fields: [bottle.id])
    )
    
    model.fields(
      .field(bottle.id, is: .required, ofType: .string),
      .field(bottle.shopID, is: .required, ofType: .string),
      .field(bottle.itemName, is: .optional, ofType: .string),
      .field(bottle.itemImage, is: .optional, ofType: .string),
      .field(bottle.itemPrice, is: .optional, ofType: .int),
      .field(bottle.itemML, is: .optional, ofType: .double),
      .field(bottle.itemNation, is: .optional, ofType: .string),
      .field(bottle.itemProducer, is: .optional, ofType: .string),
      .field(bottle.itemLocal, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(bottle.itemVarities, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(bottle.itemType, is: .optional, ofType: .string),
      .field(bottle.itemAdv, is: .optional, ofType: .double),
      .field(bottle.itemDegree, is: .optional, ofType: .double),
      .field(bottle.itemTag, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(bottle.itemAroma, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(bottle.itemTaste, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(bottle.itemFinish, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(bottle.itemPairing, is: .optional, ofType: .string),
      .field(bottle.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(bottle.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Bottle: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}