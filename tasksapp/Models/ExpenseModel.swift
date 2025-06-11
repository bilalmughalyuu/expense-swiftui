import Foundation
import SwiftData

@Model
class Expense {
    var uuid: UUID?
    var title: String
    var amount: String
    var category: String
    var date: Date

    init(title: String, amount: String, category: String, date: Date) {
        self.title = title
        self.amount = amount
        self.category = category
        self.date = date
        self.uuid = UUID()
    }
}
