import ArchitectureCore
import SwiftUI

extension CounterDetailScreen {
  struct State {
    let count: Int
    var randomFact: String? = nil
    var showsInlineDismiss: Bool = false
    var showsToolbarDismiss: Bool = false
    var showsMoreDetailsLink: Bool = false
  }

  enum Action: Sendable {
    case dismissButtonTapped
    case randomFactButtonTapped
    case updateRandomFact(String)
    case moreDetailsButtonTapped
  }
}

struct CounterDetailScreen: Screen {
  let state: State
  let actionHandler: ActionHandler

  var body: some View {
    VStack(spacing: 16) {
      Text(String(state.count))
        .font(.title)

      if let randomFact = state.randomFact {
        Text(randomFact)
          .font(.subheadline)
      }

      Button("Get random fact") {
        actionHandler(.randomFactButtonTapped)
      }

      if state.showsInlineDismiss {
        Button("Dismiss") {
          actionHandler(.dismissButtonTapped)
        }
      }

      if state.showsMoreDetailsLink {
        Button("More details") {
          actionHandler(.moreDetailsButtonTapped)
        }
      }
    }
    .toolbar {
      if state.showsToolbarDismiss {
        Button("Dismiss") {
          actionHandler(.dismissButtonTapped)
        }
      }
    }
    .toolbarVisibility(.visible, for: .navigationBar)
    .padding()
  }
}
