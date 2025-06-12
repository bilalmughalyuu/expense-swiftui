import Foundation
import SwiftData

@MainActor
class HomeViewModel: ObservableObject {
    private var modelContext: ModelContext?
    
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    @Published var expense: Expense?
    
    func deleteExpense(id: UUID) {
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
        } catch {
            print("Delete failed: \(error)")
        }
    }
}
