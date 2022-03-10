import SwiftUI

struct ContentView: View {
    
    @State var startID = ""
    @State var endID = ""
    @State var dist = 0
    @State var hallways = ""
    @State var inters = ""
    @State var options = []
    @State var searchText = ""
    @State var isSearching = false
    @State var searchText2 = ""
    @State var isSearching2 = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                SearchBarStart(searchText: $searchText, isSearching: $isSearching)
                
                ForEach(rooms.filter({ "\($0)".contains(searchText)}), id: \.self) { room in
                    
                    HStack {
                        Button(action: {
                            searchText = room.name
                            startID = room.name
                            isSearching = false
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                            ,label: {
                            Text(room.name)
                        })
                    }
                    Spacer()
                }
                .padding(3)
                
                Divider()
                    .background(Color(.systemGray4))
                    .padding(.leading)
                
                SearchBarEnd(searchText2: $searchText2, isSearching2: $isSearching2)
                
                ForEach(rooms.filter({ "\($0)".contains(searchText2)}), id: \.self) { room in
                    
                    HStack {
                        Button(action: {
                            searchText2 = room.name
                            endID = room.name
                            isSearching2 = false
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                            ,label: {
                            Text(room.name)
                        })
                    }
                    Spacer()
                }
                .padding(3)
                
                Divider()
                    .background(Color(.systemGray4))
                    .padding(.leading)
                NavigationLink(destination: Map(stuff: school.findPath(start: rooms[roomsToIDs[searchText] ?? 4], end: rooms[roomsToIDs[searchText2] ?? 9]))) {
                    HStack {
                        Spacer()
                        Text("Show Map")
                        Spacer()
                    }
                }
                
            }
            
            
        }
        .navigationTitle("Find My EP")
       
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ContentView()
            ContentView()
                .colorScheme(.dark)
        }.previewLayout(.fixed(width: 600, height: 600))
        
    }
}
