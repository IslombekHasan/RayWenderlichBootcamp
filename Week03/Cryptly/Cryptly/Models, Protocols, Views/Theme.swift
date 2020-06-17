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
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import UIKit

protocol Theme {
  var backgroundColors: [UIColor] { get }
  var textColor: UIColor { get }
  var borderColor: UIColor { get }
  var widgetBackgroundColor: UIColor { get }
}

protocol Themable {
  func registerForTheme()
  func unregisterForTheme()
  func themeChanged()
}

struct LightTheme: Theme {
  let backgroundColors: [UIColor] = [UIColor(red:0.416, green:0.416, blue:0.808, alpha: 1.000), UIColor(red:0.459, green:0.592, blue:0.890, alpha: 1.000)]
  let textColor: UIColor = .black
  let borderColor: UIColor = UIColor(red:0.545, green:0.396, blue:0.671, alpha: 1.000)
  let widgetBackgroundColor: UIColor = .white
}

struct DarkTheme: Theme {
  let backgroundColors: [UIColor] = [UIColor(red: 0.059, green: 0.039, blue: 0.098, alpha: 1.000), UIColor(red:0.459, green:0.071, blue:0.875, alpha: 1.000)]
  let textColor: UIColor = .white
  let borderColor: UIColor = UIColor(red:0.506, green:0.388, blue:0.671, alpha: 1.000)
  let widgetBackgroundColor: UIColor = UIColor(red: 0.125, green: 0.071, blue: 0.259, alpha: 1.000)
}
