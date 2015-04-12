//
//  EnviarMensagemViewController.h
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pet.h"
#import "User.h"

@interface EnviarMensagemViewController : UIViewController <UIAlertViewDelegate>
@property Pet * selectedPet;
@property User * user;
@end
