// swiftlint:disable force_unwrapping
//
//  NPSView.swift
//  Survey
//
//  Created by Doan Thieu on 29/11/2022.
//

import Styleguide
import SwiftUI

struct NPSView: View {
    
    private let points = 1...10
    
    @Binding  var selectedPoint: Int
    
    var body: some View {
        VStack(spacing: 16.0) {
            HStack(alignment: .center, spacing: 0) {
                ForEach(points, id: \.self) { point in
                    Text("\(point)")
                        .adaptiveFont(point <= selectedPoint ? .neuzeitHeavy : .neuzeitBook, size: 20.0)
                        .foregroundColor(.white)
                        .opacity(point <= selectedPoint ? 1.0 : 0.5)
                        .frame(height: 56.0)
                        .frame(maxWidth: .infinity)
                        .overlay(Rectangle().stroke(.white, lineWidth: 0.5))
                        .onTapGesture {
                            selectedPoint = point
                        }
                }
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 10.0)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(.white, lineWidth: 0.5)
            )
            
            HStack {
                Text("Not at all Likely")
                    .adaptiveFont(.neuzeitHeavy, size: 17.0)
                    .foregroundColor(.white)
                    .opacity(1.0 - Double(selectedPoint - 1) / Double(points.max()!) * 0.5)
                    .onTapGesture {
                        selectedPoint = points.min()!
                    }
                
                Spacer()
                
                Text("Extremely Likely")
                    .adaptiveFont(.neuzeitHeavy, size: 17.0)
                    .foregroundColor(.white)
                    .opacity(0.5 + Double(selectedPoint) / Double(points.max()!) * 0.5)
                    .onTapGesture {
                        selectedPoint = points.max()!
                    }
            }
        }
    }
}

#if DEBUG
struct NPSView_Previews: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            
            NPSView(selectedPoint: .constant(7))
                .padding(.horizontal, 20.0)
        }
    }
}
#endif
