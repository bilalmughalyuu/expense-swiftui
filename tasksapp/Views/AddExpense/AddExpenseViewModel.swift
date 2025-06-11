import Foundation
import SwiftData

@MainActor
class AddExpenseViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var amount: String = ""
    @Published var category: String = ""
    @Published var date: Date = Date()
    
    @Published var expenseCategories: [String] = ["Food", "Transportation", "Entertainment", "Utilities", "Other"]
    
    private var modelContext: ModelContext?
    private var rootViewModel: RootViewModel?
    
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
//        fetchExpenses()
    }
    
    func setRootViewModel(viewModel: RootViewModel) {
        self.rootViewModel = viewModel
    }
    
    
    func addExpense() {
        guard !title.isEmpty, !amount.isEmpty, !category.isEmpty else {
            return
        }
        
        let expense = Expense(title: title, amount: amount, category: category, date: date)
        
        do {
            modelContext?.insert(expense)
            try modelContext?.save()
            print("Expense saved: \(title), \(amount), \(category), \(date)")
            title = ""
            amount = ""
            category = ""
            date = Date()
            rootViewModel?.selectedTab = 0
        } catch {
            print("Failed to save expense: \(error.localizedDescription)")
        }
    }
    
}
