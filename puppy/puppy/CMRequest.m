//
//  CMRequest.m
//  CareMeApp
//
//  Created by Cristian Madrid on 04/10/14.
//  Copyright (c) 2014 Cynthia Zanoni. All rights reserved.
//

#import "CMRequest.h"
#import "CMRequestModel.h"

@implementation CMRequest


+(CMRequestModel *)get:(NSString *)url
{
    
    NSURL *urlFormat = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:urlFormat];
    
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    CMRequestModel *request = [[CMRequestModel alloc]init];
    
    // Send a synchronous request
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data  options:0 error:nil];
    
    if(error != nil) {
        request.message = @"Não foi possível conectar ao servidor";
        request.status = 500;
    }
    else {
        
        if (responseData) {
            
            request.success = [[responseData objectForKey: @"error"]intValue] == 1 ? false : true;
            request.status = 200;
            
            if(request.success) {
                request.data = responseData;
                return request;
            }
        }
        else {
            request.status = 400;
            request.message = @"Erro!";
        }
    }
    
    return request;
}

+(CMRequestModel *)delete:(NSString *)url
{
    //webserviceURL
    url = [@"teste" stringByAppendingString: url];
    
    NSURL *urlFormat = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:urlFormat];
    
    [urlRequest setHTTPMethod:@"DELETE"];
    
    CMRequestModel *request = [[CMRequestModel alloc]init];
    
    // Send a synchronous request
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data  options:0 error:nil];
    
    if(error != nil) {
        request.message = @"Não foi possível conectar ao servidor";
        request.status = 500;
    }
    else {
        if (responseData) {
            
            request.success = [[responseData objectForKey: @"error"]intValue] == 1 ? false : true;
            request.status = 200;
            
            if(request.success) {
                request.data = responseData;
                return request;
            }
        }
        else {
            request.status = 400;
            request.message = @"Erro!";
        }
    }
    
    return request;
}

+(CMRequestModel *)post:(NSString *)url : (NSString *)json
{
    //webserviceURL
    //url = [stringByAppendingString:url];
    //NSLog(@"%@", url);
    
    CMRequestModel *request = [[CMRequestModel alloc]init];
    NSURL *urlFormat = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:urlFormat];
    [urlRequest setHTTPMethod:@"POST"];
    
    if(json.length > 0) {
        
        NSData * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
        [urlRequest setHTTPBody:jsonData];
    }
    
    // Send a synchronous request
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data  options:0 error:nil];
    
    if(error != nil) {
        request.message = @"Não foi possível conectar ao servidor";
        request.status = 500;
    }
    else {
        if (responseData) {
            
            request.success = [[responseData objectForKey: @"error"]intValue] == 1 ? false : true;
            request.status = 200;
            
            if(request.success) {
                request.data = responseData;
                return request;
            }
        }
        else {
            request.status = 400;
            request.message = @"Erro!";
        }
    }
    
    return request;
}

+(CMRequestModel *)post:(NSString *)url{
    
    return [self post: url : @""];
}

+(CMRequestModel *)post:(NSString *)url : (NSData*) file : (NSString*) name
{
    
    return [self sendFile: url : @"POST" : file : name];
}

+(CMRequestModel *)put:(NSString *)url : (NSString *)json
{
    
    url = [@"teste" stringByAppendingString:url];
    NSLog(@"%@", url);
    
    CMRequestModel *request = [[CMRequestModel alloc]init];
    NSURL *urlFormat = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:urlFormat];
    [urlRequest setHTTPMethod:@"PUT"];
    
    if(json.length > 0) {
        
        NSData * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
        [urlRequest setHTTPBody:jsonData];
    }
    
    // Send a synchronous request
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data  options:0 error:nil];
    
    if(error != nil) {
        request.message = @"Não foi possível conectar ao servidor";
        request.status = 500;
    }
    else {
        if (responseData) {
            
            request.success = [[responseData objectForKey: @"error"]intValue] == 1 ? false : true;
            request.status = 200;
            
            if(request.success) {
                request.data = responseData;
                return request;
            }
        }
        else {
            request.status = 400;
            request.message = @"Erro!";
        }
    }
    
    return request;
}

+(CMRequestModel *)put:(NSString *)url
{
    return [self put: url : @""];
}

+(CMRequestModel *)put:(NSString *)url : (NSData*) file : (NSString*) name
{
    return [self sendFile: url : @"PUT" : file : name];
}

+(CMRequestModel *)sendFile:(NSString *)url : (NSString*) httpMethod :(NSData*)file : (NSString*)name
{
    
    url = [@"teste" stringByAppendingString:url];
    NSLog(@"%@", url);
    
    CMRequestModel *request = [[CMRequestModel alloc]init];
    NSURL *urlFormat = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:urlFormat];
    
    [urlRequest setHTTPMethod:httpMethod];
    [urlRequest setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [urlRequest setHTTPShouldHandleCookies:NO];
    [urlRequest setTimeoutInterval:60];
    
    NSString *boundary = @"unique-consistent-string";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    [urlRequest setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n", @"photo"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"Some Caption"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (file) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@; filename=imageName.jpg\r\n", name] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:file];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // Send a synchronous request
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data  options:0 error:nil];
    
    if(error != nil) {
        request.message = @"Não foi possível conectar ao servidor";
        request.status = 500;
    }
    else {
        if (responseData) {
            
            request.success = [[responseData objectForKey: @"error"]intValue] == 1 ? false : true;
            request.status = 200;
            
            if(request.success) {
                request.data = responseData;
                return request;
            }
        }
        else {
            request.status = 400;
            request.message = @"Erro!";
        }
    }
    
    return request;
    
}

@end