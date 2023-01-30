// swiftlint:disable all
import Amplify
import Foundation

extension User {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case email
    case followShopList
    case followItemList
    case pickupList
    case userPhoneNumber
    case recentlyBottles
    case nickname
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let user = User.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Users"
    
    model.attributes(
      .primaryKey(fields: [user.id])
    )
    
    model.fields(
      .field(user.id, is: .required, ofType: .string),
      .field(user.email, is: .optional, ofType: .string),
      .field(user.followShopList, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(user.followItemList, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(user.pickupList, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(user.userPhoneNumber, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(user.recentlyBottles, is: .optional, ofType: .embeddedCollection(of: String.self)),
      .field(user.nickname, is: .optional, ofType: .string),
      .field(user.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(user.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension User: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}