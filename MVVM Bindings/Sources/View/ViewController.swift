//
//  ViewController.swift
//  MVVM Bindings
//
//  Created by Serhii  on 08/01/2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
	
	private let viewModel = UserListViewModel()
	
	// MARK: - Outlets
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.delegate = self
		tableView.dataSource = self
		return tableView
	}()
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		setupHierarchy()
		setupLayout()
		
		viewModel.users.bind { [weak self] _ in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
		
		viewModel.fetchData()
	}
	
	// MARK: - Setup
	
	private func setupHierarchy() {
		view.addSubview(tableView)
	}
	
	private func setupLayout() {
		tableView.snp.makeConstraints { make in
			make.left.top.right.bottom.equalTo(view)
		}
	}
}

extension ViewController: UITableViewDelegate {
	
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = viewModel.users.value?[indexPath.row].name
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.users.value?.count ?? 0
	}
	
}
