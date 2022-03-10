import SwiftUI

struct SearchBarEnd: View {
    
    @Binding var searchText2: String
    @Binding var isSearching2: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField("Enter ending room number", text: $searchText2)
                    .padding(.leading, 24)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(15)
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching2 = true
            })
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if isSearching2 {
                        Button(action: { searchText2 = "" }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                        
                    }
                    
                }.padding(.horizontal, 32)
                    .foregroundColor(.gray)
            ).transition(.move(edge: .trailing))
                .animation(.spring())
            
            if isSearching2 {
                Button(action: {
                    isSearching2 = false
                    searchText2 = ""
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, 0)
                })
                    .transition(.move(edge: .trailing))
                    .animation(.spring())
            }
            
        }
    }
}
