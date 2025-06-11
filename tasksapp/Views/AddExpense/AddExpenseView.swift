import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @EnvironmentObject var viewModel: AddExpenseViewModel
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        VStack(alignment: .leading){
            Text("Add Expenses")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer().frame(height: 24)
            
            Text("Enter title")
                .font(.system(size: 12))
            TextField("Enter title", text: $viewModel.title)
                .padding(12)
                .textInputAutocapitalization(.never)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
            Spacer().frame(height: 24)
            
            Text("Enter amount")
                .font(.system(size: 12))
            TextField("Enter amount", text: $viewModel.amount)
                .padding(12)
                .textInputAutocapitalization(.never)
                .keyboardType(.numberPad)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                )
            
            Spacer().frame(height: 24)
            
            Text("Select category")
                .font(.system(size: 12))
            Menu {
                ForEach(viewModel.expenseCategories, id: \.self) { category in
                    Button(category) {
                        viewModel.category = category
                        // Update your view model here
                        // viewModel.category = category
                    }
                }
            } label: {
                HStack {
                    Text(viewModel.category == "" ? "Select an item" : viewModel.category)
                        .foregroundColor(viewModel.category == "" ? .gray : .primary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                )
            }
            
            Spacer().frame(height: 24)
            
            Text("Select Date")
                .font(.system(size: 12))
            
            DatePicker("Date", selection: $viewModel.date, displayedComponents: [.date])
                .datePickerStyle(.compact)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                )
            
            Spacer().frame(height: 80)
            
            
            Button(action: {
                viewModel.addExpense()
            }) {
                Text("Add expense")
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(.mint)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .onAppear {
            print("HomeView appeared")
            viewModel.setModelContext(modelContext)
            viewModel.setRootViewModel(viewModel: rootViewModel)
        }
        .padding(.horizontal, 24)
        .frame(maxHeight: .infinity, alignment: .top)
        
    }
}

#Preview {
    AddExpenseView()
        .environmentObject(AddExpenseViewModel())
        .environmentObject(RootViewModel())
}
