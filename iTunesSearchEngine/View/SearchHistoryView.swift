//
//  SearchHistoryView.swift
//  iTunesSearchEngine
//
//  Created by Caleb Wong on 27/9/2023.
//

import SwiftUI

struct SearchHistoryView: View {
    @ObservedObject var viewModel: ViewModel
    var onCommit: () -> Void
    var body: some View {
        ScrollView {
            ForEach(viewModel.searchHistory.indices, id: \.self){ index in
                HStack {
                    Button(viewModel.searchHistory[index]){
                        viewModel.searchTerm = viewModel.searchHistory[index]
                        onCommit()
                    }
                    Spacer()
                    Button {
                        viewModel.searchHistory.remove(at: index)
                    } label: {
                        Image(systemName: "trash")
                    }
                }
                Divider()
            }
        }
    }
}

struct SearchHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        SearchHistoryView(viewModel: ViewModel(), onCommit: {})
    }
}
