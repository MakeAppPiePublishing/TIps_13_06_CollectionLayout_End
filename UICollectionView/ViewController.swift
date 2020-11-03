//
//  ViewController.swift
//  UICollectionView
//
//  Created by Steven Lipton on 10/27/20.
//

import UIKit

class ViewController: UIViewController{
    var sections = [0]
    var itemCount = 10
    var items = ["pencil","highlighter","paperclip","scissors","paintbrush","ruler","pin"]
    var dataSource: UICollectionViewDiffableDataSource<Int, String>! = nil
    var collectionView: UICollectionView! = nil
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //select a layout
        //let layout = UICollectionViewCompositionalLayout.list(using: UICollectionLayoutListConfiguration(appearance: .insetGrouped))
        let itemsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemsize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        //set the layout
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        //allow for resizing
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //add the view
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
        //collectionView.delegate = self
        
        //Data source stuff replaces cellForRow
        //first register a cell, and include how to add data in the clusure.
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item
            content.image = UIImage(systemName:item)
            content.textProperties.color = .darkText
            content.imageProperties.tintColor = .darkText
            var background = cell.backgroundConfiguration
            background?.backgroundColor = .systemYellow
            background?.cornerRadius = 5
            cell.backgroundConfiguration = background
            cell.contentConfiguration = content
        }
        //set the diffable data source, again in a closure.
        dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        //and put in the initial data, assigning the snapshot to the data source.
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections(sections)
        snapshot.appendItems(items)
        var moreItems = [String]()
        for newItem in 0...50{
            moreItems += ["\(newItem).circle"]
        }
        snapshot.appendItems(moreItems)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
}
