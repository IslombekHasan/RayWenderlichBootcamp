//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController {

  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  private var fetchedRC: NSFetchedResultsController<Sandwich>!

  let searchController = UISearchController(searchResultsController: nil)

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    if self.isFirstLaunch() {
      populateCoreData()
    }
    loadSandwiches()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
    navigationItem.rightBarButtonItem = addButton

    // Setup Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Filter Sandwiches"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
    searchController.searchBar.selectedScopeButtonIndex = getSearchScopeIndex()
    searchController.searchBar.delegate = self
  }

  @objc
  func presentAddView(_ sender: Any) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }

}

// MARK: Sandwiches
extension SandwichViewController: SandwichDataSource {

  func loadSandwiches(_ query: String = "", _ saturation: SauceAmount? = nil) {
    let request = Sandwich.fetchRequest() as NSFetchRequest<Sandwich>

    let sortByName = NSSortDescriptor(key: #keyPath(Sandwich.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
    request.sortDescriptors = [sortByName]

    var predicates: [NSPredicate] = []

    // THIS DOES NOT WORK!
//          let noSaucePredicate = NSPredicate(format: "%K == %@", #keyPath(Sandwich.saturation.level), SauceAmount.none.rawValue)
//          let tooMuchSaucePredicate = NSPredicate(format: "%K == %@", #keyPath(Sandwich.saturation.level), SauceAmount.tooMuch.rawValue)
//          let anySaucinessPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [noSaucePredicate, tooMuchSaucePredicate])
//
//          let saucePredicate: NSPredicate
//          switch saturation {
//          case .none:
//            saucePredicate = noSaucePredicate
//          case .tooMuch:
//            saucePredicate = tooMuchSaucePredicate
//          default:
//            saucePredicate = anySaucinessPredicate
//          }
    
    if !isSearchBarEmpty {
      let searchPredicate = NSPredicate(format: "name CONTAINS[cd] %@", query)
      predicates.append(searchPredicate)
    }

    if let saturation = saturation, saturation != .any {
      let saucePredicate = NSPredicate(format: "%K == %@", #keyPath(Sandwich.saturation.level), saturation.rawValue)
      predicates.append(saucePredicate)
    }

    request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)

    fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)

    do {
      try fetchedRC.performFetch()
    } catch let error {
      displayFetchError(with: error)
    }

  }

  func populateCoreData() {
    guard let sandwichesURL = Bundle.main.url(forResource: "sandwiches", withExtension: "json") else { return }
    do {
      let decoder = JSONDecoder()
      let data = try Data(contentsOf: sandwichesURL)
      let sandwiches = try decoder.decode([SandwichData].self, from: data)

      for sandwichData in sandwiches {
        createNewSandwich(with: sandwichData)
      }
    } catch let error {
      displayFetchError(with: error)
    }
  }

  func createNewSandwich(with sandwichData: SandwichData) {
    let sandwich = Sandwich(entity: Sandwich.entity(), insertInto: context)
    let saturation = Saturation(entity: Saturation.entity(), insertInto: context)
    sandwich.imageName = sandwichData.imageName
    sandwich.name = sandwichData.name
    saturation.sauceAmount = sandwichData.sauceAmount
    saturation.sandwich = sandwich
    appDelegate.saveContext()
  }

  func saveSandwich(_ sandwich: SandwichData) {
    createNewSandwich(with: sandwich)
    loadSandwiches()
    tableView.reloadData()
  }

  func displayFetchError(with error: Error) {
    let alert = UIAlertController(title: "Could not load sandwiches :[", message: "\(error.localizedDescription)", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    alert.addAction(action)
    present(alert, animated: true)
  }
}

// MARK: - Table View
extension SandwichViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let objs = fetchedRC.fetchedObjects else {
      return 0
    }

    return objs.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
      else { return UITableViewCell() }

    let sandwich = fetchedRC.object(at: indexPath)

    cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
    cell.nameLabel.text = sandwich.name
    cell.sauceLabel.text = sandwich.saturation.sauceAmount.description

    return cell
  }
}

// MARK: - Search and Filter Controllers
extension SandwichViewController: UISearchResultsUpdating, UISearchBarDelegate {
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }

  var isFiltering: Bool {
    let searchBarScopeIsFiltering =
      searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive &&
      (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }

  func filterContentForSearchText(_ searchText: String,
                                  sauceAmount: SauceAmount? = nil) {
    loadSandwiches(searchText, sauceAmount)
    tableView.reloadData()
  }

  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])

    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }

  func searchBar(_ searchBar: UISearchBar,
                 selectedScopeButtonIndexDidChange selectedScope: Int) {
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![selectedScope])
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
    saveSearchScope(with: selectedScope)
  }
}

// MARK: User Defaults
extension SandwichViewController {
  var searchScopeKey: String {
    "searchScope"
  }

  func saveSearchScope(with index: Int) {
    UserDefaults.standard.set(index, forKey: searchScopeKey)
  }

  func getSearchScopeIndex() -> Int {
    UserDefaults.standard.integer(forKey: searchScopeKey)
  }
  
  func isFirstLaunch() -> Bool {
    if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
      UserDefaults.standard.set(true, forKey: "isFirstLaunch")
      UserDefaults.standard.synchronize()
      return true
    }
    return false
  }
}
