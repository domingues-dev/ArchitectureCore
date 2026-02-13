import SwiftUI

struct CounterDetailMoreView: View {
  let count: Int

  var body: some View {
    VStack(spacing: 12) {
      Text("More Details")
        .font(.title2)
      Text("Count: \(count)")
    }
    .navigationTitle("More Details")
    .padding()
  }
}
