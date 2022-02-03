//
//  Find_My_EPApp.swift
//  Find My EP
//
//  Created by 64000774 on 2/2/22.
//

import SwiftUI

@main
struct Find_My_EPApp: App {
    init() {
        for hall in halls {
          intersects[hall.start].hallways.append(hall)
          intersects[hall.end].hallways.append(hall)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
