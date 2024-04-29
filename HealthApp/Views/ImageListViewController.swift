//
//  ImageListViewController.swift
//  HealthApp
//
//  Created by Mandar Kadam on 26/04/24.
//

import UIKit

final class ImageListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.5, bottom: 0.0, right: 0.0)
    var viewModel: ImageListViewModel!
    let imageLoader = ImageLoader()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        fetchData()
    }
    
    func fetchData() {
        viewModel = ImageListViewModel(imageService: ImageService())
        viewModel.fetchImageKeys { [weak self] error in
            guard let self = self else { return }
            if let _ = error {
                AlertView.showAlert(
                    title: "Network issue",
                    message: "Please try again",
                    viewController: self)
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}

extension ImageListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = ((view.frame.width) - Constants.offset) / Constants.itemsPerRow
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageKeys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        if collectionView.isDragging == false, collectionView.isDecelerating == false {
            cell.configureUI(
                imageLoader: imageLoader,
                imageKey: viewModel.fetchImageKey(index: indexPath.row),
                url: viewModel.formImageUrl(index: indexPath.row) as String)
        } else {
            cell.configurePlaceholderImage()
        }
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadImages()
        }
    }
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImages()
    }
    
    func loadImages() {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in visibleIndexPaths {
            guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCell else { continue }
            cell.configureUI(
                imageLoader: imageLoader,
                imageKey: viewModel.fetchImageKey(index: indexPath.row),
                url: viewModel.formImageUrl(index: indexPath.row) as String)
        }
    }
}
