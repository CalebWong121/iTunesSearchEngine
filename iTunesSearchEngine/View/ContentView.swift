import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    @State var shouldNav: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                VStack (spacing: 20) {
                    SearchBarView(viewModel: viewModel, shouldNav: $shouldNav)
                    .frame(height: 40)
                    HStack {
                        Text("\(AppString.filterByCountry[viewModel.language]!):")
                        Picker("Country", selection: $viewModel.country) {
                            ForEach(Country.allCases) { country in
                                Text(viewModel.getCountryString(country: country)).tag(country)
                            }
                        }
                        .frame(width: 150)
                        Spacer()
                        NavigationLink {
                            BookMarkView(viewModel: viewModel)
                        } label: {
                            Text(AppString.bookMark[viewModel.language]!)
                        }
                    }
                    Divider()
                    HStack {
                        Text("\(AppString.searchHistory[viewModel.language]!):")
                            .font(.title3)
                        Spacer()
                    }
                    .padding(10)
                    SearchHistoryView(viewModel: viewModel, onCommit: {
                        shouldNav = true
                    })
                }
                .padding(.horizontal, 20)
                NavigationLink(isActive: $shouldNav) {
                    AllResultView(viewModel: viewModel)
                } label: {
                    EmptyView()
                }
                Spacer()
            }
            .navigationTitle("iTunes Search")
            .toolbar {
                ToolbarItem {
                    Picker("Language", selection: $viewModel.language) {
                        ForEach(Language.allCases) { language in
                            Text(language.rawValue).tag(language)
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
