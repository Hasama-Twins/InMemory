//
//  GardenDataFetcher.swift
//  InMemory
//
//  Created by Evelyn Hasama on 4/13/24.
//

import Foundation

// GardenDataFetcher is an ObservableObject to hold the fetched GardenData
class GardenDataFetcher: ObservableObject {
    @Published var gardenData: GardenData?

}
