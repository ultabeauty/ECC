//
//  SessionViewController.swift
//  ECC
//
//  Created by Eby, Nicholas on 5/1/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class SessionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    // MARK: - Properties
    var sessions = [Session]()
    
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        self.navigationItem.rightBarButtonItem = nil
        
        initCollectioView()
        initData()//since data is local file, we can instantiate in viewDidLoad
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        initOnboarding()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    // MARK: - Web Service (Mock)
    func initData()
    {
        if let path = Bundle.main.path(forResource:"sessions", ofType: "json")
        {
            do
            {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    
                let decoder = JSONDecoder()
                let session = try decoder.decode(Sessions.self, from: data)
                sessions = session.sessions
    
                collectionView?.reloadData()
            }
            catch
            {
                // handle error
                print("error!")
            }
        }
    }
    
    
    
    
    // MARK: UICollectionViewDataSource
    func initCollectioView()
    {
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"SessionCollectionCell")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return sessions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let session = sessions[indexPath.row]

        if session.category == 9
        {
            guard let cell : SessionCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreakCollectionCell", for: indexPath) as? SessionCollectionCell else { return UICollectionViewCell() }
            
            //Category
            cell.categoryLabel?.text = session.categoryToDisplayString()
            
            //Title
            cell.titleLabel?.text = session.title
            
            //Date
            cell.dateLabel?.text = session.dateToDisplayString()
            
            return cell
        }
        else
        {
            guard let cell : SessionCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SessionCollectionCell", for: indexPath) as? SessionCollectionCell else { return UICollectionViewCell() }
            
            //Image
            cell.sessionImageView?.image = UIImage.init(named: sessions[indexPath.row].imageURL!)
            
            //Category
            cell.categoryLabel?.text = session.categoryToDisplayString()
            
            //Title
            cell.titleLabel?.text = session.title
            
            //Badge
            cell.badge?.badgeType = session.category
            
            //Date
            cell.dateLabel?.text = session.dateToDisplayString()
            
            //Short Description
            cell.descriptionLabel?.text = session.shortDescription
            
            //Session #
            cell.sessionViewLabel?.text = String(format: "%.2d", indexPath.row)
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let session = sessions[indexPath.row]
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        if session.category == 9
        {
            return CGSize.init(width: collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, height: 102)
        }
        else
        {
            return CGSize.init(width: collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, height: 230)
        }
    }

    
    // MARK: - Navigation
    @IBAction func unwindSegue(segue:UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "DetailSegue")
        {
            print("DetailSegue")
            
            if let vc = segue.destination as? SessionDetailViewController
            {
                if let cell = sender as? SessionCollectionCell
                {
                    if let indexPath = collectionView?.indexPath(for: cell)
                    {
                        //vc.transitioningDelegate = self
                        vc.session = sessions[indexPath.row]
                    }
                }
            }
        }
    }
    
    
    
    
    func initOnboarding()
{
    if(UserDefaults.standard.string(forKey: "kSchoolSelection") == nil)
    {
        self.performSegue(withIdentifier: "OnboardSegue", sender: self)
    }
    }
    
    @IBAction func openOnboarding(_ sender: Any)
    {
    self.performSegue(withIdentifier: "OnboardSegue", sender: self)
    }
    


}
