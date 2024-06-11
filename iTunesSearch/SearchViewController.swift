//
//  SearchViewController.swift
//  iTunesSearch
//
//  Created by MOJO on 2024/6/7.
//


import UIKit
import Foundation

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
        
        let formatter = DateComponentsFormatter()
        let second = TimeInterval(item.trackTimeMillis/1000)
        let trackTimeMillis =  formatter.string(from: second)
        
        cell.trackName.text = item.name
        cell.playTrackName.text = item.name
        cell.trackTimeMillis.text = trackTimeMillis
        cell.playTrackTimeMillis.text = trackTimeMillis
        //        cell.longDescription.text = item.longDescription
        cell.artworkUrl100?.image = UIImage(systemName: "photo")
        cell.playArtworkUrl100?.image = UIImage(systemName: "photo")
        cell.url = item.previewUrl
        
        // initialize a network task to fetch the item's artwork
        StoreItemController.shared.fetchImage(from: item.artworkURL) { image in
            if let image = image {
                DispatchQueue.main.async {
                    cell.artworkUrl100.image = image
                    cell.playArtworkUrl100.image = image
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
        
        if self.selectedIndexPath == indexPath {
            self.selectedIndexPath = nil
        } else {
            self.selectedIndexPath = indexPath
        }
        UIView.animate(withDuration: 0.3, animations: {
            collectionView.collectionViewLayout.invalidateLayout()
        })
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let longDescriptionHeight = cell.longDescription.frame.height
        let width =  view.frame.width - 30
        var height = width/3 >= longDescriptionHeight ? width/3 + 70 : longDescriptionHeight + 70
        if let selectedIndexPath = self.selectedIndexPath, selectedIndexPath == indexPath {
            height += 200
//            cell.bottomView.isHidden = false
        }else{
//            cell.bottomView.isHidden = true
        }
        return .init(width: width, height: height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
}


