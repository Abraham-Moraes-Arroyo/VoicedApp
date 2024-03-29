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
        ScrollView {
            VStack(spacing: 20) {
                Text("Create an account")
                    .font(.title)
                    .fontWeight(.semibold)
                
                // Existing fields
                TextField("Enter your username...", text: $viewModel.username)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter your email...", text: $viewModel.email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Enter your password...", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // New optional fields
                TextField("Zip Code (Optional)", text: Binding<String>(
                    get: { viewModel.zipCode ?? "" },
                    set: { viewModel.zipCode = $0.isEmpty ? nil : $0 }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())


                // Age picker
                Picker("Age Category (Optional)", selection: $viewModel.selectedAge) {
                    Text("Select").tag(AgeCategory?.none)
                    ForEach(AgeCategory.allCases, id: \.self) { age in
                        Text(age.rawValue).tag(age as AgeCategory?)
                    }
                }.pickerStyle(MenuPickerStyle())
                
                TextField("Main Reason for Using Voiced (Optional)", text: Binding<String>(
                    get: { viewModel.reasonForUsing ?? "" },
                    set: { viewModel.reasonForUsing = $0.isEmpty ? nil : $0 }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())

                
                // Community issues
                Text("Community Issues (Optional)")
                ForEach(CommunityIssue.allCases, id: \.self) { issue in
                    Button(action: {
                        viewModel.toggleCommunityIssue(issue)
                    }) {
                        HStack {
                            Text(issue.rawValue)
                            if viewModel.isCommunityIssueSelected(issue) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
                // Discovery method
                Text("How Did You Find Out About Voiced? (Optional)")
                ForEach(DiscoveryMethod.allCases, id: \.self) { method in
                    Button(action: {
                        viewModel.toggleDiscoveryMethod(method)
                    }) {
                        HStack {
                            Text(method.rawValue)
                            if viewModel.isDiscoveryMethodSelected(method) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }

                Button(action: {
                    Task {
                        try await viewModel.createUser()
                    }
                }) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button("Already have an account? Log in") {
                    dismiss()
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationBarTitle("Sign Up", displayMode: .inline)
    }
}

#Preview {
    RegistrationView()
}
