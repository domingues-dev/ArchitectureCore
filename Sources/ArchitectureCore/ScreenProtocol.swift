import SwiftUI

public protocol Screen<State, Action>: View {
  typealias ActionHandler = (Action) -> Void
  associatedtype State
  associatedtype Action: Sendable
  
  var state: State { get }
  var actionHandler: ActionHandler { get }
  
  init(state: State, actionHandler: @escaping ActionHandler)
}
