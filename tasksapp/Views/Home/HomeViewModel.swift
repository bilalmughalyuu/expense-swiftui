import Foundation
import SwiftData

@MainActor
class HomeViewModel: ObservableObject {
    @Published var expensesList: [Expense] = []
    private var modelContext: ModelContext?
    
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
        fetchData()
    }
    
    func fetchData() {
        guard let modelContext = modelContext else {
            print("ModelContext is nil")
            return
        }
        
        do {
            let descriptor = FetchDescriptor<Expense>(
                sortBy: [SortDescriptor(\.date, order: .reverse)]
            )
            expensesList = try modelContext.fetch(descriptor)
            print("Fetched expenses: \(expensesList.map { $0.title })")
        } catch {
            print("Failed to fetch expenses: \(error.localizedDescription)")
        }
    }
    
    func deleteExpense(id: UUID, in context: ModelContext) {
        guard let modelContext = modelContext else {
            print("ModelContext is nil")
            return
        }
        
        let descriptor = FetchDescriptor<Expense>(
            predicate: #Predicate { $0.uuid == id }
        )
        
        do {
            let results = try modelContext.fetch(descriptor)
            if let expenseToDelete = results.first {
                modelContext.delete(expenseToDelete)
                try modelContext.save()
            }
            fetchData()
            
        } catch {
            print("Delete failed: \(error)")
        }
    }
}
