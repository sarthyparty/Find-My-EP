import SwiftUI

struct Home: View {
    
    @State private var startID = ""
    @State private var endID = ""
    @State private var dist = 0
    @State private var hallways = ""
    @State private var inters = ""
    @State private var options = []
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    TextField("Enter start room", text: $startID)
                        .multilineTextAlignment(.center)
                    TextField("Enter end room", text: $endID)
                        .multilineTextAlignment(.center)
        
                    NavigationLink(destination: Map(stuff: school.findPath(start: rooms[Int(startID) ?? 0], end: rooms[Int(endID) ?? 5]))) {
                        HStack {
                            Spacer()
                            Text("Show Map")
                            Spacer()
                        }
                    }
                    
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
        .accentColor(Color.green)
    }
    
}

