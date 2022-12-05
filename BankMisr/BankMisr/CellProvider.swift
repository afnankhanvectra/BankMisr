//
//  Protocol.swift
//  BankMisr
//
//  Created by Afnan Khan on 05/12/2022.
//

import UIKit

protocol CellProvider { }

extension CellProvider where Self: UITableViewCell {
    static func dequeue(_ tableView: UITableView, indexPath: IndexPath) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: self), for: indexPath) as! Self
        return cell
    }
}
