import ArchitectureCore
import SwiftUI

extension CounterScreen {
  struct State {
    var count: Int
  }

  enum Action: Sendable {
    case incrementButtonTapped
    case decrementButtonTapped
    case openDetailsButtonTapped
    case openDetailsWithNavigationButtonTapped
    case pushDetailsButtonTapped
  }
}

struct CounterScreen: Screen {
  let state: State
  let actionHandler: ActionHandler

  var body: some View {
    VStack(spacing: 16) {
      HStack {
        Button("-") { actionHandler(.decrementButtonTapped) }
        Text("\(state.count)")
        Button("+") { actionHandler(.incrementButtonTapped) }
      }
      Button("Push Details (NavigationStack)") { actionHandler(.pushDetailsButtonTapped) }
      Button("Open Details (Full Screen)") { actionHandler(.openDetailsButtonTapped) }
      Button("Open Details (Full Screen + NavStack)") { actionHandler(.openDetailsWithNavigationButtonTapped) }
    }
    .padding()
  }
}
