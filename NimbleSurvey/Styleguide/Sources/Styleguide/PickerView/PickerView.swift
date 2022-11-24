//
//  PickerView.swift
//  Styleguide
//
//  Created by Doan Thieu on 23/11/2022.
//

import SwiftUI

public struct PickerView: UIViewRepresentable {

    public class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {

        let hostedView: PickerView

        init(_ pickerView: PickerView) {
            self.hostedView = pickerView
        }

        public func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            hostedView.data.count
        }

        public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let rowView = view as? PickerViewRow ?? PickerViewRow()
            rowView.titleLabel.text = hostedView.data[row]
            rowView.isSelected = pickerView.selectedRow(inComponent: component) == row
            return rowView
        }

        public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 56.0
        }

        public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            hostedView.selection = hostedView.data[row]
            pickerView.reloadComponent(component)
        }
    }

    let data: [String]
    @Binding var selection: String

    public init(data: [String], selection: Binding<String>) {
        self.data = data
        self._selection = selection
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)

        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator

        if let row = data.firstIndex(of: selection) {
            picker.selectRow(row, inComponent: 0, animated: false)
        }

        return picker
    }

    public func updateUIView(_ view: UIPickerView, context: Context) {
        // Hack!
        if view.subviews.count >= 2 {
            let selectedView = view.subviews[1]
            selectedView.backgroundColor = .clear

            let topBorderLayer = CALayer()
            let bottomBorderLayer = CALayer()

            [topBorderLayer, bottomBorderLayer].enumerated().forEach { position, layer in
                layer.backgroundColor = UIColor.white.cgColor
                layer.frame = CGRect(
                    x: 0,
                    y: selectedView.frame.height * CGFloat(position),
                    width: selectedView.frame.width,
                    height: 1.0
                )
                selectedView.layer.addSublayer(layer)
            }
        }
    }
}
