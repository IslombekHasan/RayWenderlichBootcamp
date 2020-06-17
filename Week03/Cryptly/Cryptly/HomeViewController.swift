/// Copyright (c) 2020 Islombek Khasanov

import UIKit

class HomeViewController: UIViewController {

  @IBOutlet weak var view1: CryptoView!
  @IBOutlet weak var view2: CryptoView!
  @IBOutlet weak var view3: CryptoView!
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var view1TextLabel: CryptoDataLabel!
  @IBOutlet weak var view2TextLabel: CryptoDataLabel!
  @IBOutlet weak var view3TextLabel: CryptoDataLabel!
  @IBOutlet weak var view4TextLabel: CryptoDataLabel!
  @IBOutlet weak var view5TextLabel: CryptoDataLabel!
  @IBOutlet weak var themeSwitch: UISwitch!

  let cryptoData = DataGenerator.shared.generateData()
  var allCrypto: [CryptoCurrency] = []
  var raisedCrypto: [CryptoCurrency] = []
  var fallenCrypto: [CryptoCurrency] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    setupData()
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

  func setupData() {
    if let data = cryptoData {
      allCrypto = data
      raisedCrypto = data.filter { $0.trend == .rising }
      fallenCrypto = data.filter { $0.trend == .falling }
    }
  }

  func setupLabels() {
    setData(for: view1TextLabel, with: allCrypto)
    setData(for: view2TextLabel, with: raisedCrypto)
    setData(for: view3TextLabel, with: fallenCrypto)
    
    headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    view4TextLabel.text = "\(fallenCrypto.map { $0.valueRise }.min() ?? 0)"
    view5TextLabel.text = "\(raisedCrypto.map { $0.valueRise }.max() ?? 0)"
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

    // i could've used optional unwrapping but i know that the CALayer is there
    let gradient = self.view.layer.sublayers?[0] as! CAGradientLayer
    gradient.colors = theme?.backgroundColors.map { $0.cgColor }

    UIView.animate(withDuration: 0.4, animations: {

      // array of all cryptoviews
      let cryptoViews = self.view.subviews.filter { $0 is CryptoView }

      // array of all labels inside cryptoviews
      var labels: [UILabel] = cryptoViews.map { cryptoView in
        return cryptoView.subviews.filter { $0 is UILabel }.map { $0 as! UILabel }
      }.flatMap { $0 }

      labels.append(self.headingLabel)

      cryptoViews.forEach { (view) in
        view.backgroundColor = theme?.widgetBackgroundColor
        view.layer.borderColor = theme?.borderColor.cgColor
      }

      labels.forEach { (label) in
        label.textColor = theme?.textColor
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
