import SwiftUI

struct SearchBarView: View {
    @ObservedObject var viewModel: ViewModel
    @Binding var shouldNav: Bool
    var body: some View {
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
                            shouldNav = true
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
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(viewModel: ViewModel(), shouldNav: Binding.constant(false))
    }
}
