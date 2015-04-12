//
//  InicialController.m
//  puppy
//
//  Created by Cynthia on 11/04/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import "InicialController.h"
#import "UIColor+hexString.h"
#import "CMRequest.h"

@interface InicialController ()
@property BOOL isRegister;
@property CGPoint originalOrigin;
@property float upOriginY;
@property CGRect origemBotao;
@end

@implementation InicialController


-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:NO];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:YES];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{

        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
            [UIView animateWithDuration:0.3 animations:^{
                CGRect rect = self.view.frame;
                if (movedUp)
                {
                    // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
                    // 2. increase the size of the view so that the area behind the keyboard is covered up.
                    
                    rect.origin.y = self.upOriginY;
                }
                else
                {
                    // revert back to the normal state.
                    rect.origin.y = self.originalOrigin.y;
                }
                self.view.frame = rect;
            }];



}

-(void)blackViewClicked{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    
    NSLog(@"Origem: %f",self.view.frame.origin.y);
    self.originalOrigin = self.view.frame.origin;
    self.upOriginY = self.view.frame.origin.y - 190.0;
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blackViewClicked)];
    
    [self.blackVIew addGestureRecognizer:tap];
    
    _isRegister = NO;
    [super viewDidLoad];
    [self createCover];
    
    self.lblNome.alpha = 0.0;
    self.txtFieldNome.alpha = 0.0;
    self.btnJaTenhoCadastro.alpha = 0.0;
    self.btnJaTenhoCadastro.enabled = NO;
    
    self.txtFieldNome.delegate = self;
    self.txtFieldSenha.delegate = self;
    self.textFieldEmail.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    
    self.origemBotao = self.btnAccount.frame;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)btnEntrarClick:(id)sender {
    
    if(_isRegister){
        CMRequestModel * retorno = [CMRequest post:@"http://puppy.app.hackinpoa.tsuru.io/user" :[NSString stringWithFormat:@"{email: \"%@\",password: \"%@\",nome: \"%@\"}",self.textFieldEmail.text,self.txtFieldSenha.text,self.txtFieldNome.text]];
        
            NSLog(@"%d",retorno.status);
        
        
    }else{
        
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)createCover{

    UIImage *cover = [UIImage imageNamed:@"bg.png"];

    self.imageCover.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    self.imageCover.contentMode = UIViewContentModeScaleAspectFill;
    self.imageCover.clipsToBounds = YES;
    
    self.imageCover = [[UIImageView alloc] initWithImage:cover];
    self.btnAccount.backgroundColor = [UIColor whiteColor];
    self.btnAccount.tintColor = [UIColor colorWithHexString:@"#6D6D6C"];
    
    
    self.btnRegister.backgroundColor = [UIColor colorWithHexString:@"#D0C4C1"];
    self.btnRegister.tintColor = [UIColor colorWithHexString:@"#6D6D6C"];
    
    [self.btnRegister addTarget:self action:@selector(btnRegisterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.btnJaTenhoCadastro addTarget:self action:@selector(btnJaTenhoCadastroClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnJaTenhoCadastroClick{
    _isRegister = NO;
    self.btnAccount.enabled = NO;
    self.btnJaTenhoCadastro.enabled = NO;
    self.textFieldEmail.enabled = NO;
    self.txtFieldSenha.enabled = NO;
    self.txtFieldNome.enabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.lblNome.alpha = 0.0;
        self.txtFieldNome.alpha = 0.0;
        self.btnJaTenhoCadastro.alpha = 0.0;
    }completion:^(BOOL finished){
        [UIView animateWithDuration:0.3 animations:^{
            self.btnRegister.alpha = 1.0;
        }completion:^(BOOL finished){
            self.btnAccount.enabled = YES;
            self.btnRegister.enabled = YES;
            self.textFieldEmail.enabled = YES;
            self.txtFieldSenha.enabled = YES;
            self.txtFieldNome.enabled = YES;
        }];
    }];
}

-(void)btnRegisterClick{
    _isRegister = YES;
    self.btnAccount.enabled = NO;
    self.textFieldEmail.enabled = NO;
    self.txtFieldSenha.enabled = NO;
    self.txtFieldNome.enabled = NO;
    self.btnRegister.enabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.btnRegister.alpha = 0.0;
    }completion:^(BOOL finished){
        [UIView animateWithDuration:0.3 animations:^{
            self.lblNome.alpha = 1.0;
            self.txtFieldNome.alpha = 1.0;
            self.btnJaTenhoCadastro.alpha = 1.0;
        }completion:^(BOOL finished){
            self.btnAccount.enabled = YES;
            self.btnJaTenhoCadastro.enabled = YES;
            self.textFieldEmail.enabled = YES;
            self.txtFieldSenha.enabled = YES;
            self.txtFieldNome.enabled = YES;
        }];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
