//
//  LoginViewController.m
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    UIImageView * background = [[UIImageView alloc]initWithFrame:self.view.frame];
    background.image = [UIImage imageNamed:@"bg.png"];
    [self.view addSubview:background];
    
    UIImageView * logoLogin = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-160)/2, 50, 160, 160)];
    logoLogin.image = [UIImage imageNamed:@"logo-login.png"];
    [self.view addSubview:logoLogin];
    
    UILabel * emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 250, 50, 60)];
    emailLabel.layer.borderColor=[UIColor whiteColor].CGColor;
    emailLabel.layer.borderWidth = 2.0f;
    emailLabel.layer.cornerRadius = 2;
    emailLabel.text = @"email";
    emailLabel.backgroundColor = [UIColor whiteColor];
    emailLabel.clipsToBounds      = YES;
    emailLabel.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:emailLabel];
    
    
    UITextField * emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 250, self.view.frame.size.width - 70, 60)];
    emailTextField.layer.borderColor=[UIColor whiteColor].CGColor;
    emailTextField.layer.borderWidth = 2.0f;
    emailTextField.layer.cornerRadius = 2;
    emailTextField.backgroundColor = [UIColor whiteColor];
    emailTextField.clipsToBounds      = YES;
    [self.view addSubview:emailTextField];
    
    UIButton * btnNaoQueroMeCadastrar = [[UIButton alloc]initWithFrame:CGRectMake(10, 500, self.view.frame.size.width, 60)];

    [btnNaoQueroMeCadastrar addTarget:self action:@selector(bypass) forControlEvents:UIControlEventTouchUpInside];
    [btnNaoQueroMeCadastrar setTitle:@"Nao quero me cadastrar agora" forState:UIControlStateNormal];
    
    [self.view addSubview:btnNaoQueroMeCadastrar];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)bypass{
    [self performSegueWithIdentifier:@"byPass" sender:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
