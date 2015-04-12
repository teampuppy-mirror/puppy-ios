//
//  InicialController.m
//  puppy
//
//  Created by Cynthia on 11/04/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import "InicialController.h"
#import "UIColor+hexString.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "User.h"

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
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    [manager POST:@"http://puppy.app.hackinpoa.tsuru.io/user"
       parameters:@{@"email": @"Novouser29",
                    @"password": @"123",
                    @"nome": self.txtFieldNome.text,
                    }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
              
              if(((NSNumber*)[responseObject valueForKey:@"code"]).integerValue == 200){
                  
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];

    
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

-(void)bypass{
     [self performSegueWithIdentifier:@"bypass" sender:nil];
}

- (IBAction)btnEntrarClick:(id)sender {
    
    if(_isRegister){
        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
        
        
        [manager POST:@"http://puppy.app.hackinpoa.tsuru.io/user"
           parameters:@{@"email": self.textFieldEmail.text,
                        @"password": self.txtFieldSenha.text,
                        @"nome": self.txtFieldNome.text,
                        }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"JSON: %@", responseObject);

                  if(((NSNumber*)[responseObject valueForKey:@"code"]).integerValue == 200){

                      [[NSUserDefaults standardUserDefaults] setObject:self.textFieldEmail.text forKey:@"email"];
#pragma warning Nao esta seguro, sera modificado para keychain futuramente.
                      [[NSUserDefaults standardUserDefaults] setObject:self.txtFieldSenha.text forKey:@"senha"];
                      [[NSUserDefaults standardUserDefaults] setObject:self.txtFieldNome.text forKey:@"nome"];
                      [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"logado"];
                      [[NSUserDefaults standardUserDefaults] synchronize];
                      
                      
                      [self performSegueWithIdentifier:@"bypass" sender:nil];
                      
                      
                      //bypass
                  }
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error: %@", error);
              }];
        
        
        
    }else{
        
        
        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:self.textFieldEmail.text password:self.txtFieldSenha.text];
        
        [manager GET:@"http://puppy.app.hackinpoa.tsuru.io/user"
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 [[NSUserDefaults standardUserDefaults] setObject:self.textFieldEmail.text forKey:@"email"];
#pragma warning Nao esta seguro, sera modificado para keychain futuramente.
                 [[NSUserDefaults standardUserDefaults] setObject:self.txtFieldSenha.text forKey:@"senha"];
                 [[NSUserDefaults standardUserDefaults] setObject:self.txtFieldNome.text forKey:@"nome"];
                 [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"logado"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [self performSegueWithIdentifier:@"bypass" sender:nil];
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
             }];

        
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
