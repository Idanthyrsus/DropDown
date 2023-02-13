//
//  DropDownView.swift
//  DropDown
//
//  Created by Alexander Korchak on 12.02.2023.
//

import Foundation
import UIKit

protocol DropDownViewDelegate: AnyObject {
    func dropDownPressed(string: String)
}

class DropDownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: DropDownViewDelegate?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 16
        tableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.top.bottom.equalTo(self)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dropDownElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dropDownElements[indexPath.row]
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.dropDownPressed(string: dropDownElements[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
