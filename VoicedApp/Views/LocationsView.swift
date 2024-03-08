//
//  LocationsView.swift
//  VoicedApp
//
//  Created by Abraham Morales Arroyo on 3/8/24.
//

import SwiftUI




struct LocationsView: View {
    // enviroment object
    
    @EnvironmentObject private var vm: LocationsViewModel
    var body: some View {
        List{
            ForEach(vm.locations){
                Text($0.name)
            }
        }
    }
}

struct LocationsView_Previews: PreviewProvider{
    static var previews: some View{
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
