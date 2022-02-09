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
          intersects[hall.start].halls.append(hall)
          intersects[hall.end].halls.append(hall)
        }
        for room in rooms {
            halls[room.hall].rooms.append(room)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
