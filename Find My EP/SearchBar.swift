//
//  SearchBar.swift
//  Find My EP
//
//  Created by 64000774 on 3/10/22.
//

import SwiftUI

struct SearchBar: View {
    
    var searchBarText: String
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField(searchBarText, text: $searchText)
                    .padding(.leading, 24)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(15)
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if isSearching {
                        Button(action: { searchText = "" }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                        
                    }
                    
                }.padding(.horizontal, 32)
                    .foregroundColor(.gray)
            ).transition(.move(edge: .trailing))
                .animation(.spring())
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    
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
