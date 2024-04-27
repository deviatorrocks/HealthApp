//
//  ImageListViewController.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import UIKit

class ImageListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.5, bottom: 0.0, right: 0.0)
    var viewModel: ImageListViewModel!
    // Your existing properties and outlets...
    let imageLoader = ImageLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        
        viewModel = ImageListViewModel(imageService: ImageService())
        viewModel.fetchImageKeys { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching image keys: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension ImageListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // In this function is the code you must implement to your code project if you want to change size of Collection view
        let width  = (view.frame.width-20)/3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageKeys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        cell.configureUI(
            imageLoader: imageLoader,
            imageKey: viewModel.fetchImageKey(index: indexPath.row),
            url: viewModel.formImageUrl(index: indexPath.row) as String)
        print("Index in table view count: \(indexPath.row)")
        return cell
    }
}

extension ImageListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let imageURL = viewModel.formImageUrl(index: indexPath.row)
            let imageKey = viewModel.fetchImageKey(index: indexPath.row)
            
            // Check if the image is already cached
            if ImageCache.shared.image(for: imageKey) != nil {
                // Image is already cached, no need to prefetch
                continue
            }
            
            imageLoader.loadImage(imageKey: imageKey, from: URL(string: imageURL as String)!) { image in
                DispatchQueue.main.async {
                    // Reload the corresponding cell to display the image
                    if let cell = collectionView.cellForItem(at: indexPath) as? ImageCell {
                        cell.imageView.image = image
                    }
                }
            }
        }
    }
}
