//
//  PetViewController.m
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import "PetTableViewController.h"

#define HeaderHeight  150

@interface PetTableViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *petImageView;

@end

@implementation PetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.petImageView.frame = CGRectMake(0,0, self.view.frame.size.width, HeaderHeight);
    self.petImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.petImageView.clipsToBounds = YES;
    [self.view addSubview:self.petImageView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    UILabel * lblTest = [[UILabel alloc]init];
    
    lblTest.frame = CGRectMake(0, 0, 100, 50);
    lblTest.text = @"testando";
    
    return cell;
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
