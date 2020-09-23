/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct ContentView: View {
  @State var addingNewBook = false
  @State var library = Library()

  var body: some View {
    NavigationView {
      List {
        Button {
          addingNewBook = true
        } label: {
          Spacer()

          VStack(spacing: 6) {
            Image(systemName: "book.circle")
              .font(.system(size: 60))
            Text("Add New Book")
              .font(.title2)
          }
          
          Spacer()
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding(.vertical, 8)
        .sheet(
          isPresented: $addingNewBook,
          content: NewBookView.init
        )

        ForEach(library.sortedBooks) { book in
          BookRow(
            book: book,
            image: $library.uiImages[book]
          )
        }
      }
      .navigationBarTitle("My Library")
    }
  }
}

struct BookRow: View {
  @ObservedObject var book: Book
  @Binding var image: UIImage?

  var body: some View {
    NavigationLink(
      destination: DetailView(book: book, image: $image)
    ) {
      HStack {
        Book.Image(
          uiImage: image,
          title: book.title,
          size: 80,
          cornerRadius: 12
        )

        VStack(alignment: .leading) {
          TitleAndAuthorStack(
            book: book,
            titleFont: .title2,
            authorFont: .title3
          )

          if !book.microReview.isEmpty {
            Spacer()
            Text(book.microReview)
              .font(.subheadline)
              .foregroundColor(.secondary)
          }
        }
        .lineLimit(1)

        Spacer()

        BookmarkButton(book: book)
          .buttonStyle(BorderlessButtonStyle())
      }
      .padding(.vertical, 8)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewedInAllColorSchemes
  }
}
