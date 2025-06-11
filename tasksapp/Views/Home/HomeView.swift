import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Hello there!")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
//                    viewModel.toggleDarkMode()
                }) {
                    Image(systemName: "moon")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                }
            }
            
            Spacer().frame(height: 24)
            
            if viewModel.expensesList.isEmpty {
                // Empty state
                VStack(alignment: .center, spacing: 16) {
                    Spacer()
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
                    Spacer()
                }
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
        .padding(.horizontal, 24)
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            viewModel.setModelContext(modelContext)
        }
        .refreshable {
            viewModel.fetchData()
        }
        
    }
}


#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
