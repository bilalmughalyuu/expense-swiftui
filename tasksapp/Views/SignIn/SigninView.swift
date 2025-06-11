import SwiftUI

struct SigninView: View {
    @EnvironmentObject var viewModel: SigninViewModel
    @EnvironmentObject var navigation: NavigationCoordinator
    var body: some View {
        VStack (alignment: .leading){
            Text("Sign in")
                .font(.system(size: 40, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer().frame(height: 40)
            
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
            
            Spacer().frame(height: 16)
            
            Text("Enter password")
                .font(.system(size: 12))
            TextField("Enter password", text: $viewModel.password)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
            
            Spacer().frame(height: 40)
            
            Button(action: {
                viewModel.signIn()
            }) {
                Text("Sign in")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(Color.purple)
                    .cornerRadius(8)
            }
            
            Spacer().frame(height: 32)
            
            HStack{
                Spacer()
                Text("Don't have an account? Sign up")
                    .font(.system(size: 12))
                    .underline()
                    .onTapGesture {
                        navigation.push(LoginNavigation.signup)
                    }
            }
        }
        .padding(.horizontal, 24)
        .onAppear {
            viewModel.navigation = navigation
        }
    }
}

#Preview {
    SigninView()
        .environmentObject(SigninViewModel())
        .environmentObject(NavigationCoordinator())
}
