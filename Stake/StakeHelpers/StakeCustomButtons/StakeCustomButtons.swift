import SwiftUI

struct CustomTextView: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var height: CGFloat = 170
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(.clear)
                .cornerRadius(12)
            
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .padding(.horizontal, 15)
                .padding(.top, 5)
                .frame(height: height)
                .font(.custom("SFProDisplay-Regular", size: 18))
                .foregroundColor(Color(red: 137/255, green: 141/255, blue: 148/255))
                .focused($isTextFocused)
            
            if text.isEmpty && !isTextFocused {
                VStack {
                    Text(placeholder)
                        .font(.custom("SFProDisplay-Regular", size: 14))
                        .foregroundStyle(Color(red: 137/255, green: 141/255, blue: 148/255))
                        .padding(.leading, 15)
                        .padding(.top, 5)
                        .onTapGesture {
                            isTextFocused = true
                        }
                    Spacer()
                }
            }
        }
        .frame(height: height)
    }
}

struct DateTF: View {
    @Binding var date: Date
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 65, height: 24)
                    .cornerRadius(15)
                
                Text(formattedDate(date: date))
                    .Pro(size: 12, color: Color(red: 196/255, green: 198/255, blue: 202/255))
                
                DatePicker(
                    "Date",
                    selection: $date,
                    in: Date()...,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                .colorMultiply(.clear)
                .frame(width: 85, height: 24)
                .onChange(of: date, perform: { newDate in
                    selectedDate = newDate
                })
               
            }
            .labelsHidden()
            .frame(width: 90, height: 24)
        }
    }
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

struct CustomClearTextField: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var textSize: CGFloat = 20
    var isBold = true
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(.clear)
                .frame(height: 37)
                .cornerRadius(12)

            TextField("", text: $text, onEditingChanged: { isEditing in
                isTextFocused = isEditing
            })
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .frame(height: 37)
            .font(.custom("SFProDisplay-Bold", size: 20))
            .cornerRadius(9)
            .foregroundStyle(Color(red: 153/255, green: 173/255, blue: 200/255))
            .focused($isTextFocused)
            .padding(.horizontal, 15)

            if text.isEmpty && !isTextFocused {
                if isBold {
                    Text(placeholder)
                        .ProBold(size: textSize, color: Color(red: 137/255, green: 141/255, blue: 148/255))
                        .frame(height: 27)
                        .padding(.leading, 15)
                        .onTapGesture {
                            isTextFocused = true
                        }
                } else {
                    Text(placeholder)
                        .Pro(size: textSize, color: Color(red: 137/255, green: 141/255, blue: 148/255))
                        .frame(height: 27)
                        .padding(.leading, 15)
                        .onTapGesture {
                            isTextFocused = true
                        }
                }
            }
        }
    }
}

struct CustomTextField: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String

    var body: some View {
        ZStack(alignment: .leading) {
            Group {
                if text.isEmpty && !isTextFocused {
                    Rectangle()
                        .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                        .frame(height: 47)
                        .cornerRadius(12)
                } else if isTextFocused {
                    Rectangle()
                        .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(red: 17/255, green: 117/255, blue: 226/255))
                        }
                        .frame(height: 47)
                        .cornerRadius(12)
                } else if !text.isEmpty && !isTextFocused {
                    Rectangle()
                        .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(red: 18/255, green: 73/255, blue: 133/255))
                        }
                        .frame(height: 47)
                        .cornerRadius(12)
                }
            }

            TextField("", text: $text, onEditingChanged: { isEditing in
                isTextFocused = isEditing
            })
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .frame(height: 47)
            .font(.custom("SFProDisplay-Regular", size: 15))
            .cornerRadius(9)
            .foregroundStyle(Color(red: 153/255, green: 173/255, blue: 200/255))
            .focused($isTextFocused)
            .padding(.horizontal, 15)

            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .Pro(size: 16, color: Color(red: 137/255, green: 141/255, blue: 148/255))
                    .frame(height: 47)
                    .padding(.leading, 15)
                    .onTapGesture {
                        isTextFocused = true
                    }
            }
        }
    }
}

struct CustomSecureFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            Group {
                if text.isEmpty && !isTextFocused {
                    Rectangle()
                        .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                        .frame(height: 47)
                        .cornerRadius(12)
                } else if isTextFocused {
                    Rectangle()
                        .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(red: 17/255, green: 117/255, blue: 226/255))
                        }
                        .frame(height: 47)
                        .cornerRadius(12)
                } else if !text.isEmpty && !isTextFocused {
                    Rectangle()
                        .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(red: 18/255, green: 73/255, blue: 133/255))
                        }
                        .frame(height: 47)
                        .cornerRadius(12)
                }
            }
            
            SecureField("", text: $text)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .frame(height: 47)
                .font(.custom("SFProDisplay-Regular", size: 16))
                .cornerRadius(9)
                .foregroundStyle(Color(red: 153/255, green: 173/255, blue: 200/255))
                .focused($isTextFocused)
                .padding(.horizontal, 15)
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .Pro(size: 16, color: Color(red: 137/255, green: 141/255, blue: 148/255))
                    .frame(height: 47)
                    .padding(.leading, 15)
                    .onTapGesture {
                        isTextFocused = true
                    }
            }
        }
    }
}
