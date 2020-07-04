//
//  ViewController.swift
//  RW-CollectionView-CompositionalLayouts
//
//  Created by Islombek Hasanov on 7/3/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Section {
        case main
    }

    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.collectionViewLayout = configureLayout()
        configureDataSource()
    }

    func configureLayout() -> UICollectionViewCompositionalLayout {
//        // swap sizes of group and items to see the differentce
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
////        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 0)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(0.5))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
////        group.interItemSpacing = .flexible(8)
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPagingCentered
////        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
////        section.interGroupSpacing = 15
//
////        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
////        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
////        section.boundarySupplementaryItems = [header]
        
        let inset: CGFloat = 8
        let insets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // items
        let topItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(9/16))
        let topItem = NSCollectionLayoutItem(layoutSize: topItemSize)
        topItem.contentInsets = insets
        
        let bottomItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let bottomItem = NSCollectionLayoutItem(layoutSize: bottomItemSize)
        bottomItem.contentInsets = insets
        
        // groups
        let bottomGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bottomGroupSize, subitem: bottomItem, count: 2)
        let fullGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(9/16 + 0.5))
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: fullGroupSize, subitems: [topItem, bottomGroup])
        let section = NSCollectionLayoutSection(group: nestedGroup)
        
        return UICollectionViewCompositionalLayout(section: section)
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView) { (collectionView, indexPath, number) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseIdentifier, for: indexPath) as? NumberCell else {
                fatalError()
            }

            cell.backgroundColor = indexPath.row % 2 == 0 ? .darkGray : .gray
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
            cell.label.text = number.description

            return cell
        }

        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(Array(1...100))
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }

}

