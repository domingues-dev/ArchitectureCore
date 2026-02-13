import SwiftUI

public struct WithProcessor<S: Screen>: View {
  // Processor owns state and handles all logic.
  // Views must not retain or modify it directly.
  @State var processor: Processor<S>
  
  public init(makeProcessor: @escaping () -> Processor<S>) {
    self.processor = makeProcessor()
  }
  
  public var body: some View {
    S.init(
      state: processor.state,
      actionHandler: { action in
        Task {
          await processor.send(action)
        }
      }
    )
  }
}
