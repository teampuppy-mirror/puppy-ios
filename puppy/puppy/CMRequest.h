//
//  CMRequest.h
//  CareMeApp
//
//  Created by Cristian Madrid on 04/10/14.
//  Copyright (c) 2014 Cynthia Zanoni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMRequestModel.h"
#
@interface CMRequest : NSObject

+(CMRequestModel *)get:(NSString *)url;

+(CMRequestModel *)delete:(NSString *)url;

+(CMRequestModel *)post:(NSString *)url;
+(CMRequestModel *)post:(NSString *)url : (NSString *)json;
+(CMRequestModel *)post:(NSString *)url : (NSData*) file : (NSString*) name;

+(CMRequestModel *)put:(NSString *)url;
+(CMRequestModel *)put:(NSString *)url : (NSString *)json;
+(CMRequestModel *)put:(NSString *)url : (NSData*) file : (NSString*) name;

@end
