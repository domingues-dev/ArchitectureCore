import SwiftUI

public struct WithNavigationProcessor<Flow: FlowScreen>: View {
  public typealias NavProcessor = NavigationProcessor<Flow.PathDestination, Flow.FullScreenDestination>
  // navProcessor owns state and handles all navigation logic.
  // Views must not retain or modify it directly.
  @State private var navProcessor: NavProcessor
  private let rootView: Flow.Root
  private let destinationView: (Flow.PathDestination) -> Flow.Path
  private let fullScreenView: (Flow.FullScreenDestination) -> Flow.FullScreenCover
  
  public init(makeNavProcessor: @escaping () -> NavigationProcessor<Flow.PathDestination, Flow.FullScreenDestination>, makeFlow: @escaping () -> Flow) {
    let processor = makeNavProcessor()
    self.navProcessor = processor
    let flow = makeFlow()
    self.rootView = flow.root
    self.destinationView = flow.path(destination:)
    self.fullScreenView = flow.fullScreen(destination:)
  }
  
  public var body: some View {
    NavigationStack(path: $navProcessor.path) {
      rootView
        .navigationDestination(
          for: Flow.PathDestination.self,
          destination: destinationView
        )
    }
    .fullScreenCover(
      item: $navProcessor.fullScreenCover,
      content: fullScreenView
    )
  }
}
