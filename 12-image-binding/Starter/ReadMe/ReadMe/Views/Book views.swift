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

struct TitleAndAuthorStack: View {
  let book: Book
  let titleFont: Font
  let authorFont: Font

  var body: some View {
    VStack(alignment: .leading) {
      Text(book.title)
        .font(titleFont)
      Text(book.author)
        .font(authorFont)
        .foregroundColor(.secondary)
    }
  }
}

extension Book {
  struct Image: View {
    let title: String
    var size: CGFloat?

    var body: some View {
      let symbol =
        SwiftUI.Image(title: title)
        ?? .init(systemName: "book")

      symbol
        .resizable()
        .scaledToFit()
        .frame(width: size, height: size)
        .font(Font.title.weight(.light))
        .foregroundColor(.secondary)
    }
  }
}

struct Book_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      TitleAndAuthorStack(
        book: .init(),
        titleFont: .title,
        authorFont: .title2
      )
      Book.Image(title: Book().title)
      Book.Image(title: "")
      Book.Image(title: "📖")
    }
    .previewedInAllColorSchemes
  }
}

extension Image {
  init?(title: String) {
    guard
      let character = title.first,
      case let symbolName = "\(character.lowercased()).square",
      UIImage(systemName: symbolName) != nil
    else {
      return nil
    }

    self.init(systemName: symbolName)
  }
}

extension View {
  var previewedInAllColorSchemes: some View {
    ForEach(
      ColorScheme.allCases, id: \.self,
      content: preferredColorScheme
    )
  }
}
