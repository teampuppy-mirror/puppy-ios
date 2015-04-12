//
//  User.h
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property NSString * nome;
@property NSString * auth;
@property NSString * email;

+(User*)sharedUser;

@end
