import SwiftUI
import SwiftData

struct ExpenseRow: View {
    var expense: Expense
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.modelContext) private var modelContext
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                Text(expense.title)
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Text("$\(expense.amount)")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.green.opacity(0.7))
            }
            
            Spacer().frame(height: 12)
            
            HStack{
                Text(expense.category)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .font(.system(size: 14))
                    .foregroundColor(.blue.opacity(0.9))
                    .background(.blue.opacity(0.1))
                    .cornerRadius(8)
                
                Spacer()
                Text(dateFormatter.string(from: expense.date))
                    .font(.system(size: 16, weight: .regular))
            }
            
            Spacer().frame(height: 16)
            
            HStack {
                Spacer()
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .font(.system(size: 20))
                    .onTapGesture {
                        guard let id = expense.uuid else {
                            print("No id found")
                            return
                        }
                        viewModel.deleteExpense(id: id)
                        try? modelContext.save()
                    }
                Spacer().frame(width: 24)
                Image(systemName: "pencil")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(.gray.opacity(0.08))
        .cornerRadius(12)
        .padding(.bottom, 16)
    }
}

#Preview {
    ExpenseRow(expense: Expense(title: "Groceries", amount: "85.50", category: "Food", date: Date()))
        .environmentObject(HomeViewModel())
}
