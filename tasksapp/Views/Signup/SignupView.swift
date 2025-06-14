import SwiftUI

struct SignupView: View {
    @EnvironmentObject var viewModel: SignupViewModel
    @EnvironmentObject var navigation: NavigationCoordinator
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                Text("Create new account!")
                    .font(.system(size: 36, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer().frame(width: 100)
            }
            
            Spacer().frame(height: 56)
            
            Text("Enter email")
                .font(.system(size: 12))
            TextField("Enter email", text: $viewModel.email)
                .padding(12)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            if (viewModel.isSubmitted && viewModel.email.isEmpty) {
                Text("Please enter valid email to continue")
                    .font(.system(size: 12))
                    .foregroundColor(.red)
            }
            
            Spacer().frame(height: 16)
            
            Text("Enter password")
                .font(.system(size: 12))
            TextField("Enter password", text: $viewModel.password)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            if (viewModel.isSubmitted && viewModel.password.isEmpty) {
                Text("Please enter a valid password to continue")
                    .font(.system(size: 12))
                    .foregroundColor(.red)
            }
            
            
            Spacer().frame(height: 40)
            
            Button(action: {
                viewModel.signup()
            }) {
                Text("Sign up")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(Color.purple)
                    .cornerRadius(8)
            }
            
            Spacer().frame(height: 32)
            
            HStack{
                Spacer()
                Text("Already have an account? Login")
                    .font(.system(size: 12))
                    .underline()
                    .onTapGesture {
                        
                    }
            }
            
            
        }
        .onAppear {
            viewModel.navigation = navigation
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    SignupView()
        .environmentObject(SignupViewModel())
        .environmentObject(NavigationCoordinator())
}
