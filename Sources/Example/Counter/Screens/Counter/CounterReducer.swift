import ArchitectureCore

struct CounterReducer: ReducerProtocol {
  typealias S = CounterScreen

  func reduce(_ state: inout S.State, action: S.Action) {
    switch action {
    case .incrementButtonTapped:
      state.count += 1
    case .decrementButtonTapped:
      state.count -= 1
    case .openDetailsButtonTapped, .openDetailsWithNavigationButtonTapped, .pushDetailsButtonTapped:
      break
    }
  }
}
