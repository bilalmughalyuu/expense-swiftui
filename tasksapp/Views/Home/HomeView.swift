import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.expensesList.isEmpty {
                    // Empty state
                    VStack(spacing: 16) {
                        Image(systemName: "list.bullet.rectangle")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        
                        Text("No expenses yet")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("Add your first expense to get started")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                } else {
                    List(viewModel.expensesList) { expense in
                        ExpenseRow(expense: expense)
                            .buttonStyle(PlainButtonStyle())
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Expenses")
            .onAppear {
                print("HomeView appeared")
                viewModel.setModelContext(modelContext)
            }
            .refreshable {
                viewModel.fetchData()
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
