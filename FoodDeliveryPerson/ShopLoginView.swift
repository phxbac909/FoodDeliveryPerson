//
//  LoginView.swift
//  FoodOrder
//
//  Created by TTC on 7/3/25.
//

import SwiftUI

struct ShopLoginView: View {
    
    @StateObject var viewModel = ShopLoginViewModel()
    @FocusState private var focusedField: Field?
    private var isLogable : Bool {viewModel.username.isEmpty||viewModel.password.isEmpty}
    @State private var isLoginForm : Bool = true
    
    var body: some View {
        ZStack(alignment: .top){
            Image("back")
                .resizable()
                .frame(height: 300)
                .scaledToFit()
                .edgesIgnoringSafeArea(.top)

            VStack{
                Image("")
                    .resizable()
                    .frame(height: 265)
                ZStack{
                    Color("backgroundColor")
                    VStack(spacing: 10){
                        
                        Text("Welcome to NvrnApp")
                            .font(.largeTitle).bold()
                            .fontWeight(.semibold)
                            .padding(.top,30)
                
                    
                        if isLoginForm {
                            loginForm
                        }
                        else {
                            registerForm
                        }
                    }
                    .padding()
                }
                .cornerRadius(30)
            }.ignoresSafeArea()

        }
    }
    
    private var registerForm : some View {
        VStack{
            
            Text("Join and become our partner")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.bottom,40)
            TextField("Username", text: $viewModel.username)
                .padding()
                .background(Color.brandPrimaryColor.opacity(0.075))
                .cornerRadius(5)
                .padding(.bottom,20)
                .submitLabel(.continue)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: .field1)
                .onSubmit {focusedField = .field2}
            HStack(spacing : 5){
                if viewModel.isDuplicateAcountName {
                    Text("Username is already have !")
                        .font(.subheadline)
                        .foregroundStyle(.red)
                        .bold()
                    Spacer()
                }
            }
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.brandPrimaryColor.opacity(0.075))
                .cornerRadius(5)
                .padding(.bottom,10)
                .focused($focusedField, equals: .field2)
                .onSubmit {focusedField = .field3}

            TextField("Full Name", text: $viewModel.fullName)
                .padding()
                .background(Color.brandPrimaryColor.opacity(0.075))
                .cornerRadius(5)
                .padding(.bottom,20)
                .submitLabel(.continue)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: .field3)
                .onSubmit {focusedField = .field4}
             
          
            Button{
                Task{
                    await viewModel.register()
                 }
            } label: {
                Text("REGISTER")
                    .font(.headline)
                    .foregroundStyle(.white)
                if viewModel.isSigning {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint : .white))
                }
            }
            .frame(width: 220, height: 60)
            .background(isLogable ? Color.blue.opacity(0.8):Color.blue)
            .cornerRadius(35)
            .disabled(isLogable)
            .padding(.top,40)

            
            Spacer()
            
            HStack{
                Text("Already have account ?")
                    .font(.subheadline)
                Button {
                    isLoginForm = true
                } label: {
                    Text("Back to login")
                        .font(.headline)
                        .foregroundStyle(Color.brandPrimaryColor)

                }
            }
            Spacer()

        }
    }
    
    private var loginForm : some View {
        VStack{
            
            Text("Join and become our partner")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.bottom,40)
            TextField("Username", text: $viewModel.username)
                .padding()
                .background(Color.brandPrimaryColor.opacity(0.075))
                .cornerRadius(5)
                .padding(.bottom,20)
                .submitLabel(.continue)
                .textInputAutocapitalization(.never)
    //                        .focused($focusedField, equals: .field2)
                .onSubmit {focusedField = .field1}
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.brandPrimaryColor.opacity(0.075))
                .cornerRadius(5)
                .padding(.bottom,10)
                .focused($focusedField, equals: .field1)
            
            HStack(spacing : 5){
                if viewModel.isWrongAccount {
                    Text("Username or password is incorrent !")
                        .font(.subheadline)
                        .foregroundStyle(.red)
                        .bold()
                    Spacer()
                }
               
            }
                .padding(.horizontal)
            HStack(spacing : 5){
               
                Text("Forgot Password ?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
                .padding(.horizontal)
        
        
            Button{
                Task{
                     await viewModel.login()
                 }
            } label: {
                Text("LOGIN")
                    .font(.headline)
                    .foregroundStyle(.white)
                if viewModel.isLogging {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint : .white))
                }
            }
            .frame(width: 220, height: 60)
            .background(isLogable ? Color.brandPrimaryColor.opacity(0.8):Color.brandPrimaryColor)
            .cornerRadius(35)
            .disabled(isLogable)
            .padding(.top,40)

            
            Spacer()
            
            HStack{
                Text("New here ?")
                    .font(.subheadline)
                Button {
                    isLoginForm = false
                } label: {
                    Text("Create new account")
                        .font(.headline)
                        .foregroundStyle(.blue)
                }
            }
            Spacer()
        }
    }
}

enum ShopField {
        case field1, field2, field3, field4
    }

#Preview {
    ShopLoginView()
}
