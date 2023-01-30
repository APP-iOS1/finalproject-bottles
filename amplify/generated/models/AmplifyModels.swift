// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "5dff743cc9f1328c836441fe25b47927"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: ShopNotice.self)

  public let version: String = "5ba6fef4689161da95b67f34a5728e14"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Bottle.self)
    ModelRegistry.register(modelType: User.self)
    ModelRegistry.register(modelType: Shop.self)
  }
}