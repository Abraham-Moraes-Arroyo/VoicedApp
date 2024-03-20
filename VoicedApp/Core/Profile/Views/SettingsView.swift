//
//  SettingsView.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/19/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var showActionSheet = false

    var body: some View {
        NavigationView {
            List {
                Section {
                    Button("Sign Out") {
                        // Placeholder action for sign out
                        print("Sign Out tapped")
                    }
                }

                Section {
                    Button("Delete Account") {
                        showActionSheet = true
                    }
                    .foregroundColor(.red)
                }
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("Confirm Deletion"), message: Text("Are you sure you want to delete your account? This cannot be undone."),
                        buttons: [
                            .destructive(Text("Delete Account")) {
                                // Placeholder action for account deletion
                                print("Delete Account confirmed")
                            },
                            .cancel()
                        ])
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    SettingsView()
}
