//
//  CustomDataSource.swift
//  GenericDataSource
//
//  Created by Mohamed Korany Ali on 12/30/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import UIKit

// MARK: - CustomDataSource
//
class CustomDataSource<CELL: UITableViewCell,T>: NSObject, UITableViewDataSource {
  
  // MARK: - Properties
  //
  
  /// List of presentable items
  ///
  private var items : [T]!
  
  /// Sections that should be in table view
  ///
  private var sections: [Section] = []
  
  /// Cell configuration that take list of items and complete with cell itself and item in cell
  ///
  var configureCell : ((CELL, T) -> ())?
  
  
  /// Cell configuration that should be called when data comes from API the assign data to data source
  ///
  func configureCell(list: [T], completion: @escaping (CELL, T) -> ()) {
    self.items = list
    self.configureCell = completion
    
    // to create secions array from data
    reloadSections()
  }
  
  
  // MARK: - TableView dataSource configuration
  func numberOfSections(in tableView: UITableView) -> Int {
     sections.count
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     sections[section].rows.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     let row = sections[indexPath.section].rows[indexPath.row]
    
     guard let cell = tableView.dequeueReusableCell(withIdentifier: row.identefire, for: indexPath) as? CELL else { fatalError("Can't dequeue cell") }
     
     let item = self.items[indexPath.row]
     self.configureCell?(cell, item)
     return cell
   }
   
  /// Returns item of tableview list with index path
  ///
   func item(at indexPath: IndexPath) -> T {
     return items[indexPath.row]
   }
  
}

// MARK: - Handlers
//
private extension CustomDataSource {
  
  /// When data is ready, we call that to creat array of sections from this data
  ///
  func reloadSections() {
    let sections: [Section] = {
      let count = items.count
      let row = Row(identefire: "\(CELL.self)")
      let rows = Array(repeating: row, count: count)
      let homeSection = Section(rows: rows)
      
      return [homeSection]
    }()
    
    self.sections = sections
  }
}


// MARK: - Inner structs
//
private extension CustomDataSource {
  
  /// For tableView sction
  struct Section {
    let rows: [Row]
  }
  
  /// For each section has rows
  struct Row {
    let identefire: String
  }
}
