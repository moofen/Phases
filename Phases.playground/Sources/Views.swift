import Foundation
import UIKit

public class HeaderView: UIView {
    public var prevSubButton: UIButton!
    public var nextSubButton: UIButton!
    public var cycleButton: UIButton!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        let title = UILabel(frame: CGRect(x: 30, y: 20, width: 200, height: 30))
        title.font = .systemFont(ofSize: 30, weight: .medium)
        title.text = "Reddit Phases"
        self.addSubview(title)
        
        let subtitle = UILabel(frame: CGRect(x: 30, y: 45, width: 450, height: 30))
        subtitle.font = .systemFont(ofSize: 15, weight: .light)
        subtitle.text = "Enter your reddit username to visualize your subreddit activity"
        self.addSubview(subtitle)
        
        prevSubButton = createButton(title: "<", frame: CGRect(x: 496, y: 32.5, width: 25, height: 25))
        nextSubButton = createButton(title: ">", frame: CGRect(x: 630, y: 32.5, width: 25, height: 25))
        self.addSubview(prevSubButton)
        self.addSubview(nextSubButton)
        
        cycleButton = createButton(title: "Cycle Colors", frame: CGRect(x: 528, y: 32.5, width: 95, height: 25))
        self.addSubview(cycleButton)
        
        let imageView = UIImageView(frame: CGRect(x: 675, y: 15, width: 60, height: 60))
        imageView.image = UIImage(named: "reddit-logo")
        self.addSubview(imageView)
    }
    
    func createButton(title: String, frame: CGRect) -> UIButton {
        let button = UIButton(frame: frame)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitle(title, for: .normal)
        
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        button.isEnabled = false
        return button
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

public class LoadingView: UIView {
    public var label: UILabel!
    public var indicator: UIActivityIndicatorView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(white: 0.25, alpha: 0.75)
        self.roundCorners(corners: .allCorners, radius: 10)
        
        // create activity indicator
        indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.frame = CGRect(x: 50, y: 10, width: 50, height: 50)
        indicator.hidesWhenStopped = false
        self.addSubview(indicator)
        
        // create progress label
        label = UILabel(frame: CGRect(x: 0, y: 60, width: 150, height: 30))
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Started: 0%"
        self.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

public class AxisLabel: UILabel {
    public enum Axis {
        case x
        case y
    }
    
    public convenience init(_ axis: Axis, _ period: Period? = nil) {
        self.init()
        self.font = .systemFont(ofSize: 13)
        self.textAlignment = .center
        
        switch axis {
        case .x:
            self.frame = CGRect(x: 275, y: 448, width: 200, height: 20)
            if let period = period {
                self.text = "# of \(period)s ago"
            }
        case .y:
            self.frame = CGRect(x: -85, y: 250, width: 200, height: 20)
            self.text = "# of comments"
            self.transform = CGAffineTransform(rotationAngle: (-90 * .pi) / 180)
        }
    }
}

public class LegendCell: UICollectionViewCell {
    // fix reused cell appearance on scroll
    public override func prepareForReuse() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        isSelected = false
    }
}

public class Legend: UICollectionView {
    public init(frame: CGRect, padding: CGFloat) {
        // AlignedCollectionViewFlowLayout for easy alignment of cells
        let flowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        
        // cell spacing
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        
        super.init(frame: frame.insetBy(dx: padding, dy: padding), collectionViewLayout: flowLayout)
        
        self.register(LegendCell.self, forCellWithReuseIdentifier: "Cell")
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
