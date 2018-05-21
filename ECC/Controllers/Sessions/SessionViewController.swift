//
//  SessionViewController.swift
//  ECC
//
//  Created by NEBY on 5/1/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit
import AVKit

class SessionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    // MARK: - Properties
    var sessions = [Session]()
    
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initCollectioView()
        initData()//since data is local file, we can init in viewDidLoad
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

        if(session.type == 0) //video card
        {
            guard let cell : SessionCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionCell", for: indexPath) as? SessionCollectionCell else { return UICollectionViewCell() }
            
            cell.session = session
            
            return cell
        }
        else //session card
        {
            guard let cell : SessionCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SessionCollectionCell", for: indexPath) as? SessionCollectionCell else { return UICollectionViewCell() }
            
            cell.session = session
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let session = sessions[indexPath.row]
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        let max_width = collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right
        
        if(session.type == 0)
        {
            return CGSize.init(width: max_width, height: 210)
        }
        else
        {            
            return CGSize.init(width: max_width, height: 132)
        }
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let session = sessions[indexPath.row]
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        if(session.type == 0)
        {
            playVideo(filename: session.videoURL!)
        }
        else
        {
            if(session.survey != nil)
            {
                self.performSegue(withIdentifier: "SurveySegue", sender: cell)
            }
            else
            {
                self.performSegue(withIdentifier: "DetailSegue", sender: cell)
            }
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
    
    
    
    // MARK: - AVKit
    func playVideo(filename:String)
    {
        let filename_components = filename.components(separatedBy: ".")
        let name = filename_components.first
        let file_extension = filename_components.last
        
        let path = Bundle.main.path(forResource: name, ofType: file_extension)
        let url = NSURL.fileURL(withPath: path!)
        
        let player = AVPlayer.init(url: url)
        let playerController = AVPlayerViewController.init()
        playerController.player = player
        
        present(playerController, animated: true)
        {
            player.play()
        }
    }
    
    
    // MARK: - Onboarding
    func initOnboarding()
    {
        if(UserDefaults.standard.string(forKey: "kSchoolSelection") == nil)
        {
            self.performSegue(withIdentifier: "OnboardSegue", sender: self)
        }
    }
    



}
