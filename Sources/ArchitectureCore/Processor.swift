import Foundation
import Observation

@MainActor
@Observable
open class Processor<S: Screen> {
  public typealias State = S.State
  public typealias Action = S.Action
  public private(set) var state: State
  private let reducer: any ReducerProtocol<S>
  
  private let stream: AsyncStream<Action>
  private let continuation: AsyncStream<Action>.Continuation
  
  public init(
    initialState: State,
    reducer: any ReducerProtocol<S>
  ) {
    self.state = initialState
    self.reducer = reducer
    var _continuation: AsyncStream<Action>.Continuation!
    self.stream = AsyncStream<Action> { continuation in
      _continuation = continuation
    }
    self.continuation = _continuation
    actionTracker()
  }
  
  open func process(_ action: Action) async -> Action? { nil }
  
  public final func send(_ action: Action) {
    continuation.yield(action)
    Task {
      guard let nextAction = await process(action) else { return }
      continuation.yield(nextAction)
    }
  }
  
  public final func send(_ action: Action) async {
    continuation.yield(action)
    guard let nextAction = await process(action) else { return }
    continuation.yield(nextAction)
  }
  
  private func actionTracker() {
    Task {
      for await action in stream {
        reducer.reduce(&state, action: action)
      }
    }
  }
}
