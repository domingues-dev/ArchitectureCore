import ArchitectureCore

struct CounterDetailReducer: ReducerProtocol {
  typealias S = CounterDetailScreen

  func reduce(_ state: inout S.State, action: S.Action) {
    switch action {
    case .randomFactButtonTapped, .dismissButtonTapped, .moreDetailsButtonTapped:
      break
    case .updateRandomFact(let fact):
      state.randomFact = fact
    }
  }
}
