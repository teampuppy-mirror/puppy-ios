//
//  User.m
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import "User.h"


static User * instance;

@implementation User

+(User*)sharedUser{
    if(instance==nil){
        instance = [[User alloc]init];
    }
    return instance;
}
@end
