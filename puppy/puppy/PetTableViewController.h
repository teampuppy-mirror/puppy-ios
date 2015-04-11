//
//  PetViewController.h
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pet.h"

@interface PetTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *labelReplyCor;
@property (weak, nonatomic) IBOutlet UILabel *labelCor;
@property Pet * selectedPet;
@property (weak, nonatomic) IBOutlet UILabel *labelGenero;
@property (weak, nonatomic) IBOutlet UILabel *labelReplyGenero;
@property (weak, nonatomic) IBOutlet UILabel *labelEspecie;
@property  IBOutlet UILabel *labelReplyEspecie;
@property (weak, nonatomic) IBOutlet UILabel *labelFaixa;
@property (weak, nonatomic) IBOutlet UILabel *labelReplyFaixa;
@property (weak, nonatomic) IBOutlet UILabel *labelPorte;
@property (weak, nonatomic) IBOutlet UILabel *labelReplyPorte;
@property (weak, nonatomic) IBOutlet UILabel *labelLocalizacao;
@property (weak, nonatomic) IBOutlet UILabel *labelReplyLocalizacao;
@property (weak, nonatomic) IBOutlet UIButton *btnAdotar;
@property (weak, nonatomic) IBOutlet UIButton *btnDenunciar;










@end
