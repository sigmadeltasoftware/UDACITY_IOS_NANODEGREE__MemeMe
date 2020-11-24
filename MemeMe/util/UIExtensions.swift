//
//  UIExtensions.swift
//  MemeMe
//
//  Created by Bojan Belic on 24/11/2020.
//

import SwiftUI

extension View {
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
// Convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension Binding {
   func onChange(perform action: @escaping (Value, Value) -> Void) -> Self {
      .init(
         get: { self.wrappedValue },
         set: { newValue in
            let oldValue = self.wrappedValue
            DispatchQueue.main.async { action(newValue, oldValue) }
            self.wrappedValue = newValue
         })
   }
}
