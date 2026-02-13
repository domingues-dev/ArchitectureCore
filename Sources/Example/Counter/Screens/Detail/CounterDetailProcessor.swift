import ArchitectureCore

class CounterDetailProcessor: Processor<CounterDetailScreen> {
  enum Event {
    case dismiss
    case showMoreDetails
  }

  let eventHandler: (Event) -> Void

  init(
    eventHandler: @escaping (Event) -> Void,
    initialState: Processor<CounterDetailScreen>.State
  ) {
    self.eventHandler = eventHandler
    super.init(initialState: initialState, reducer: CounterDetailReducer())
  }

  override func process(_ action: Action) async -> Action? {
    switch action {
    case .randomFactButtonTapped:
      async let fact = simulatedRandomFactService()
      await send(.updateRandomFact(fact))
      return .none
    case .dismissButtonTapped:
      eventHandler(.dismiss)
      return .none
    case .moreDetailsButtonTapped:
      eventHandler(.showMoreDetails)
      return .none
    case .updateRandomFact:
      return .none
    }
  }

  private func simulatedRandomFactService() async -> String {
    try? await Task.sleep(for: .seconds(1))
    return "Random fact about \(state.count)"
  }
}
