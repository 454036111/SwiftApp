//
//  ViewController.swift
//  App
//
//  Created by laijihua on 16/2/23.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import UIKit

// Index
class ViewController: UIViewController {
    @IBOutlet weak var cFlowLayout: BroserCollectFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var loginBtn: UIBarButtonItem!
    var github: Github = Github()
    var models = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        github.user("OHeroJ") { (response) in
            print(response)
        }
//        setup()
    }
    
    @IBAction func loginBtnClick(sender: UIBarButtonItem) {
        if sender.title == "logout" {
            return ()
        } else {
            performSegueWithIdentifier(Segue.Index.LonginSegue.rawValue, sender: nil)
        }
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = Constans.getValue(.AccessToken) {
            loginBtn.title = "logout"
        }else {
            loginBtn.title = "login"
        }
    }
    
    func openURL(url: NSURL) -> Bool{
        if UIApplication.sharedApplication().canOpenURL(url) {
            UIApplication.sharedApplication().openURL(url)
            return true
        }else {
            return false
        }
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        cFlowLayout.itemSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height - 64 - 49)
        cFlowLayout.minimumLineSpacing = 0
        fetchData()
    }
    func fetchData() {
//        NetworkProcess.userRepositories("OHeroJ", success: { [weak self](ret) -> () in
//                if let ret = ret {
//                    self?.models = ret
//                    self?.collectionView.reloadData()
//                }
//            
//            }) { (err) -> () in
//                print(err)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as BroserCollectionViewCell
//        cell.bindModel(models[indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Click \(indexPath)")
       
    }

}




