//
//  PetViewController.m
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "PetTableViewController.h"

#define HeaderHeight  220

@interface PetTableViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *petImageView;

@end

@implementation PetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeaderTableView:@"teste"];
}

-(void)createProfileInfo:(NSString *)genero{
    
}

-(void)addHeaderTableView:(NSString *)image{
    
    
    self.petImageView.frame = CGRectMake(0,0, self.view.frame.size.width, HeaderHeight);
    self.petImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.petImageView.clipsToBounds = YES;
    UIImage *image1 = [UIImage imageNamed:@"dog-5.jpg"];


    self.petImageView = [[UIImageView alloc] initWithImage:image1];;
    
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 120.f, 320.f, 90.f)];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow-layer.png"]];
    [myView addSubview:backgroundView];
    
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(12, 100, self.view.frame.size.width, HeaderHeight)];
    
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    [tableHeaderView addSubview:self.petImageView];
    
    self.tableView.tableHeaderView = tableHeaderView;
    [tableHeaderView addSubview:myView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    UILabel * lblTest = [[UILabel alloc]init];
    
    lblTest.frame = CGRectMake(0, 0, 100, 50);
    lblTest.text = @"testando";
    
    return cell;
}
*/
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yPos = -scrollView.contentOffset.y;
    if (yPos > 0) {
        
        CGRect imgRect = self.petImageView.frame;
        imgRect.origin.y = scrollView.contentOffset.y;
        imgRect.size.height = HeaderHeight+yPos;
        self.petImageView.frame = imgRect;
    }
    if (scrollView == self.tableView) {
        if (scrollView.contentOffset.y > 0) {
            scrollView.contentOffset = CGPointZero;
        }
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
}

@end
