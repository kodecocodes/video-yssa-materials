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

import Combine
import class UIKit.UIImage

class Library: ObservableObject {
  var sortedBooks: [Book] { booksCache }

  /// Adds a new book at the start of the library's manually-sorted books.
  func addNewBook(_ book: Book, image: UIImage?) {
    booksCache.insert(book, at: 0)
    uiImages[book] = image
  }

  /// An in-memory cache of the manually-sorted books that are persistently stored.
  @Published private var booksCache: [Book] = [
    .init(title: "Ein Neues Land", author: "Shaun Tan"),
    .init(
      title: "Bosch",
      author: "Laurinda Dixon",
      microReview: "Earthily Delightful."
    ),
    .init(title: "Dare to Lead", author: "Brené Brown"),
    .init(
      title: "Blasting for Optimum Health Recipe Book",
      author: "NutriBullet",
      microReview: "Blastastic!"
    ),
    .init(title: "Drinking with the Saints", author: "Michael P. Foley"),
    .init(title: "A Guide to Tea", author: "Adagio Teas"),
    .init(title: "The Life and Complete Work of Francisco Goya", author: "P. Gassier & J Wilson"),
    .init(title: "Lady Cottington's Pressed Fairy Book", author: "Lady Cottington"),
    .init(title: "How to Draw Cats", author: "Janet Rancan"),
    .init(title: "Drawing People", author: "Barbara Bradley"),
    .init(title: "What to Say When You Talk to Yourself", author: "Shad Helmstetter")
  ]

  @Published var uiImages: [Book: UIImage] = [:]
}

private extension Dictionary {
  /// Same values, corresponding to `map`ped keys.
  ///
  /// - Parameter transform: Accepts each key of the dictionary as its parameter
  ///   and returns a key for the new dictionary.
  /// - Postcondition: The collection of transformed keys must not contain duplicates.
  func mapKeys<Transformed>(
    _ transform: (Key) throws -> Transformed
  ) rethrows -> [Transformed: Value] {
    .init(
      uniqueKeysWithValues: try map { (try transform($0.key), $0.value) }
    )
  }
}
