//
//  TileCollectionController.swift
//  LoadCollection
//
//  Created by Khoa on 10/16/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Cocoa

class TileCollectionController: NSCollectionView, NSCollectionViewDelegate, NSCollectionViewDataSource {

    let names = ["Khoa", "Linh","HA","Nam"]


    
    @available(OSX 10.11, *)
    public func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = makeItem(withIdentifier: "TileCollectionViewItem", for: indexPath) as! TileCollectionViewItem
        
        //item.changeLbl(str: names[indexPath.item])
        return item
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }

    
}
