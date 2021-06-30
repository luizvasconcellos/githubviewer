//
//  ViewController.swift
//  githubviewer
//
//  Created by Luiz Vasconcellos on 25/06/21.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    
    private let networking = Networking()
    private var repositoryList: [Repository] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "GitHub Viewer"
    }
    
    @IBAction func searchUser(_ sender: Any) {
        
        guard let username = searchField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        if username == "" {
            showAlert(title: "Fill the ", message: "Please fill the username field to perform the search.", completion: nil)
            return
        }
        
        networking.getUserRepo(userName: username) { (result) in
            
            switch result {
            case  .success(let repo):
                self.repositoryList = repo
                self.performSegue(withIdentifier: "ShowRepoSegue", sender: nil)
            case .failure(.notFound):
                self.showAlert(title: "Sorry...", message: "Sorry we can't find this user. Please try again later", completion: nil)
                return
            case .failure(.requestError):
                self.showAlert(title: "Houston we have a problem!", message: "We had a problem to perform with your search 😥. Please try again later", completion: nil)
                return
            }
        }
    }
    
    func showAlert(title:String, message:String, completion: (() -> Void)?) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowRepoSegue" {
            if let repoListTVC = segue.destination as? RepoListTableViewController {
                repoListTVC.repoList = self.repositoryList
            }
        }
    }
    
}

