import SwiftUI

struct ContentView: View {
    @State private var inputText = ""
    @State private var outputText = ""
    @State private var shiftAmount = 0
    @State private var isEncrypting = true
    
    var body: some View  {
        VStack {
            Text(isEncrypting ? "Encrypt" : "Decrypt")
                .font(.title)
                .padding()

            HStack {
                Text("Input:")
                TextField("Enter text to encrypt or decrypt", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            HStack {
                Text("Shift Amount:")
                Stepper(value: $shiftAmount, in: 0...25) {
                    Text("\(shiftAmount)")
                }
            }
            .padding()
            
            Button(action: {
                withAnimation {
                    outputText = caesarCipher(inputText: inputText, shiftAmount: shiftAmount, isEncrypting: isEncrypting)
                }
            }) {
                Text(isEncrypting ? "Encrypt" : "Decrypt")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
            }
            .padding()
            
            HStack {
                Text("Output:")
                TextField("Result will be shown here", text: $outputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)
            }
            .padding()
            
            Button(action: {
                withAnimation {
                    isEncrypting.toggle()
                    inputText = ""
                    outputText = ""
                }
            }) {
                Text(isEncrypting ? "Switch to Decrypt" : "Switch to Encrypt")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
            }
            .padding()
        }
    }
    
    private func caesarCipher(inputText: String, shiftAmount: Int, isEncrypting: Bool) -> String {
        let alphabet = "abcdefghijklmnopqrstuvwxyz"
        var result = ""
        let shift = isEncrypting ? shiftAmount : 26 - shiftAmount
        for char in inputText.lowercased() {
            if let index = alphabet.firstIndex(of: char) {
                let shiftedIndex = (alphabet.distance(from: alphabet.startIndex, to: index) + shift) % 26
                let shiftedChar = alphabet[alphabet.index(alphabet.startIndex, offsetBy: shiftedIndex)]
                result.append(shiftedChar)
            } else {
                result.append(char)
            }
        }
        return result
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
