import Foundation
import Observation

public protocol NavigationDestination: Hashable, Sendable, Identifiable {}

@MainActor
public protocol NavigationHandlerInterface<PathDestination, FullScreenDestination>: AnyObject {
  associatedtype PathDestination: NavigationDestination
  associatedtype FullScreenDestination: NavigationDestination
  var path: [PathDestination] { get set }
  var fullScreenCover: FullScreenDestination? { get set }
  func push(destination: PathDestination)
  func pop()
  func popToRoot()
  func dismiss()
}

public extension NavigationHandlerInterface {
  func push(destination: PathDestination) {
    path.append(destination)
  }
  
  func pop() {
    path.removeLast()
  }
  
  func popToRoot() {
    path.removeAll()
  }
  func show(destination: FullScreenDestination) {
    fullScreenCover = destination
  }
  
  func dismiss() {
    fullScreenCover = .none
  }
}

public struct EmptyDestination: NavigationDestination {
  public let id = UUID()
}

@Observable
open class NavigationProcessor<PathDestination: NavigationDestination, FullScreenDestination: NavigationDestination>: NavigationHandlerInterface {
  
  public var path: [PathDestination]
  public var fullScreenCover: FullScreenDestination?
  
  public init(
    path: [PathDestination] = [],
    fullScreenCover: FullScreenDestination? = nil
  ) {
    self.path = path
    self.fullScreenCover = fullScreenCover
  }
}

extension NavigationProcessor where FullScreenDestination == EmptyDestination {
  
  public convenience init(path: [PathDestination] = []) {
    self.init(path: path, fullScreenCover: nil)
  }
}
