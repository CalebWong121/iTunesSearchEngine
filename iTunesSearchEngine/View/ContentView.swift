import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    @State var ShouldNav: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                VStack (spacing: 0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("TextFieldGray"))
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField(
                                "Search",
                                text: $viewModel.searchTerm,
                                onCommit: {
                                    if !viewModel.searchTerm.isEmpty {
                                        ShouldNav = true
                                        if !viewModel.searchHistory.contains(viewModel.searchTerm) {
                                            viewModel.searchHistory.append(viewModel.searchTerm)
                                        }
                                    }
                                }
                            )
                            .autocapitalization(.none)
                            .autocorrectionDisabled(true)
                            Spacer()
                            if !viewModel.searchTerm.isEmpty {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .onTapGesture {
                                        viewModel.searchTerm = ""
                                    }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .frame(height: 40)
                    .padding(.vertical, 10)
                    HStack {
                        Text("Filter by country:")
                        Picker("Number", selection: $viewModel.country) {
                            ForEach(Country.allCases) { country in
                                Text(country.rawValue).tag(country)
                            }
                        }
                        .frame(width: 60)
                        Spacer()
                        NavigationLink {
                            BookMarkView(viewModel: viewModel)
                        } label: {
                            Text("Book Mark")
                        }
                    }
                    Divider()
                    HStack {
                        Text("Search history:")
                            .font(.title3)
                        Spacer()
                    }
                    .padding(10)
                    SearchHistoryView(viewModel: viewModel, onCommit: {
                        ShouldNav = true
                    })
                }
                .padding(.horizontal, 20)
                NavigationLink(isActive: $ShouldNav) {
                    AllResultView(viewModel: viewModel)
                } label: {
                    EmptyView()
                }
                Spacer()
            }
            .navigationTitle("iTunes Search")

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
