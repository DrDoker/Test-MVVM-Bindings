//
//  Observabe.swift
//  MVVM Bindings
//
//  Created by Serhii  on 08/01/2023.
//

import Foundation

class Observabe<T> {
	var value: T? {
		didSet {
			listeners.forEach {
				$0(value)
			}
		}
	}
	private var listeners: [(T?) -> ()] = []
	
	init(_ value: T?) {
		self.value = value
	}
	
	func bind(_ listener: @escaping (T?) -> Void) {
		listener(value )
		self.listeners.append(listener)
	}
}
