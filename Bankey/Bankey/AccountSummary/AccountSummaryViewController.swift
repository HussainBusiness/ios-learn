//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Hussain Mostafa Al Haddad on 08/10/2022.
//

import Foundation
import UIKit

class AccountSummaryViewController: UIViewController {
    
    // Requset Models
    var profile: Profile?
    var accounts: [Account] = []
    // Header View Model
   // var headerViewModel: AccountSummaryHeaderView.ViewModel(welcomMessage: "Welcome", name: "", date: Date())
    
    // View Models
    var accountCellModels: [AccountSummaryCell.ViewModel] = []
    
    
    // Components
    var tableView = UITableView()
    var headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshControl = UIRefreshControl()
    
    var isLoaded = false

    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
   
}

extension AccountSummaryViewController {
    private func setup() {
        setupNavigationBar()
        setupTableHeaderView()
        setupTableView()
        setupRefreshControl()
        setupSkeletons()
      //  fetchDataAndLoadViews()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)

        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView(){
        
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    func setupRefreshControl(){
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupSkeletons() {
           let row = Account.makeSkeleton()
           accounts = Array(repeating: row, count: 10)
           
           configureTableCells(with: accounts)
       }
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard !accountCellModels.isEmpty else { return UITableViewCell() }
           let account = accountCellModels[indexPath.row]

           if isLoaded {
               let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
               cell.configure(with: account)
               return cell
           }
           
           let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
           return cell
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellModels.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//extension AccountSummaryViewController{
//
//    private func fetchAccounts(){
//        let saving = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "Basic savings", balance: 929132.23)
//        let chequing = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "No-Fee all-In Chequing", balance: 738290.23)
//        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Visa Avion Card", balance: 367000.76)
//        let masterCard = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Student Master Card", balance:  100293.11)
//        let investment1 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tax-Free Saver", balance: 489883.24)
//        let investment2 = AccountSummaryCell.ViewModel(accountType:.Investment, accountName: "Growth Fund", balance: 983100.90)
//
//        accountCellModels.append(saving)
//        accountCellModels.append(chequing)
//        accountCellModels.append(visa)
//        accountCellModels.append(masterCard)
//        accountCellModels.append(investment1)
//        accountCellModels.append(investment2)
//    }
//}




// MARK: - Networking
extension AccountSummaryViewController {
    private func fetchDataAndLoadViews() {
        let group = DispatchGroup()
        
        //Testing - random number selection
        let userId = String(Int.random(in: 1..<4))
        
        group.enter()
        fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
        
              
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
           
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
      
        
        group.notify(queue: .main) {
            self.tableView.refreshControl?.endRefreshing()
            
            guard let profile = self.profile else { return }
            
            self.isLoaded = true
            self.configureTableHeaderView(with: profile) //
            self.configureTableCells(with: self.accounts) //
            self.tableView.reloadData()
        }
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCells(with accounts: [Account]) {
        accountCellModels = accounts.map {
            AccountSummaryCell.ViewModel(accountType: $0.type,
                                         accountName: $0.name,
                                         balance: $0.amount)
        }
    }
}

// MARK: - Actions

extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    @objc func refreshContent() {
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchDataAndLoadViews()
    }
    
    private func reset() {
        profile = nil
        accounts = []
        isLoaded = false
    }
}
