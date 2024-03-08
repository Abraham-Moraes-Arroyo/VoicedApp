//
//  LocationsViewModel.swift
//  VoicedApp
//
//  Created by Abraham Morales Arroyo on 3/8/24.
//

import Foundation

class LocationsViewModel: ObservableObject {
    @Published var locations: [Location]
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
    }
}
