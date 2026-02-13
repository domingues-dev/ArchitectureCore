import ArchitectureCore

class CounterProcessor: Processor<CounterScreen> {
  let navigationHandler: any CounterNavigationHandlerInterface

  init(navigationHandler: any CounterNavigationHandlerInterface) {
    self.navigationHandler = navigationHandler
    super.init(initialState: .init(count: .zero), reducer: CounterReducer())
  }

  override func process(_ action: Processor<CounterScreen>.Action) async -> Processor<CounterScreen>.Action? {
    switch action {
    case .pushDetailsButtonTapped:
      navigationHandler.navigateToDetails(value: state.count)
      return .none
    case .openDetailsButtonTapped:
      navigationHandler.openDetails(value: state.count)
      return .none
    case .openDetailsWithNavigationButtonTapped:
      navigationHandler.openDetailsWithNavigation(value: state.count)
      return .none
    case .incrementButtonTapped, .decrementButtonTapped:
      return .none
    }
  }
}
