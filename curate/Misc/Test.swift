import Foundation
import SwiftUI

struct ContentView: View {
    @State private var scrollDisabled = false
    @State private var outerScrollViewSize: CGSize = .zero

    var body: some View {
        ScrollView {
            VStack {
                Text("Outer Scroll View Content")
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .preference(
                                    key: ScrollViewSizePreferenceKey.self,
                                    value: geometry.size
                                )
                        }
                    )
                    .onPreferenceChange(ScrollViewSizePreferenceKey.self) { size in
                        outerScrollViewSize = size
                    }

                ScrollView {
                    VStack {
                        ForEach(0..<50) { index in
                            Text("Item \(index)")
                                .padding()
                        }
                    }
                    .frame(width: outerScrollViewSize.width, height: 200)
                    .disabled(scrollDisabled) // Enable/disable scrolling based on `scrollDisabled`
                }
                .background(Color.clear) // Ensure background tap gestures are recognized

                Button("Toggle Scroll") {
                    scrollDisabled.toggle()
                }
            }
        }
    }
}

struct ScrollViewSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


struct Content_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
