//
//  PetsTableViewController.m
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import "PetsTableViewController.h"
#import "PetTableViewController.h"
#import "CMRequest.h"

@interface PetsTableViewController ()

@end

@implementation PetsTableViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    _pets = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor lightGrayColor];
    NSDictionary * dicPets = [CMRequest get:@"http://puppy.app.hackinpoa.tsuru.io/pets"].data;
    NSArray * pets = [dicPets valueForKey:@"pets"];
    
    
    for(int i=0;i<pets.count-1;i++){
        NSDictionary * currentPet = pets[i];
        NSLog(@"%@",currentPet);
        Pet * pet = [[Pet alloc]init];
        pet.urlMiniatura = [currentPet valueForKey:@"miniatura"];
        pet.urlFoto = [currentPet valueForKey:@"foto"];
        pet.especie = [currentPet valueForKey:@"especie"];
        pet.porte = [currentPet valueForKey:@"porte"];
        pet.nome = [currentPet valueForKey:@"nome"];
        pet.cor = [currentPet valueForKey:@"cor"];
        pet.porte = [currentPet valueForKey:@"porte"];
        pet.especie = [currentPet valueForKey:@"especie"];
        pet.faixaEtaria = [currentPet valueForKey:@"idade"];
        pet.localizacao = [currentPet valueForKey:@"localizacao"];
        NSInteger sexo = ((NSNumber *)[currentPet valueForKey:@"sexo"]).integerValue;
        
        NSDictionary * protetor = [currentPet valueForKey:@"protetor"];
        
        pet.nomeProtetor = [protetor valueForKey:@"nome"];
        pet.idDoProtetor = [protetor valueForKey:@"id"];
        
        NSLog(@"Sexo: %ld",(long)sexo);
        if(sexo == 1){//femea
            pet.genero = @"Femêa";
        }else{
            if(sexo == 2){
                pet.genero = @"Macho";
            }else{
                pet.genero = @"Macho";
            }
        }
        [_pets addObject:pet];
    }
    self.title = @"Pets";
    
    
    [super viewDidLoad];

}

-(void)addFilterButton{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"Filtrar" style:UIBarButtonItemStyleBordered target:self action:@selector(teste)];
    rightItem.tag = 891;
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)teste{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _pets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    Pet * pet = _pets[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView * imageViewMiniatura = [[UIImageView alloc]init];
    UIView * grayBackgroundMiniatura = [[UIView alloc]init];
    grayBackgroundMiniatura.backgroundColor = [UIColor grayColor];
    grayBackgroundMiniatura.frame = CGRectMake(15, 15, 100, 100);
    [cell addSubview:grayBackgroundMiniatura];
    imageViewMiniatura.alpha = 0.0;
    
    UILabel * lblNome = [[UILabel alloc]initWithFrame:CGRectMake(130, 15, self.view.frame.size.width - 140, 36)];
    lblNome.adjustsFontSizeToFitWidth = YES;
    lblNome.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:21];
    lblNome.text = pet.nome;
    UILabel * lblEspeciePorte = [[UILabel alloc] initWithFrame:CGRectMake(130, 51, (self.view.frame.size.width - 140)/2, 36)];
    lblEspeciePorte.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    lblEspeciePorte.text = [NSString stringWithFormat:@"%@",pet.especie];
    lblEspeciePorte.adjustsFontSizeToFitWidth = YES;
    
    UILabel * lblPorte = [[UILabel alloc]initWithFrame:CGRectMake(130 + (self.view.frame.size.width - 140)/2, 51, (self.view.frame.size.width - 140)/2, 36)];
    lblPorte.text = [NSString stringWithFormat:@"%@", pet.porte ];
    lblPorte.font =[UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    
    [cell addSubview:lblPorte];
    lblPorte.adjustsFontSizeToFitWidth = YES;
    
    
    [cell addSubview:lblEspeciePorte];
    
    UILabel * lblCidade = [[UILabel alloc]initWithFrame:CGRectMake(130, 87, self.view.frame.size.width - 145, 36)];
    lblCidade.text = pet.localizacao;
    lblCidade.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    [cell addSubview:lblCidade];
    
    UIImageView * pinImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"map-pin-hi.png"]];
    pinImageView.frame = CGRectMake(130, 89, 20, 25);
    //[cell addSubview:pinImageView];
    
    
    dispatch_queue_t myCustomQueue = dispatch_queue_create("com.example.MyCustomQueue", NULL);
    dispatch_async(myCustomQueue, ^{
        NSData * info = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:pet.urlMiniatura]];
            if(info){
            
                        dispatch_async(dispatch_get_main_queue(),
                                       ^{
                                           imageViewMiniatura.image =[[UIImage alloc]initWithData:info];
                               [UIView animateWithDuration:0.3 animations:^{
                                   imageViewMiniatura.alpha = 1.0;
                               }];
                               
                           });
            }
    });
    imageViewMiniatura.frame = CGRectMake(15, 15, 100, 100);
    [cell addSubview:imageViewMiniatura];
    [cell addSubview:lblNome];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedPet = _pets[indexPath.row];
    [self performSegueWithIdentifier:@"goToPet" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PetTableViewController * destination = segue.destinationViewController;
    destination.selectedPet = _selectedPet;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

@end
