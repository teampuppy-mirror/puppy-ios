//
//  PetsTableViewController.h
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pet.h"

@interface PetsTableViewController : UITableViewController <UIAlertViewDelegate>
@property NSMutableArray * pets;
@property Pet * selectedPet;
@end
