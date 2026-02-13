public protocol ReducerProtocol<S> {
  associatedtype S: Screen
  
  func reduce(_ state: inout S.State, action: S.Action)
}
