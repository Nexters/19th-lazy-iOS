//
//  MainViewController+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/20.
//

import UIKit

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        59
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeHabitTableViewCell.identifier, for: indexPath) as? HomeHabitTableViewCell else { return UITableViewCell() }
        cell.checkButtonDelegate = self
        
        if indexPath.row == 1 {
            cell.changeInActive()
        }

        return cell
    }
}

// MARK: - DrawerViewDelegate

extension MainViewController: DrawerViewDelegate {
    func presentAddHabitView() {
        let addHabitViewController = AddHabitViewController()

        self.present(addHabitViewController, animated: true, completion: nil)
    }
}

// MARK: - HabitCheckButtonDelegate

extension MainViewController: HabitCheckButtonDelegate {
    func didTapHabitCheckButton(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
}
