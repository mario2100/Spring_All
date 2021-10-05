//
//  ViewController.swift
//  UICollectionViewTestTwo
//
//  Created by vip on 17/1/2.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = MyLayout()
        let collect = UICollectionView(frame: CGRect(x: 0, y: 0, width: 320, height: 400), collectionViewLayout: layout)
        collect.dataSource = self
        collect.delegate = self
        collect.register(NSClassFromString("UICollectionViewCell"), forCellWithReuseIdentifier: "cellid")
        self.view.addSubview(collect)
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 25
        cell.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1)
        return cell
    }
}

