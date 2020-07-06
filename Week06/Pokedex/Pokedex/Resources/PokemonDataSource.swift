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

class PokemonDataSource: NSObject, UICollectionViewDataSource {

  let pokemons = PokemonGenerator.shared.generatePokemons()

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pokemons.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let pokemon = pokemons[indexPath.item]
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
      fatalError("Can't create cell")
    }

  }


}
