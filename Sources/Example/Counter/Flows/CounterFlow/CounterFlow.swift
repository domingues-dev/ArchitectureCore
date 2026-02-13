//
//  CounterFlow.swift
//  ArchitectureCore
//
//  Created by Nicolá Domingues on 06/02/2026.
//

import SwiftUI
import ArchitectureCore

struct CounterFlow: FlowScreen {
  enum PathDestination: NavigationDestination {
    case counterDetail(value: Int)
    
    var id: Self { self }
  }
  enum FullScreenDestination: NavigationDestination {
    case counterDetail(value: Int)
    case counterDetailWithNavigation(value: Int)
    
    var id: Self { self }
  }
  
  let navHandler: any CounterNavigationHandlerInterface
  
  @ViewBuilder
  var root: some View {
    WithProcessor {
      CounterProcessor(navigationHandler: navHandler)
    }
  }
  
  @ViewBuilder
  func path(destination: PathDestination) -> some View {
    switch destination {
    case .counterDetail(let value):
      WithProcessor {
        CounterDetailProcessor(
          eventHandler: { _ in },
          initialState: .init(count: value)
        )
      }
    }
  }
  
  @ViewBuilder
  func fullScreen(destination: FullScreenDestination) -> some View {
    switch destination {
    case .counterDetail(let value):
      WithProcessor {
        CounterDetailProcessor(
          eventHandler: { action in
            guard case .dismiss = action else { return }
            navHandler.dismiss()
          },
          initialState: .init(
            count: value,
            showsInlineDismiss: true
          )
        )
      }
    case .counterDetailWithNavigation(let value):
      let detailNavHandler = CounterDetailNavigationProcessor()
      WithNavigationProcessor {
        detailNavHandler
      } makeFlow: {
        CounterDetailFlow(
          count: value,
          onDismiss: { navHandler.dismiss() },
          navHandler: detailNavHandler
        )
      }
    }
  }
}

#Preview {
  let navProcessor = CounterNavigationProcessor()
  WithNavigationProcessor {
    navProcessor
  } makeFlow: {
    CounterFlow(navHandler: navProcessor)
  }
}
