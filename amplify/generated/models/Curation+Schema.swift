// swiftlint:disable all
import Amplify
import Foundation

extension Curation {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case shopCurationTitle
    case shopCurationBody
    case shopCurationImage
    case shopCurationBottleID
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let curation = Curation.keys
    
    model.pluralName = "Curations"
    
    model.fields(
      .field(curation.shopCurationTitle, is: .optional, ofType: .string),
      .field(curation.shopCurationBody, is: .optional, ofType: .string),
      .field(curation.shopCurationImage, is: .optional, ofType: .string),
      .field(curation.shopCurationBottleID, is: .optional, ofType: .embeddedCollection(of: String.self))
    )
    }
}