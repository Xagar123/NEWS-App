//
//  ViewController.swift
//  News app
//
//  Created by Admin on 17/01/23.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    var viewModel = NewsListViewModel()
    
    private lazy var headerView: HeaderView = {
       let view = HeaderView(fontSize: 32)
        return view
    }()

    private lazy var tableView: UITableView = {
       let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tableFooterView = UIView()
        view.register(NewsTableViewCell.self, forCellReuseIdentifier: viewModel.reuseID)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchNews()
    }

    func setupView() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        setupConstraints()
    }

    func setupConstraints() {
        //header
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        //tableView
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchNews() {
        viewModel.getNews {_ in
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseID, for: indexPath) as? NewsTableViewCell
        
        let news = viewModel.newsVM[indexPath.row]
        cell?.newsVM = news
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.newsVM[indexPath.row]
        
        guard let url = URL(string: news.url) else {
            return
        }
        
        let config = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        safariViewController.modalPresentationStyle = .fullScreen
        present(safariViewController, animated: true)
    }
    
    
}
