//
//  ViewController.swift
//  GenericDataSource
//
//  Created by Mohamed Korany Ali on 12/30/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Properties
  var list: [User] = [User(name: "ahmed", job: "software engineer"),
                      User(name: "mohamed", job:"database admin" ),]
  
  lazy var dataSource: CustomDataSource<DemoCell, User> = {
    return CustomDataSource()
  }()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    registerViews()
    configureTableViewCell()
    
  }
}

// MARK: - TableViewDelegates
extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     print(dataSource.item(at: indexPath).name)
   }
}

// MARK: - View Configuration
//
private extension ViewController {
  
  func registerViews() {
    tableView.register(UINib(nibName: "\(DemoCell.self)", bundle: nil), forCellReuseIdentifier: "\(DemoCell.self)")
    configureTableView()
  }
  
  func configureTableViewCell() {
    dataSource.configureCell(list: list) { cell, item in
      
      cell.nameLabel.text = item.name
      cell.jobLabel.text = item.job
      cell.userImageView.image = .checkmark
      
    }
  }
  
  func configureTableView() {
    tableView.dataSource = dataSource
    tableView.delegate = self
    tableView.tableFooterView = UIView()
    
  }
}
