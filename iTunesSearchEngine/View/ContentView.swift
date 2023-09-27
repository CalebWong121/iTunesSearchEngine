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
                                AppString.search[viewModel.language]!,
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
