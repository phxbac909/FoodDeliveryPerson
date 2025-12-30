import SwiftUI

struct DoubleTextField: View {
    let title: String
    @Binding var value: Double
    
    @State private var textValue: String = ""
    @State private var isEditing: Bool = false
    
    init(title: String, value: Binding<Double>) {
        self.title = title
        self._value = value
        self._textValue = State(initialValue: String(format: "%.2f", value.wrappedValue))
    }
    
    var body: some View {
        TextField(title, text: $textValue, onEditingChanged: { editing in
            self.isEditing = editing
        })
        .keyboardType(.decimalPad)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .onSubmit {
            parseTextToDouble()
            hideKeyboard()
        }
        .submitLabel(.done)
//        .toolbar {
//            ToolbarItem(placement: .keyboard) {
//                HStack {
//                    Spacer()
//                    Button("Done") {
//                        parseTextToDouble()
//                        isEditing = false
//                        hideKeyboard()
//                    }
//                    .disabled(textValue.isEmpty) // Disable nút nếu text rỗng
//                }
//            }
//        }
//        .onChange(of: value) { newValue in
//            if !isEditing {
//                textValue = String(format: "%.2f", newValue)
//            }
//        }
    }
    
    private func parseTextToDouble() {
        // Thay dấu phẩy bằng dấu chấm
        let normalizedText = textValue.replacingOccurrences(of: ",", with: ".")
        
        // Parse số
        if let doubleValue = Double(normalizedText) {
            value = doubleValue
        } else {
            // Nếu parse thất bại, đặt về giá trị gốc
            textValue = String(format: "%.2f", value)
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                      to: nil,
                                      from: nil,
                                      for: nil)
    }
}
