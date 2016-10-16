//
//  CollectionViewItem.swift
//  LoadCollection
//
//  Created by Khoa on 10/15/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Cocoa

class CollectionViewItem: NSCollectionViewItem {

    @IBOutlet weak var mapImage: NSImageView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
    }
    
    func changeImage(imgUrl : String ){
        mapImage.image = NSImage(named: imgUrl)
    }
    


}
