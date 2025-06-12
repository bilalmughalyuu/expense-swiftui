import SwiftUI
import Charts
import SwiftData

struct ChartView: View {
    @Query(sort: \Expense.date) private var expenses: [Expense]
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selectedExpense: Expense?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Expenses Chart")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer().frame(height: 24)
            
            Chart {
                ForEach(expenses, id: \.id) { expense in
                    BarMark(
                        x: .value("Date", Calendar.current.component(.day, from: expense.date)),
                        y: .value("Amount", Double(expense.amount) ?? 0.0),
                        width: .fixed(12)
                    )
                    .foregroundStyle(.blue)
                    .cornerRadius(2)
                    .accessibilityLabel(Text("Amount"))
                    .accessibilityValue(Text("\(expense.amount)"))
                    
                    if let selected = selectedExpense {
                        PointMark(
                            x: .value("Date", Calendar.current.component(.day, from: selected.date)),
                            y: .value("Amount", Double(selected.amount) ?? 0.0)
                        )
                        .annotation(position: .top) {
                            Text("AED\(selected.amount)")
                                .font(.caption)
                                .padding(5)
                                .background(.ultraThinMaterial)
                                .cornerRadius(5)
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .chartOverlay { proxy in
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    let location = value.location
                                    if let date: Int = proxy.value(atX: location.x) {
                                        // Find the closest matching bar
                                        if let match = expenses.first(where: {
                                            Calendar.current.component(.day, from: $0.date) == date
                                        }) {
                                            selectedExpense = match
                                        }
                                    }
                                }
                        )
                }
            }
            .chartBackground { _ in
                colorScheme == .dark ? Color.black : Color.clear
            }
            .chartPlotStyle { plotArea in
                plotArea
                    .background(colorScheme == .dark ? Color.black : Color.clear)
            }
            .chartYAxis {
                AxisMarks(
                    preset: .aligned,
                    position: .leading,
                    values: .automatic(desiredCount: 10)
                ) { value in
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [5, 5]))
                        .foregroundStyle(.gray.opacity(0.5))
                    AxisValueLabel()
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .font(.system(size: 12))
                }
            }
            .chartXAxis {
                AxisMarks(
                    position: .bottom,
                    values: .automatic(desiredCount: 12)
                ) { value in
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [5, 5]))
                        .foregroundStyle(.gray.opacity(0.5))
                    AxisValueLabel()
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .font(.system(size: 12))
                }
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(colorScheme == .dark ? Color.black : Color.clear)
    }
}

#Preview {
    let container = try! ModelContainer(for: Expense.self)
    let context = container.mainContext
    
    // Create sample expenses for days 8 and 10
    let calendar = Calendar.current
    let today = Date()
    
    // Create date for day 8 of current month
    var day8Components = calendar.dateComponents([.year, .month], from: today)
    day8Components.day = 1
    let day8Date = calendar.date(from: day8Components) ?? today
    
    // Create date for day 10 of current month
    var day10Components = calendar.dateComponents([.year, .month], from: today)
    day10Components.day = 30
    let day10Date = calendar.date(from: day10Components) ?? today
    
    context.insert(Expense(title: "Groceries", amount: "70.0", category: "Food", date: day8Date))
    context.insert(Expense(title: "Gas", amount: "40.0", category: "Transportation", date: day10Date))
    
    return ChartView()
        .modelContainer(container)
}
