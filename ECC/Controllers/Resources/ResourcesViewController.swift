//
//  ResourcesViewController.swift
//  ECC
//
//  Created by Nicholas Eby on 3/24/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit
import SafariServices

class ResourcesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate, UIDocumentInteractionControllerDelegate
{
    // MARK: - Properties
    var resources = [Resource]()
    var documentInteractionController: UIDocumentInteractionController = UIDocumentInteractionController()
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!


    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        documentInteractionController = UIDocumentInteractionController.init()
        documentInteractionController.delegate = self

        initTableView()
        initData()//since data is local file, we can instantiate in viewDidLoad

    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Web Service (Mock)
    func initData()
    {
        if let path = Bundle.main.path(forResource: "resources", ofType: "json")
        {
            do
            {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let decoder = JSONDecoder()
                let resource = try decoder.decode(Resources.self, from: data)
                resources = resource.resources
                
                tableView.reloadData()
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
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return resources.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResourceCell.self)) as! ResourceCell

        let resource = resources[indexPath.row]
        
        cell.resource = resource
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if(resources[indexPath.row].type == 0)
        {
            if let url = URL(string: resources[indexPath.row].link)
            {
                let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                present(activityViewController, animated: true, completion: {})
            }
        }
        else if(resources[indexPath.row].type == 2)
        {
            if let url = URL(string: resources[indexPath.row].link)
            {
                let vc = SFSafariViewController.init(url: url)
                vc.delegate = self
                vc.preferredBarTintColor = self.navigationController?.navigationBar.barTintColor
                vc.preferredControlTintColor = self.navigationController?.navigationBar.tintColor
                
                //vc.delegate = self
                
                present(vc, animated: true)
            }
        }
        else
        {
            previewURL(resource: resources[indexPath.row])
        }
    }
    
    
    
    
    // MARK: - SFSafariViewControllerDelegate

    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL)
    {
        print("svc did redirect %@", URL)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        print("svc did finish")

    }
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool)
    {
        print("svc did complete IL")
    }
    
    
    
    
    // MARK: - UIDocumentInteractionController
    func previewURL(resource:Resource)
    {
        let resource_url = Bundle.main.url(forResource: resource.link, withExtension: "pdf")
        
        documentInteractionController.url = resource_url
        documentInteractionController.name = resource.title
        documentInteractionController.presentPreview(animated: true)
    }
    
    
    // MARK: - UIDocumentInteractionControllerDelegate
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self.navigationController!
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

