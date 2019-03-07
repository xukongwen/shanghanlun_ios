

import UIKit

extension UITableViewCell {

    func resetSeparators() {
        separatorInset = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        layoutMargins = UIEdgeInsets.zero
    }
}
