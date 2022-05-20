//
//  ContentView.swift
//  Find My EP
//
//  Created by 64000774 on 2/2/22.
//
 
import SwiftUI
 
struct ContentView: View {
    @State var dist = 0
    @State var hallways = ""
    @State var inters = ""
    @State var options = []
    @State var searchText = ""
    @State var isSearching = false
    @State var searchText2 = ""
    @State var isSearching2 = false
    @State var firstButtonPressed = false
    @State var secondButtonPressed = false
    
    var body: some View {
        NavigationView {
            ScrollView {
  
                SearchBar(searchBarText: "Enter start room...", searchText: $searchText, isSearching: $isSearching, isSearchingOther: $isSearching2)
                
                if (isSearching) {
                    ForEach(roomsToIDs.keys.filter({ "\($0)".contains(searchText.lowercased())}), id: \.self) { room in
                        
                        HStack {
                            Button(action: {
                                searchText = roomsToIDs[room]!.name
                                isSearching = false
                                firstButtonPressed = true
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                                   ,label: {
                                Text(roomsToIDs[room]!.name)
                            })
                        }
                        Spacer()
                    }
                    .padding(3)
                    
                    Divider()
                        .background(Color(.systemGray4))
                        .padding(.leading)
                } else {
                    HStack{}
                }
                
                Spacer()
                
                SearchBar(searchBarText: "Enter end room...", searchText: $searchText2, isSearching: $isSearching2, isSearchingOther: $isSearching)
                
                if(isSearching2) {
                    ForEach(roomsToIDs.keys.filter({ "\($0)".contains(searchText2.lowercased())}), id: \.self) { room in
                        
                        HStack {
                            Button(action: {
                                searchText2 = roomsToIDs[room]!.name
                                isSearching2 = false
                                secondButtonPressed = true
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                                   ,label: {
                                Text(roomsToIDs[room]!.name)
                            })
                        }
                        Spacer()
                    }
                    .padding(3)
                    
                    Divider()
                        .background(Color(.systemGray4))
                        .padding(.leading)
                }
                
                
//                NavigationLink(destination: DirectionsScreen(retval: (0.0, [0], [75,0,1,4,7,71,69, 68,66,67,61,60,59,58,56,55,88,54,51,53,50,52,33,31,39,40,38,37,34,83,33,52,27,21,28,29,64,10], [0], [CGPoint(x: 0,y: 0), CGPoint(x: 0,y: 0), CGPoint(x: 0,y: 0)], [CGPoint(x: 0,y: 0), CGPoint(x: 0,y: 0), CGPoint(x: 0,y: 0)], [false, true, false]))) {
                NavigationLink(destination: DirectionsScreen(retval: findPath(start: roomsToIDs[searchText.lowercased()] ?? rooms[0], end: roomsToIDs[searchText2.lowercased()] ?? rooms3[0]))) {
                    HStack {
                        Spacer()
                        Text("Show Map")
                        Spacer()
                    }
                }
                .disabled(roomsToIDs[searchText.lowercased()] == nil || roomsToIDs[searchText2.lowercased()] == nil)
                
            }.navigationTitle("EPHS Maps")
            
        }
        
    }
    
}
 
 
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HStack {
//            ContentView()
//            ContentView()
//                .colorScheme(.dark)
//        }.previewLayout(.fixed(width: 600, height: 600))
//
//    }
//}
