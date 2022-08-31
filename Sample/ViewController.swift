//
//  ViewController.swift
//  Sample
//
//  Created by Nitin Bhatia on 04/08/22.
//

import UIKit
import WebKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,webCell {

  
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var webview: WKWebView!
    
    var heights : [Int:CGFloat] = [Int:CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EECollectionViewCell
        
        
        
        if let heights = heights[indexPath.row] {
            cell.height.constant = heights
            cell.btnClick.setTitle("Hide", for: .normal)
        } else {
            cell.setupLabel()
            cell.height.constant = 0
            cell.btnClick.setTitle("Show", for: .normal)
        }
        cell.backgroundColor = .red
        cell.delegate = self
        
        print(indexPath.row, cell.height.constant, cell.didButtonPressed)
        return cell
    }
//    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.view.frame.width, height: self.view.frame.height)

    }
    
    @objc func updateCellHeight(_ sender: UIButton) {
        let cell = collView.cellForItem(at: IndexPath(item: sender.tag, section: 0)) as! EECollectionViewCell
        cell.height.constant = cell.heightNew
    }

    func didButtonPressed() {
        let currentIndex = collView.indexPathsForVisibleItems.first?.row
        let cell = collView.cellForItem(at: collView.indexPathsForVisibleItems.first ?? IndexPath(item: 0, section: 0)) as! EECollectionViewCell
        heights[currentIndex ?? 0] = cell.height.constant
    }
}

