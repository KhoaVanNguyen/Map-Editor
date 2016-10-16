//
//  ViewController.swift
//  LoadCollection
//
//  Created by Khoa on 10/15/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSCollectionViewDataSource , NSCollectionViewDelegate{
    @IBOutlet weak var mapCollectionView: NSCollectionView!
    
    @IBOutlet weak var tileCollectionView: TileCollectionController!
    let names = ["Khoa", "Linh", "Duyen", "Hoa"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        mapCollectionView.delegate = self
        mapCollectionView.dataSource = self
        
        tileCollectionView.delegate = self
        tileCollectionView.dataSource = self
       
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    private func configureCollectionView() {

        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 32.0, height: 32.0)
       // flowLayout.sectionInset = EdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        mapCollectionView.collectionViewLayout = flowLayout
    
        view.wantsLayer = true

        mapCollectionView.layer?.backgroundColor = NSColor.black.cgColor
        mapCollectionView.isSelectable = true
    }

    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        if collectionView == self.mapCollectionView{
            return 1
        }
        else{
            return 1
        }
    }
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mapCollectionView{
            return 480
        }
        else{
            return 4
        }
    }
    

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
       
        if ( collectionView == self.mapCollectionView  ){
        let item = collectionView.makeItem(withIdentifier: "CollectionViewItem", for: indexPath) as! CollectionViewItem
        //item.changeTitle(str: names[indexPath.item])
        return item
        }
        else {
            let item = collectionView.makeItem(withIdentifier: "TileCollectionViewItem", for: indexPath) as! TileCollectionViewItem
            //item.changeTitle(str: names[indexPath.item])
            return item
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if collectionView == self.mapCollectionView{
            print(indexPaths.debugDescription)        }
        else{
            print("HELLO")
        }
        
        
    }


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

