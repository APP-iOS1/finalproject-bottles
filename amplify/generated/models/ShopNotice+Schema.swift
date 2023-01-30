// swiftlint:disable all
import Amplify
import Foundation

extension ShopNotice {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case title
    case body
    case createDate
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let shopNotice = ShopNotice.keys
    
    model.pluralName = "ShopNotices"
    
    model.fields(
      .field(shopNotice.id, is: .optional, ofType: .string),
      .field(shopNotice.title, is: .optional, ofType: .string),
      .field(shopNotice.body, is: .optional, ofType: .string),
      .field(shopNotice.createDate, is: .optional, ofType: .dateTime)
    )
    }
}