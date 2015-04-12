//
//  PetsTableViewController.m
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import "PetsTableViewController.h"
#import "PetTableViewController.h"

@interface PetsTableViewController ()

@end

@implementation PetsTableViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    _pets = [[NSMutableArray alloc]init];
    self.title = @"Pets";
    Pet * pet = [[Pet alloc]init];
    pet.nome = @"Juarezinho";
    pet.cor = @"Branquinho";
    pet.porte = @"Filhote";
    pet.especie = @"cachorro";
    pet.nomeProtetor = @"ONG patas dadas";
    pet.localizacao = @"Porto Alegre";
    pet.especie = @"Cachorro";
    pet.urlMiniatura = @"http://wallpaper.ultradownloads.com.br/45586_Papel-de-Parede-Filhote-de-Cachorro_1024x768.jpg";
    pet.fotos = @[@"http://wallpaper.ultradownloads.com.br/45586_Papel-de-Parede-Filhote-de-Cachorro_1024x768.jpg",@"http://wallpaper.ultradownloads.com.br/45586_Papel-de-Parede-Filhote-de-Cachorro_1024x768.jpg",@"http://wallpaper.ultradownloads.com.br/45586_Papel-de-Parede-Filhote-de-Cachorro_1024x768.jpg"];
    
    
    [_pets addObject:pet];
    [self addFilterButton];
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
    
    UILabel * lblNome = [[UILabel alloc]initWithFrame:CGRectMake(130, 15, self.view.frame.size.width - 145, 36)];
    lblNome.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:21];
    lblNome.text = pet.nome;
    UILabel * lblEspeciePorte = [[UILabel alloc] initWithFrame:CGRectMake(130, 51, self.view.frame.size.width - 145, 36)];
    lblEspeciePorte.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    lblEspeciePorte.text = [NSString stringWithFormat:@"%@   %@",pet.especie,pet.porte];
    
    [cell addSubview:lblEspeciePorte];
    
    UILabel * lblCidade = [[UILabel alloc]initWithFrame:CGRectMake(160, 87, self.view.frame.size.width - 145, 36)];
    lblCidade.text = pet.localizacao;
    lblCidade.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    [cell addSubview:lblCidade];
    
    UIImageView * pinImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"map-pin-hi.png"]];
    pinImageView.frame = CGRectMake(130, 89, 20, 25);
    [cell addSubview:pinImageView];
    
    
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
