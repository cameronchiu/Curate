import SwiftUI

struct TabView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.blue
    }
    var body: some View {

        return TabbedView {
            Text("This is tab 1").tag(0).tabItemLabel(Text("tab1"))
            Text("This is tab 2").tag(1).tabItemLabel(Text("tab2"))
            Text("This is tab 3").tag(2).tabItemLabel(Text("tab3"))
        }
    }
}
