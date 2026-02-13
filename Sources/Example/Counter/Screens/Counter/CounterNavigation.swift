import ArchitectureCore

@MainActor
protocol CounterNavigationHandlerInterface: NavigationHandlerInterface where PathDestination == CounterFlow.PathDestination, FullScreenDestination == CounterFlow.FullScreenDestination {
  func navigateToDetails(value: Int)
  func openDetails(value: Int)
  func openDetailsWithNavigation(value: Int)
}
