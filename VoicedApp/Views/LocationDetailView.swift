//
//  LocationDetailView.swift
//  VoicedApp
//
//  Created by Abraham Morales Arroyo on 3/14/24.
//

import SwiftUI

struct LocationDetailView: View {
    
    let location: Location
    
    var body: some View {
        ScrollView{
            VStack{
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y:10)
                
                
                VStack(alignment: .leading, spacing: 16) {
                   titleSection
                    Divider()
                    descriptionSection
                    
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
    }
}

extension LocationDetailView {
    private var imageSection: some View{
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0) // this is reference to the first image that is in the list.
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            //13:17
            
        }
    }

}
