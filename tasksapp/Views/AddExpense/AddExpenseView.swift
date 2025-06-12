import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @EnvironmentObject var viewModel: AddExpenseViewModel
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Add Expenses")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 24)
                
                Text("Enter title")
                    .font(.system(size: 12))
                ZStack(alignment: .topLeading) {
                    
                    TextEditor(text: $viewModel.title)
                        .padding(.leading, 2)
                        .foregroundColor(.primary)
                    
                    if viewModel.title.isEmpty {
                        Text("Enter title")
                            .foregroundColor(.secondary)
                            .padding(.top, 8)
                            .padding(.leading, 6)
                            .allowsHitTesting(false)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.secondary, lineWidth: 1)
                )
                
                Spacer().frame(height: 24)
                
                Text("Enter amount")
                    .font(.system(size: 12))
                
                TextField("", text: $viewModel.amount, prompt: Text("Enter amount").foregroundColor(.secondary))
                    .padding(12)
                    .foregroundColor(.primary)
                    .tint(.blue)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.numberPad)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.secondary)
                    )
                
                Spacer().frame(height: 24)
                
                Text("Select category")
                    .font(.system(size: 12))
                
                Menu {
                    ForEach(viewModel.expenseCategories, id: \.self) { category in
                        Button(category) {
                            viewModel.category = category
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.category == "" ? "Select an item" : viewModel.category)
                            .foregroundColor(
                                viewModel.category == "" ? .secondary : .primary
                            )
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.secondary)
                    }
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray)
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
                            .stroke(.secondary)
                    )
                
                Spacer().frame(height: 80)
                
                
                Button(action: {
                    viewModel.addExpense()
                }) {
                    Text("Add expense")
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(Color("ButtonColor"))
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
            .hideKeyboardOnTap()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    AddExpenseView()
        .environmentObject(AddExpenseViewModel())
        .environmentObject(RootViewModel())
}
