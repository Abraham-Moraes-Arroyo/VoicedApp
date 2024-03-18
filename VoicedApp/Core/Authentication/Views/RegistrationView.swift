//
//  RegistrationView.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import SwiftUI
struct RegistrationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var username = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "apple.logo")
            // placeholder where app logo would be placed
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            VStack {
                TextField("Enter your email...", text: $email)
                    .modifier(VoicedTextFieldModifier())
                    .autocapitalization(.none)
                SecureField("Enter your password...", text: $password)
                    .modifier(VoicedTextFieldModifier())
                
                TextField("Enter your full name...", text: $fullname)
                    .modifier(VoicedTextFieldModifier())
                
                TextField("Enter your username...", text: $username)
                    .modifier(VoicedTextFieldModifier())
                
            }
            Button {
                
            } label: {
                Text("Sign up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 352, height: 44)
                    .background(.black)
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
