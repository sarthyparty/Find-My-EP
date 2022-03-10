import SwiftUI

@main
struct Find_My_EPApp: App {
    init() {
        for hall in halls {
            intersects[hall.start].halls.append(hall)
            intersects[hall.end].halls.append(hall)
        }
        for i in 1...rooms.count {
            halls[rooms[i-1].hall].rooms.append(rooms[i-1])
            roomsToIDs[rooms[i-1].name] = i-1
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
