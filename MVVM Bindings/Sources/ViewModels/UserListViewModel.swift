//
//  UserListViewModel.swift
//  MVVM Bindings
//
//  Created by Serhii  on 08/01/2023.
//

import Foundation

struct UserListViewModel {
	var users: Observabe<[UserTableViewCellViewModel]> = Observabe([])
	
	func fetchData() {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
		
		let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
			guard let data = data else { return }
			do {
				let userModels = try JSONDecoder().decode([User].self, from: data)
				
				self.users.value = userModels.compactMap({
					UserTableViewCellViewModel(name: $0.name )
				})
			}
			catch {
				
			}
		}
		task.resume()
	}
}
