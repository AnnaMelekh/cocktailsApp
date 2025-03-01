//
//  ViewController.swift
//
//  Created by Anna Melekhina on 28.02.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var tableView = UITableView()
    private lazy var searchBar = UISearchBar()
//    var isSearching = false
    var isEmptyResult: Bool = false
    let emptyResult = [CocktailModel(ingredients: "no results", instructions: "", name: "")]

    var cocktails: [CocktailModel] = []

    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupNavbar()
        setupConstraints()
        
        networkService.delegate = self
        searchBar.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}

private extension MainViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(searchBar)

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search for the cocktail..."
        
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.heightAnchor.constraint(equalToConstant: 90),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
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
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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

            let quote = cocktails[indexPath.row]
            BookmarkManager.shared.saveQuote(quote)

            print("Quote saved:", quote)
        NotificationCenter.default.post(name: NSNotification.Name("QuoteAdded"), object: quote)


            sender.setImage(UIImage(named: "bookmarkFill")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.tintColor = UIColor.systemGray
        
    }
    
    

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cocktails == [] {
               return 1
           } else {
               return cocktails.count
           }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        if cocktails == [] {
            cell.configure(with: emptyResult[indexPath.row])
 
            cell.bookmarkButton.isHidden = true
            } else {
                cell.configure(with: cocktails[indexPath.row])
                cell.bookmarkButton.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)

            }
            
        
        return cell
    }
}

extension MainViewController: NetworkServiceDelegate {
    func didUpdateData(cocktails: [CocktailModel]) {
        DispatchQueue.main.async {
            self.cocktails = cocktails
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: any Error) {
        print(error.localizedDescription)
    }
    
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           guard !searchText.isEmpty else { return }
       }
       
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           guard let nameCocktail = searchBar.text, !nameCocktail.isEmpty else { return }
           
           networkService.performRequest(name: nameCocktail) { [weak self] cocktails in
               DispatchQueue.main.async { [self] in
                   if cocktails.isEmpty {
                              self?.isEmptyResult = true
                       self?.cocktails = []
                          } else {
                              self?.isEmptyResult = false
                              self?.cocktails = cocktails
                          }
                          self?.tableView.reloadData()
               }
           }
           
           searchBar.resignFirstResponder()
       }
       
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searchBar.text = ""
           cocktails.removeAll()
           tableView.reloadData()
           searchBar.resignFirstResponder()
       }
}


#Preview {MainViewController() }
