//
//  InicialController.h
//  puppy
//
//  Created by Cynthia on 11/04/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InicialController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageCover;
@property IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIImageView *imageLogo;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldSenha;
@property (weak, nonatomic) IBOutlet UILabel *lblNome;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldNome;
@property (weak, nonatomic) IBOutlet UIButton *btnJaTenhoCadastro;
@property (weak, nonatomic) IBOutlet UIView *blackVIew;
@property (weak, nonatomic) IBOutlet UIButton *btnAccount;

@end
