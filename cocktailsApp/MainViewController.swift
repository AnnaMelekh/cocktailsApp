//
//  ViewController.swift
//
//  Created by Anna Melekhina on 28.02.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    var quotes: [CocktailModel] = []

    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupNavbar()
        setupConstraints()
        networkService.delegate = self
        networkService.performRequest(name: "margarita")
        
        
    }
    
    
}

private extension MainViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupNavbar() {
        let imageView = UIImageView(image: UIImage(named: "titleImg"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 400, height: 140)
        navigationItem.titleView = imageView
        
       
    }
    
    @objc func bookmarkTapped(_ sender: UIButton) {
        var superview = sender.superview
            while let view = superview, !(view is Cell) {
                superview = view.superview
            }

            guard let cell = superview as? Cell,
                  let indexPath = tableView.indexPath(for: cell) else {
                return
            }

            let quote = quotes[indexPath.row]
            BookmarkManager.shared.saveQuote(quote)

            print("Quote saved:", quote)
        NotificationCenter.default.post(name: NSNotification.Name("QuoteAdded"), object: quote)


            sender.setImage(UIImage(named: "bookmarkFill")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.tintColor = UIColor.systemGray
        
    }
    
    @objc func refreshTapped(_ sender: UIButton) {
        networkService.performRequest()
        
        var superview = sender.superview
            while let view = superview, !(view is Cell) {
                superview = view.superview
            }

            guard let cell = superview as? Cell,
                  let indexPath = tableView.indexPath(for: cell) else {
                return
            }
        cell.bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
        
    }
    

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.configure(with: quotes[indexPath.row])
        
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)
        
        return cell
    }
}

extension MainViewController: NetworkServiceDelegate {
    func didUpdateData(quotes: [CocktailModel]) {
        DispatchQueue.main.async {
            self.quotes = quotes
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: any Error) {
        print(error.localizedDescription)
    }
    
    
}




//#Preview {MainViewController() }
