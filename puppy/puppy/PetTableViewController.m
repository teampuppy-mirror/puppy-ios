//
//  PetViewController.m
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "PetTableViewController.h"
#import "UIColor+hexString.h"

#define HeaderHeight  180

@interface PetTableViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *petImageView;

@end

@implementation PetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeaderTableView:@"teste"];
    [self createProfileInfo:@"teste"];
    self.title = @"Perfil do Pet";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)createProfileInfo:(NSString *)genero{

    self.labelGenero.frame = CGRectMake(10.0, 10.0, self.view.frame.size.width, 20);
    self.labelReplyGenero.frame = CGRectMake(10.0, 30.0, self.view.frame.size.width, 20);
    self.labelEspecie.frame = CGRectMake(150.0, 10.0, self.view.frame.size.width, 20);
    self.labelReplyEspecie.frame = CGRectMake(150.0, 30.0, self.view.frame.size.width, 20);
    
    self.labelPorte.frame = CGRectMake(10.0, 10.0, self.view.frame.size.width, 20);
    self.labelReplyPorte.frame = CGRectMake(10.0, 30.0, self.view.frame.size.width, 20);
    self.labelLocalizacao.frame = CGRectMake(150.0, 10.0, self.view.frame.size.width, 20);
    self.labelReplyLocalizacao.frame = CGRectMake(150.0, 30.0, self.view.frame.size.width, 20);
    
    self.labelCor.frame = CGRectMake(150.0, 10.0, self.view.frame.size.width, 20);
    self.labelReplyCor.frame = CGRectMake(150.0, 30.0, self.view.frame.size.width, 20);
    
    self.labelFaixa.frame = CGRectMake(10.0, 10.0, self.view.frame.size.width, 20);
    self.labelReplyFaixa.frame = CGRectMake(10.0, 30.0, self.view.frame.size.width, 20);
    
    self.btnAdotar.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    self.btnAdotar.backgroundColor = [UIColor colorWithHexString:@"#212121"];
    self.btnAdotar.tintColor = [UIColor whiteColor];
    self.btnDenunciar.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    self.btnAdotar.titleLabel.text = @"QUERO CONHECER";
    self.btnDenunciar.backgroundColor = [UIColor whiteColor];
    self.btnDenunciar.titleLabel.text = @"DENUNCIAR ANÚNCIO";
    self.btnDenunciar.tintColor = [UIColor colorWithHexString:@"#FF4C4C"];
    
    
    
}

-(void)addHeaderTableView:(NSString *)image{
    
    
    self.petImageView.frame = CGRectMake(0,0, self.view.frame.size.width, HeaderHeight);
    self.petImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.petImageView.clipsToBounds = YES;
    UIImage *image1 = [UIImage imageNamed:@"dog-5.jpg"];


    self.petImageView = [[UIImageView alloc] initWithImage:image1];;
    
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 80, 320.f, 90.f)];
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
