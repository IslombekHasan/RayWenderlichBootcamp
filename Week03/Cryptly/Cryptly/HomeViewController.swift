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

import UIKit

class HomeViewController: UIViewController {

  @IBOutlet weak var view1: CryptoView!
  @IBOutlet weak var view2: CryptoView!
  @IBOutlet weak var view3: CryptoView!
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var view1TextLabel: UILabel!
  @IBOutlet weak var view2TextLabel: UILabel!
  @IBOutlet weak var view3TextLabel: UILabel!
  @IBOutlet weak var themeSwitch: UISwitch!

  let cryptoData = DataGenerator.shared.generateData()
  var allCrypto: [CryptoCurrency] = []
  var raisedCrypto: [CryptoCurrency] = []
  var fallenCrypto: [CryptoCurrency] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    if let data = cryptoData {
      allCrypto = data
      raisedCrypto = data.filter { $0.currentValue > $0.previousValue }
      fallenCrypto = data.filter { $0.previousValue > $0.currentValue }
    }

    setupLabels()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerForTheme()
    setUpInitialTheme()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForTheme()
  }

  func setupLabels() {
    headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    view1TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    view2TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    view3TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)

    setData(for: view1TextLabel, with: allCrypto)
    setData(for: view2TextLabel, with: raisedCrypto)
    setData(for: view3TextLabel, with: fallenCrypto)
  }

  func setData(for label: UILabel, with data: [CryptoCurrency]) {
    let concatenatedData = data.map { $0.name }.joined(separator: ", ")
    label.text = concatenatedData.isEmpty ? "No data is provided" : concatenatedData
  }

  @IBAction func switchPressed(_ sender: Any) {
    ThemeManager.shared.set(theme: themeSwitch.isOn ? DarkTheme() : LightTheme())
  }
}

extension HomeViewController: Themable {

  func setUpInitialTheme() {
    let gradient = CAGradientLayer()
    gradient.frame = self.view.bounds
    gradient.startPoint = CGPoint(x: 0, y: 0)
    view.layer.insertSublayer(gradient, at: 0)

    if let theme = UserDefaults.standard.object(forKey: "theme") as? Theme {
      ThemeManager.shared.set(theme: theme)
    } else {
      ThemeManager.shared.set(theme: LightTheme())
    }
  }

  @objc func themeChanged() {
    let theme = ThemeManager.shared.currentTheme
    let gradient = self.view.layer.sublayers?[0] as! CAGradientLayer
    gradient.colors = theme?.backgroundColors.map { $0.cgColor }
    
    UIView.animate(withDuration: 0.4, animations: {
      [self.view1, self.view2, self.view3].forEach { (view) in
        view?.backgroundColor = theme?.widgetBackgroundColor
        view?.layer.borderColor = theme?.borderColor.cgColor
      }

      [self.headingLabel, self.view1TextLabel, self.view2TextLabel, self.view3TextLabel].forEach { (label) in
        label?.textColor = theme?.textColor
      }
    })
  }

  func registerForTheme() {
    NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: Notification.Name.init("themeChanged"), object: nil)
  }

  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }

}
