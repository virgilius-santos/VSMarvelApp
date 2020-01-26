
import UIKit
import Hero

protocol CharacterViewProtocol {
    func setup(_ vm: CharacterViewModel)
}

extension CharacterViewProtocol where Self: DSCellStyleable {
    
    func setup(_ vm: CharacterViewModel) {
        apply(style: vm.style)
        dsImageView.image = vm.asset.image
        dsImageView.cancelRequest()
        dsImageView.setImage(with: vm.path,
                             placeholder: vm.asset.image)
        dsImageView.heroID = vm.asset.name
        dsLabel.text = vm.name
    }
}
