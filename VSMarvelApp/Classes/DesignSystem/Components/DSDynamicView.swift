
import UIKit

let kTiltAnimationVelocityListenerIdentifier = "kTiltAnimationVelocityListenerIdentifier"

open class DSDynamicView: UIView {
    open var tapAnimation = true

    open var tiltAnimation = false {
        didSet {
            if tiltAnimation {
                yaal.center.velocity.changes.addListenerWith(identifier: kTiltAnimationVelocityListenerIdentifier) { [weak self] _, v in
                    self?.velocityUpdated(v)
                }
            } else {
                yaal.center.velocity.changes.removeListenerWith(identifier: kTiltAnimationVelocityListenerIdentifier)
                yaal.rotationX.animateTo(0, stiffness: 150, damping: 7)
                yaal.rotationY.animateTo(0, stiffness: 150, damping: 7)
            }
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        layer.yaal.perspective.setTo(-1 / 500)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.yaal.perspective.setTo(-1 / 500)
    }

    func velocityUpdated(_ velocity: CGPoint) {
        let maxRotate = CGFloat.pi / 6
        let rotateX = -(velocity.y / 3000).clamp(-maxRotate, maxRotate)
        let rotateY = (velocity.x / 3000).clamp(-maxRotate, maxRotate)
        yaal.rotationX.animateTo(rotateX, stiffness: 400, damping: 20)
        yaal.rotationY.animateTo(rotateY, stiffness: 400, damping: 20)
    }

    func touchAnim(touches: Set<UITouch>) {
        if let touch = touches.first, tapAnimation {
            var loc = touch.location(in: self)
            loc = CGPoint(x: loc.x.clamp(0, bounds.width), y: loc.y.clamp(0, bounds.height))
            loc = loc - bounds.center
            let rotation = CGPoint(x: -loc.y / bounds.height, y: loc.x / bounds.width)
            if #available(iOS 9.0, *) {
                let force = touch.maximumPossibleForce == 0 ? 1 : touch.force
                let rotation = rotation * (0.21 + force * 0.04)
                yaal.scale.animateTo(0.95 - force * 0.01)
                yaal.rotationX.animateTo(rotation.x)
                yaal.rotationY.animateTo(rotation.y)
            } else {
                let rotation = rotation * 0.25
                yaal.scale.animateTo(0.94)
                yaal.rotationX.animateTo(rotation.x)
                yaal.rotationY.animateTo(rotation.y)
            }
        }
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchAnim(touches: touches)
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        touchAnim(touches: touches)
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if tapAnimation {
            yaal.scale.animateTo(1.0, stiffness: 150, damping: 7)
            yaal.rotationX.animateTo(0, stiffness: 150, damping: 7)
            yaal.rotationY.animateTo(0, stiffness: 150, damping: 7)
        }
    }

    override open func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        super.touchesCancelled(touches!, with: event)
        if tapAnimation {
            yaal.scale.animateTo(1.0, stiffness: 150, damping: 7)
            yaal.rotationX.animateTo(0, stiffness: 150, damping: 7)
            yaal.rotationY.animateTo(0, stiffness: 150, damping: 7)
        }
    }
}

extension CGFloat {
    func clamp(_ a: CGFloat, _ b: CGFloat) -> CGFloat {
        self < a ? a : (self > b ? b : self)
    }
}

func * (left: CGFloat, right: CGPoint) -> CGPoint {
    right * left
}

extension CGPoint {
    func translate(_ dx: CGFloat, dy: CGFloat) -> CGPoint {
        CGPoint(x: x + dx, y: y + dy)
    }

    func transform(_ t: CGAffineTransform) -> CGPoint {
        applying(t)
    }

    func distance(_ b: CGPoint) -> CGFloat {
        sqrt(pow(x - b.x, 2) + pow(y - b.y, 2))
    }
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += (left: inout CGPoint, right: CGPoint) {
    left.x += right.x
    left.y += right.y
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func / (left: CGPoint, right: CGFloat) -> CGPoint {
    CGPoint(x: left.x / right, y: left.y / right)
}

func * (left: CGPoint, right: CGFloat) -> CGPoint {
    CGPoint(x: left.x * right, y: left.y * right)
}

func * (left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x * right.x, y: left.y * right.y)
}

prefix func - (point: CGPoint) -> CGPoint {
    CGPoint.zero - point
}

func / (left: CGSize, right: CGFloat) -> CGSize {
    CGSize(width: left.width / right, height: left.height / right)
}

func - (left: CGPoint, right: CGSize) -> CGPoint {
    CGPoint(x: left.x - right.width, y: left.y - right.height)
}

prefix func - (inset: UIEdgeInsets) -> UIEdgeInsets {
    UIEdgeInsets(top: -inset.top, left: -inset.left, bottom: -inset.bottom, right: -inset.right)
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }

    var bounds: CGRect {
        CGRect(origin: .zero, size: size)
    }

    init(center: CGPoint, size: CGSize) {
        self.init(origin: center - size / 2, size: size)
    }
}

func delay(_ delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main
        .asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure
        )
}

extension String {
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        // swiftformat:disable:next redundantSelf
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)

        return boundingBox.width
    }
}
