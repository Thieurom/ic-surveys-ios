//
//  HomePlaceholderView.swift
//  Home
//
//  Created by Doan Thieu on 18/11/2022.
//

import ShimmerView
import SwiftUI

struct HomePlaceholderView: View {

    private static let style = ShimmerViewStyle(
        baseColor: .white.withAlphaComponent(0.12),
        highlightColor: .white.withAlphaComponent(0.3),
        duration: 1.2,
        interval: 0.4,
        effectSpan: .points(120.0),
        effectAngle: 0.0 * CGFloat.pi
    )

    var body: some View {
        GeometryReader { reader in
            ShimmerScope(style: Self.style, isAnimating: .constant(true)) {
                VStack(alignment: .leading, spacing: 4.0) {
                    // header
                    ShimmerElement(width: reader.size.width / 3, height: 20.0)
                        .cornerRadius(.infinity)

                    HStack {
                        ShimmerElement(width: reader.size.width / 4, height: 20.0)
                            .cornerRadius(.infinity)

                        Spacer()

                        ShimmerElement(width: 36.0, height: 36.0)
                            .cornerRadius(.infinity)
                    }

                    Spacer()

                    // footer
                    ShimmerElement(width: 50, height: 20.0)
                        .cornerRadius(.infinity)
                        .padding(.bottom, 10.0)
                    ShimmerElement(width: reader.size.width - 100, height: 20.0)
                        .cornerRadius(.infinity)
                    ShimmerElement(width: reader.size.width / 3, height: 20.0)
                        .cornerRadius(.infinity)
                        .padding(.bottom, 10.0)
                    ShimmerElement(width: reader.size.width - 50, height: 20.0)
                        .cornerRadius(.infinity)
                    ShimmerElement(width: reader.size.width / 2, height: 20.0)
                        .cornerRadius(.infinity)
                }
            }
        }
    }
}

#if DEBUG
struct HomePlaceholderView_Previews: PreviewProvider {

    static var previews: some View {
        HomePlaceholderView()
            .padding(.horizontal, 20.0)
            .padding(.bottom, 20.0)
            .background(Color.black)
    }
}
#endif
