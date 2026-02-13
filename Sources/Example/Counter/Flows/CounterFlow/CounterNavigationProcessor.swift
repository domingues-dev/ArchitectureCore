//
//  CounterNavigationProcessor.swift
//  ArchitectureCore
//
//  Created by Nicolá Domingues on 13/02/2026.
//

import ArchitectureCore

class CounterNavigationProcessor: NavigationProcessor<CounterFlow.PathDestination, CounterFlow.FullScreenDestination> {
}

extension CounterNavigationProcessor: CounterNavigationHandlerInterface {
  func navigateToDetails(value: Int) {
    push(destination: .counterDetail(value: value))
  }
  
  func openDetails(value: Int) {
    show(destination: .counterDetail(value: value))
  }
  
  func openDetailsWithNavigation(value: Int) {
    show(destination: .counterDetailWithNavigation(value: value))
  }
}
