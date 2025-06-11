import SwiftUI
import Charts
import SwiftData

//struct ChartView: View {
//    @Query(sort: \Expense.date) private var expenses: [Expense]
//    
//    // Sample data that matches your chart
//    let sampleData = [
//        (day: 8, amount: 70.0),
//        (day: 10, amount: 40.0)
//    ]
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            Text("Expenses Chart")
//                .font(.system(size: 22, weight: .semibold))
//                .foregroundColor(.white)
//                .frame(maxWidth: .infinity, alignment: .leading)
//            
//            Chart {
//                // Use sample data that matches your image
//                ForEach(sampleData, id: \.day) { data in
//                    BarMark(
//                        x: .value("Day", data.day),
//                        y: .value("Amount", data.amount)
//                    )
//                    .foregroundStyle(.blue)
//                    .cornerRadius(2)
//                }
//            }
//            .frame(height: 400)
//            .chartBackground { _ in
//                Color.black
//            }
//            .chartPlotStyle { plotArea in
//                plotArea
//                    .background(Color.black)
//            }
//            .chartYAxis {
//                AxisMarks(
//                    preset: .aligned,
//                    position: .leading,
//                    values: Array(stride(from: 0, through: 70, by: 5))
//                ) { value in
//                    AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [2, 2]))
//                        .foregroundStyle(.gray.opacity(0.5))
//                    AxisValueLabel()
//                        .foregroundStyle(.white)
//                        .font(.system(size: 12))
//                }
//            }
//            .chartXAxis {
//                AxisMarks(
//                    position: .bottom,
//                    values: [8, 10]
//                ) { value in
//                    AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [2, 2]))
//                        .foregroundStyle(.gray.opacity(0.5))
//                    AxisValueLabel()
//                        .foregroundStyle(.white)
//                        .font(.system(size: 12))
//                }
//            }
//            .chartYScale(domain: 0...70)
//            .chartXScale(domain: 7...11)
//        }
//        .padding(.horizontal, 24)
//        .frame(maxWidth: .infinity, alignment: .top)
//        .background(Color.black)
//    }
//}

// If you want to use your actual expense data instead:
struct ChartView: View {
    @Query(sort: \Expense.date) private var expenses: [Expense]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Expenses Chart")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer().frame(height: 24)
            
            Chart {
                ForEach(expenses, id: \.id) { expense in
                    BarMark(
                        x: .value("Day", Calendar.current.component(.day, from: expense.date)),
                        y: .value("Amount", Double(expense.amount) ?? 0.0)
                    )
                    .foregroundStyle(.blue)
                    .cornerRadius(2)
                }
            }
            .frame(maxHeight: .infinity)
//            .chartBackground { _ in
//                Color.black
//            }
//            .chartPlotStyle { plotArea in
//                plotArea
//                    .background(Color.white)
//            }
            .chartYAxis {
                AxisMarks(
                    preset: .aligned,
                    position: .leading
                ) { value in
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [2, 2]))
                        .foregroundStyle(.gray.opacity(0.5))
                    AxisValueLabel()
                        .foregroundStyle(.black)
                        .font(.system(size: 12))
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom) { value in
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [2, 2]))
                        .foregroundStyle(.gray.opacity(0.5))
                    AxisValueLabel()
                        .foregroundStyle(.black)
                        .font(.system(size: 12))
                }
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, alignment: .top)
//        .background(Color.black)
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
    day8Components.day = 8
    let day8Date = calendar.date(from: day8Components) ?? today
    
    // Create date for day 10 of current month
    var day10Components = calendar.dateComponents([.year, .month], from: today)
    day10Components.day = 10
    let day10Date = calendar.date(from: day10Components) ?? today
    
    context.insert(Expense(title: "Groceries", amount: "70.0", category: "Food", date: day8Date))
    context.insert(Expense(title: "Gas", amount: "40.0", category: "Transportation", date: day10Date))
    
    return ChartView()
        .modelContainer(container)
}
