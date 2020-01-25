
import UIKit

final class DSCharacterGridCollectionViewCell: DSDynamicView, DSCellStyleable {
    
    typealias ViewModelCell = DSCharacterViewModel
    
    let dsLabel = UILabel()
    let dsImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        common()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func common() {
        
        addCellSubViews()
    }
    
    func addCellSubViews() {
        self.addSubview(dsImageView)
        dsImageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        self.addSubview(dsLabel)
        dsLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(self)
        }
    }
    
    func setup(_ vm: ViewModelCell) {
        apply(style: vm.style)
        dsImageView.image = vm.asset.image
        dsImageView.heroID = vm.asset.name
        dsLabel.text = vm.name
    }
}
