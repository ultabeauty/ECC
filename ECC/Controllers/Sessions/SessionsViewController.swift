//
//  SessionsViewController.swift
//  ECC
//
//  Created by Nicholas Eby on 3/24/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit

class SessionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    // MARK: - Properties
    var sessions = [Session]()

    // MARK: - Outlets
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
                
                tableView.reloadData()
            }
            catch
            {
                // handle error
                print("error!")
            }
        }
    }
    
    
    
    
    // MARK: - TableView
    func initTableView()
    {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
    
    /*
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "May 22, 2018"
    }*/
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell : SessionCell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as? SessionCell else { return UITableViewCell() }
        
        //Image
        cell.sessionImageView?.image = UIImage.init(named: sessions[indexPath.row].imageURL!)

        //Title
        cell.titleLabel?.text = sessions[indexPath.row].title
        //cell.titleLabel?.textColor = self.navigationController?.navigationBar.barTintColor
        
        //Badge
        cell.badge?.badgeType = sessions[indexPath.row].category
        
        //Date
        cell.dateLabel?.text = sessions[indexPath.row].dateToDisplayString()
        
        //Short Description
        cell.descriptionLabel?.text = sessions[indexPath.row].shortDescription
        
        //Authors
        cell.authorLabel?.text = sessions[indexPath.row].authorsToDisplayString()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
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
                if let cell = sender as? SessionCell
                {
                    if let indexPath = tableView.indexPath(for: cell)
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


    
    // MARK: - Utilites

}
