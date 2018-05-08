//
//  ProfilesViewController.swift
//  ECC
//
//  Created by Nicholas Eby on 3/24/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class ProfilesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    // MARK: - Properties
    var profiles = [Profile]()
    
    @IBOutlet weak var tableView: UITableView!    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initTableView()
        initData()//since data is local file, we can instantiate in viewDidLoad
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    // MARK: - Web Service (Mock)
    func initData()
    {
        if let path = Bundle.main.path(forResource: "profiles", ofType: "json")
        {
            do
            {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let decoder = JSONDecoder()
                let profile = try decoder.decode(Profiles.self, from: data)
                self.profiles = profile.profiles
                
                self.tableView.reloadData()
            }
            catch
            {
                // handle error
            }
        }
    }
    
    
    
    
    // MARK: - TableView
    func initTableView()
    {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell : ProfileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell else { return UITableViewCell() }

        //Image
        cell.profileImageView?.image = UIImage.init(named: profiles[indexPath.row].imageURL!)
        
        //Name
        cell.nameLabel?.text = profiles[indexPath.row].name
        //cell.nameLabel?.textColor = self.navigationController?.navigationBar.barTintColor

        //Twitter (Optional)
        cell.twitterLabel?.text = profiles[indexPath.row].twitter
        
        //Title
        cell.titleLabel?.text = profiles[indexPath.row].title
        
        //Short Description
        cell.descriptionLabel?.text = profiles[indexPath.row].shortDescription
        
        //Favorite App
        cell.favoriteAppLabel?.text = profiles[indexPath.row].favorite
        
        return cell
    }
    
    
    
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "Detail_Segue")
        {
            print("Detail_Segue")
        }
    }

    
    
    // MARK: - Utilites
    
}

