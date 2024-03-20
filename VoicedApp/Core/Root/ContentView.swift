//
//  ContentView.swift
//  VoicedApp
//
//  Created by Abraham Morales Arroyo on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
            }
            else { 
                
                VoicedTabView()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
