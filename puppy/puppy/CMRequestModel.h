//
//  CMRequestModel.h
//  CareMeApp
//
//  Created by Cristian Madrid on 07/10/14.
//  Copyright (c) 2014 Cynthia Zanoni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMRequestModel : NSObject

@property NSString *message;
@property NSDictionary *data;
@property int status;
@property bool success;

@end
