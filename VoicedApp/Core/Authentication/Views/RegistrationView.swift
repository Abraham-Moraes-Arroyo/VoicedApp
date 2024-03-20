//
//  RegistrationView.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import SwiftUI
struct RegistrationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = RegistrationViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Image("voiced-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            VStack {
                
                // whatever user types in these fields it updates the published properties in the view model
                
                TextField("Enter your email...", text: $viewModel.email)
                    .modifier(VoicedTextFieldModifier())
                    .autocapitalization(.none)
                
                TextField("Enter your username...", text: $viewModel.username)
                    .autocapitalization(.none)
                    .modifier(VoicedTextFieldModifier())
                
                SecureField("Enter your password...", text: $viewModel.password)
                    .modifier(VoicedTextFieldModifier())
                
                
            }
            Button {
                Task { try await viewModel.createUser() }
                // when user clicks on the button, it is a registered user
                
            } label: {
                Text("Sign up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 352, height: 44)
                    .background(Color(red: 0.725, green: 0.878, blue: 0.792)) // #b9e0ca
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    
                    Text("Sign up")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                .font(.footnote)
            }
            .padding(.vertical)
            
        }
    }
}

#Preview {
    RegistrationView()
}
