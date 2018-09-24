//
//  ListViewController.swift
//  todo-list-firebase
//
//  Created by Eldar Goloviznin on 21/09/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class ListViewController: UICollectionViewController {
    
    fileprivate let reuseIdentifier = "Cell"
    
    fileprivate let interitemSpacing: CGFloat = 8.0
    
    fileprivate var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let insets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
        self.collectionView.contentInset = insets
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        let task = tasks[indexPath.row]
        
        let titleLabel = cell.viewWithTag(1) as! UILabel
        titleLabel.text = task.title
        
        return cell
    }

}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = collectionView.contentInset
        let width = (self.collectionView.bounds.width - insets.left - insets.right - interitemSpacing) / 2.0
        let height: CGFloat = 120
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interitemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interitemSpacing
    }
    
}
