import SwiftUI

struct RootView: View {
    @EnvironmentObject var viewModel: RootViewModel
    var body: some View {
        TabView(selection: $viewModel.selectedTab){
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            AddExpenseView()
                .tabItem{
                    Image(systemName: "plus.circle")
                    Text("Add Expense")
                }
                .tag(1)
            Text("Chart")
                .tabItem{
                    Image(systemName: "chart.bar")
                    Text("Chart")
                }
                .tag(2)
        }
    }
}

#Preview {
    RootView()
        .environmentObject(RootViewModel())
}
