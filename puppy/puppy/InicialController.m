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
    self.btnLogin.backgroundColor = [UIColor whiteColor];
    self.btnAccount.backgroundColor = [UIColor colorWithHexString:@"#D0C4C1"];
    self.btnLogin.tintColor = [UIColor colorWithHexString:@"#212121"];
    self.btnAccount.tintColor = [UIColor colorWithHexString:@"#6D6D6C"];
    
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
