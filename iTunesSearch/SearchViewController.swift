//
//  SearchViewController.swift
//  iTunesSearch
//
//  Created by MOJO on 2024/6/7.
//


import UIKit

class SearchViewController:UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    var selectedIndexPath: IndexPath?
    var items = [StoreModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func fetchMatchingItems() {
        
        self.items = []
        self.collectionView.reloadData()
        
        let searchTerm = textField.text ?? ""
        
        if !searchTerm.isEmpty {
            
            StoreItemController.shared.fetchItems(term: searchTerm) { items in
                if let items = items {
                    self.items = items
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    func configure(cell: CollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        
        let item = self.items[indexPath.row]
        
        cell.trackName.text = item.name
        cell.trackTimeMillis.text = "\(item.trackTimeMillis)"
//        cell.longDescription.text = item.longDescription
        cell.artworkUrl100?.image = UIImage(systemName: "photo")
        
        // initialize a network task to fetch the item's artwork
        StoreItemController.shared.fetchImage(from: item.artworkURL) { image in
            if let image = image {
                DispatchQueue.main.async {
                    cell.artworkUrl100.image = image
                }
            }
        }
    }
    
    @IBAction func filterOptionUpdated(_ sender: UISegmentedControl) {
        
        fetchMatchingItems()
    }
    
    @IBAction func searchMusic(_ sender: Any) {
        fetchMatchingItems()
    }
    
}



extension SearchViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
//        cell.play = true
        if selectedIndexPath == indexPath {
                    selectedIndexPath = nil
//            cell.heightConstraint.constant = 0
                } else {
                    selectedIndexPath = indexPath
//                    cell.heightConstraint.constant = 200
                }
        UIView.animate(withDuration: 0.3, animations: {
                    collectionView.collectionViewLayout.invalidateLayout()
                })

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        print(cell.longDescription.frame.height)
        let longDescriptionHeight = cell.longDescription.frame.height
        let width =  view.frame.width - 30
        var height = width/3 >= longDescriptionHeight ? width/3 + 70 : longDescriptionHeight + 70
        if let selectedIndexPath = selectedIndexPath, selectedIndexPath == indexPath {
            height += 200
        }
        return .init(width: width, height: height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
}


