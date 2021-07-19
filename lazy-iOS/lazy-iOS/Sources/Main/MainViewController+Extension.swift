//
//  MainViewController+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/20.
//

import UIKit

extension MainViewController: UITableViewDelegate {
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeHabitTableViewCell.identifier, for: indexPath) as? HomeHabitTableViewCell else { return UITableViewCell() }

        return cell
    }
}
