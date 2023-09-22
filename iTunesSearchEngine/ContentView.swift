//
//  ContentView.swift
//  iTunesSearchEngine
//
//  Created by Caleb Wong on 22/9/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                
                
                Text("Hello, world!")
                Text("Hello, world!")
            }
            .navigationTitle("Songs")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("TextFieldGray"))
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField(
                                "Search",
                                text: $viewModel.searchTerm
                            )
                            Spacer()
                            if !viewModel.searchTerm.isEmpty {
                                Button("Cancel"){
                                    viewModel.searchTerm = ""
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
