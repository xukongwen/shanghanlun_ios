
import UIKit

class TextTableViewCell: UITableViewCell {

    override func layoutSubviews() {
        super.layoutSubviews()

        // we should use a custom imageView, but this will do for demonstrational purposes
        imageView?.frame = bounds
        imageView?.contentMode = .scaleAspectFit

        resetSeparators()
    }

    func update(viewData: TextCellViewData) {
        textLabel?.text = viewData.title
        backgroundColor = UIColor.white
        textLabel?.font = UIFont.init(name: "Songti Tc", size: 18)
    }
}

extension TextTableViewCell: Updatable {
    typealias ViewData = TextCellViewData
}
