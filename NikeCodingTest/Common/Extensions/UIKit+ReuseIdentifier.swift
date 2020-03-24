//
//  UIKit+ReuseIdentifier.swift
//  MoviesListing
//
//  Created by Umair Ali on 30/04/2019.
//  Copyright © 2019 Umair Ali. All rights reserved.
//

import UIKit

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifying {}

extension UITableView {
    func registerClass<T: UITableViewCell>(cellClass classes: T.Type...) {
        classes.forEach {
            register($0, forCellReuseIdentifier: $0.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        
        return cell
    }
}
