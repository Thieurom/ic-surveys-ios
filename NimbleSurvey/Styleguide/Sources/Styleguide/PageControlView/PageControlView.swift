//
//  SwiftUIView.swift
//  Styleguide
//
//  Created by Doan Thieu on 17/11/2022.
//

import SwiftUI

public struct PageControlView: UIViewRepresentable {

    public final class Coordinator: NSObject {

        let pageControl: PageControlView

        init(_ pageControl: PageControlView) {
            self.pageControl = pageControl
        }

        @objc func didChangeValue(_ sender: UIPageControl) {
            pageControl.currentPage = sender.currentPage
        }
    }

    @Binding public var currentPage: Int
    public let numberOfPages: Int

    public init(numberOfPages: Int, currentPage: Binding<Int>? = nil) {
        self.numberOfPages = numberOfPages
        self._currentPage = currentPage ?? .constant(0)
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    public func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()

        pageControl.backgroundStyle = .minimal
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
        pageControl.addTarget(
            context.coordinator,
            action: #selector(Coordinator.didChangeValue(_:)),
            for: .valueChanged
        )

        return pageControl
    }

    public func updateUIView(_ pageControl: UIPageControl, context: Context) {
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
    }
}

#if DEBUG
struct PageControlView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            PageControlView(numberOfPages: 10)
        }
    }
}
#endif
