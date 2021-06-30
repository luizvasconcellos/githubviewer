//
//  RepoListTableViewController.swift
//  githubviewer
//
//  Created by Luiz Vasconcellos on 25/06/21.
//

import UIKit
import Kingfisher

class RepoListTableViewController: UITableViewController {

    var repoList: [Repository]? {
    didSet {
            configureView()
        }
    }
    
    func configureView() {
        guard let _ = repoList else { return }
        setupNavigationBar()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupNavigationBar() {
        guard let imageUrl = self.repoList?.first?.owner.avatarURL else {return}
        guard let login = self.repoList?.first?.owner.login else { return }
        
        let imageView = UIImageView()
        
        KF.url(URL(string: imageUrl))
            .cacheOriginalImage(true)
            .waitForCache(true)
            .onFailureImage(UIImage(named: "user"))
            .set(to: imageView)
        
        imageView.layer.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.frame.height/2
        
        let leftBtn = UIBarButtonItem()
        leftBtn.title = login
        navigationItem.rightBarButtonItem = leftBtn
        navigationItem.titleView = imageView
        navigationItem.title = login
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let repoList = repoList else { return UITableViewCell() }
        let repo = repoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoIdentifier", for: indexPath)
        
        cell.textLabel?.text = repo.name
        cell.detailTextLabel?.text = repo.language
        
        return cell
    }
}
