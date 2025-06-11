import SwiftUI

struct RootView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            AddExpenseView()
                .tabItem{
                    Image(systemName: "plus.circle")
                    Text("Add Expense")
                }
            Text("Chart")
                .tabItem{
                    Image(systemName: "chart.bar")
                    Text("Chart")
                }
        }
    }
}

#Preview {
    RootView()
}
