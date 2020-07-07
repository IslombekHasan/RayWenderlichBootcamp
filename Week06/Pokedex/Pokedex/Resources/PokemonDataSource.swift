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

enum ViewMode {
  case compact
  case large
}

class PokemonDataSource: NSObject {

  var viewMode: ViewMode
  let pokemons = PokemonGenerator.shared.generatePokemons()
  var favorites: [Pokemon] = []

  override init() {
    viewMode = .compact
    super.init()
  }

  convenience init(for view: ViewMode) {
    self.init()
    viewMode = view
  }

  func addToFavorites(pokemon: Pokemon) {
    favorites.append(pokemon)
  }

  func removeFromFavorites(at index: Int) {
    favorites.remove(at: index)
  }

  func isFavoritesSection(_ section: Int) -> Bool {
    return viewMode == .compact && section == 0 ? true : false
  }

}

extension PokemonDataSource: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return viewMode == .compact ? 2 : 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isFavoritesSection(section) {
      return favorites.isEmpty ? 1 : favorites.count
    }

    return pokemons.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if isFavoritesSection(indexPath.section) && favorites.isEmpty {
      return collectionView.dequeueReusableCell(withReuseIdentifier: EmptyFavoritesCell.reuseIdentifier, for: indexPath)
    }

    let pokemon = indexPath.section == 0 ? favorites[indexPath.item] : pokemons[indexPath.item]
    if let compactCell = collectionView.dequeueReusableCell(withReuseIdentifier: CompactPokemonCell.reuseIdentifier, for: indexPath) as? CompactPokemonCell {
      compactCell.pokemonImageView.image = UIImage(named: "\(pokemon.pokemonID)")
      compactCell.nameLabel.text = pokemon.pokemonName
      return compactCell
    } else if let largeCell = collectionView.dequeueReusableCell(withReuseIdentifier: LargePokemonCell.reuseIdentifier, for: indexPath) as? LargePokemonCell {
      largeCell.pokemonImageView.image = UIImage(named: "\(pokemon.pokemonID)")
      largeCell.nameLabel.text = pokemon.pokemonName
      largeCell.baseExpLabel.text = "\(pokemon.baseExp)"
      largeCell.heightLabel.text = "\(pokemon.height)"
      largeCell.weightLabel.text = "\(pokemon.weight)"
      return largeCell
    } else {
      fatalError("Can't create a cell")
    }
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? HeaderView else {
      fatalError()
    }
    headerView.headerLabel.text = indexPath.section == 0 ? "My pokemons" : "All Pokemons"
    return headerView
  }

}
