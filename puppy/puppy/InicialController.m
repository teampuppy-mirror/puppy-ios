//
//  InicialController.m
//  puppy
//
//  Created by Cynthia on 11/04/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import "InicialController.h"
#import "UIColor+hexString.h"

@interface InicialController ()

@end

@implementation InicialController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCover];
    
    self.lblNome.alpha = 0.0;
    self.txtFieldNome.alpha = 0.0;
    self.btnJaTenhoCadastro.alpha = 0.0;
    self.btnJaTenhoCadastro.enabled = NO;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
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
    self.btnAccount.enabled = NO;
    self.btnJaTenhoCadastro.enabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.lblNome.alpha = 0.0;
        self.txtFieldNome.alpha = 0.0;
        self.btnJaTenhoCadastro.alpha = 0.0;
    }completion:^(BOOL finished){
        [UIView animateWithDuration:0.3 animations:^{
            self.btnRegister.alpha = 1.0;
            self.btnAccount.frame = CGRectMake(self.btnAccount.frame.origin.x, self.btnAccount.frame.origin.y-50, self.btnAccount.frame.size.width, self.btnAccount.frame.size.height);
        }completion:^(BOOL finished){
            self.btnAccount.enabled = YES;
            self.btnRegister.enabled = YES;
        }];
    }];
}

-(void)btnRegisterClick{
    self.btnAccount.enabled = NO;
    self.btnRegister.enabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.btnRegister.alpha = 0.0;
        self.btnAccount.frame = CGRectMake(self.btnAccount.frame.origin.x, self.btnAccount.frame.origin.y+50, self.btnAccount.frame.size.width, self.btnAccount.frame.size.height);
    }completion:^(BOOL finished){
        [UIView animateWithDuration:0.3 animations:^{
            self.lblNome.alpha = 1.0;
            self.txtFieldNome.alpha = 1.0;
            self.btnJaTenhoCadastro.alpha = 1.0;
        }completion:^(BOOL finished){
            self.btnAccount.enabled = YES;
            self.btnJaTenhoCadastro.enabled = YES;
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
