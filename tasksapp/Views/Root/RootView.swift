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
                    Image(systemName: "plus")
                    Text("Add Expense")
                }
                .tag(1)
            ChartView()
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
        .environmentObject(AddExpenseViewModel())
        .environmentObject(HomeViewModel())
}
