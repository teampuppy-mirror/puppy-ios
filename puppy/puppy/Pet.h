//
//  Pet.h
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pet : NSObject

@property NSString * nome;
@property NSString * cor;
@property NSString * especie;
@property NSString * porte;
@property NSString * localizacao;
@property NSString * faixaEtaria;
@property BOOL like;

@property NSString * urlMiniatura;
@property NSArray * fotos;

@end
