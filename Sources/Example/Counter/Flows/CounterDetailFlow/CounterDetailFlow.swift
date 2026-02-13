//
//  CounterDetailFlow.swift
//  ArchitectureCore
//
//  Created by Nicolá Domingues on 13/02/2026.
//

import ArchitectureCore
import SwiftUI

struct CounterDetailFlow: FlowScreen {
  typealias FullScreenDestination = EmptyDestination
  
  enum PathDestination: NavigationDestination {
    case moreDetails(count: Int)
    
    var id: Self { self }
  }

  let count: Int
  let onDismiss: () -> Void
  let navHandler: CounterDetailNavigationProcessor

  var root: some View {
    WithProcessor {
      CounterDetailProcessor(
        eventHandler: { event in
          switch event {
          case .dismiss:
            onDismiss()
          case .showMoreDetails:
            navHandler.push(destination: .moreDetails(count: count))
          }
        },
        initialState: .init(
          count: count,
          showsToolbarDismiss: true,
          showsMoreDetailsLink: true
        )
      )
    }
  }

  func path(destination: PathDestination) -> some View {
    switch destination {
    case .moreDetails(let count):
      WithProcessor {
        CounterDetailProcessor(eventHandler: { _ in }, initialState: .init(count: count))
      }
    }
  }
}

#Preview {
  let navProcessor = CounterDetailNavigationProcessor()
  WithNavigationProcessor {
    navProcessor
  } makeFlow: {
    CounterDetailFlow(
      count: 10,
      onDismiss: { },
      navHandler: navProcessor
    )
  }
}
