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
    
    @IBOutlet weak var tileCollectionView: NSCollectionView!
   
    var currentTileID = 0;
    
    let tileImages = [0,1,2,3,4,5,6,7,8,9,10,11]
    var trackArray = [480]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapCollectionView()
        configureTileCollectionView()
        
        initTrackArray()
        
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
            return tileImages.count
        }
    }
    

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
       
        if ( collectionView == self.mapCollectionView  ){
        let item = collectionView.makeItem(withIdentifier: "CollectionViewItem", for: indexPath) as! CollectionViewItem
        return item
        }
        else {
            let item = collectionView.makeItem(withIdentifier: "TileCollectionViewItem", for: indexPath) as! TileCollectionViewItem
           item.loadTile(imgUrl: "\(tileImages[indexPath.item])")
            return item
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if collectionView == self.mapCollectionView{
            let index = convertToStringFrom(indexPath: indexPaths)
            let item = collectionView.item(at: index) as! CollectionViewItem
            item.changeImage(imgUrl: "\(currentTileID)")
            
            // track 
            
            trackArray[index] = currentTileID
            
            
        }
        else{
            let index = convertToStringFrom(indexPath: indexPaths)
            currentTileID = index
             print(index)
        }
    }


    
    // Functions
    private func configureMapCollectionView() {
        
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
    private func configureTileCollectionView() {
        
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 32.0, height: 32.0)
        // flowLayout.sectionInset = EdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        mapCollectionView.collectionViewLayout = flowLayout
        
        view.wantsLayer = true
        
        tileCollectionView.layer?.backgroundColor = NSColor.black.cgColor
        tileCollectionView.isSelectable = true
    }
    
    func initTrackArray(){
        var i = 0
        while ( i < 480){
            trackArray.append(0)
            i += 1
        }
    }
    
    
    
    @IBAction func saveBtn(_ sender: Any) {
        let file = "file.txt"
       

        var outputText = ""
        for i in 0..<trackArray.count{
            outputText += "\(trackArray[i]) "
        }
        
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //writing
            do {
                try outputText.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
            
            //reading
            do {
                let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
        }
    }
}

