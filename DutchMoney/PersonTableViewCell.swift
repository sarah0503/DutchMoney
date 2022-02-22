//
//  PersonTableViewCell.swift
//  DutchMoney
//
//  Created by 윤새라 on 2022/02/23.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet var personMoneyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
