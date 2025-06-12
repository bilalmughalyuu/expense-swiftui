import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var viewModel: HomeViewModel
    @Query(sort: [SortDescriptor(\Expense.date, order: .reverse)]) private var expenses: [Expense]
    @AppStorage(Constants.COLOR_SCHEME_KEY) var selectedTheme: AppTheme = .system
    
    var body: some View {
        VStack {
            HStack {
                Text("Hello there!")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
                    selectedTheme = selectedTheme == .dark ? .light : .dark
                }) {
                    Image(systemName: "moon")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.primary)
                }
            }
            
            Spacer().frame(height: 24)
            
            if expenses.isEmpty {
                VStack{
                    Text("No expenses yet")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                }
                .frame(maxHeight: .infinity)
            } else {
                List(expenses) { expense in
                    ExpenseRow(expense: expense)
                        .buttonStyle(PlainButtonStyle())
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .scrollIndicators(.hidden)
            }
        }
        .padding(.horizontal, 24)
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            viewModel.setModelContext(modelContext)
        }
        .refreshable {
//            viewModel.fetchData()
        }
    }
}


#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
