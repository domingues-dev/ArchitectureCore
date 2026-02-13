import SwiftUI

@MainActor
public protocol FlowScreen {
  associatedtype PathDestination: NavigationDestination
  associatedtype FullScreenDestination: NavigationDestination
  associatedtype Root: View
  associatedtype Path: View
  associatedtype FullScreenCover: View
  
  @ViewBuilder
  var root: Root { get }
  
  @ViewBuilder
  func path(destination: PathDestination) -> Path
  
  @ViewBuilder
  func fullScreen(destination: FullScreenDestination) -> FullScreenCover
}

public extension FlowScreen where FullScreenDestination == EmptyDestination {
  func fullScreen(destination: FullScreenDestination) -> some View {
    EmptyView()
  }
}
