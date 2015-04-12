//
//  PetViewController.m
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "PetTableViewController.h"
#import "UIColor+hexString.h"
#import "EnviarMensagemViewController.h"

#define HeaderHeight  100

@interface PetTableViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *petImageView;

@end

@implementation PetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeaderTableView:@"teste"];
    [self createProfileInfo:@"teste"];
    self.title = @"Pet";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(HeaderHeight, 0, 0, 0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)createProfileInfo:(NSString *)genero{

    self.labelGenero.frame = CGRectMake(10.0, 10.0, self.view.frame.size.width, 20);
    self.labelReplyGenero.frame = CGRectMake(10.0, 30.0, self.view.frame.size.width, 20);
    self.labelEspecie.frame = CGRectMake(150.0, 10.0, self.view.frame.size.width, 20);
    self.labelReplyEspecie.frame = CGRectMake(150.0, 30.0, self.view.frame.size.width, 20);
    
    self.labelPorte.frame = CGRectMake(10.0, 10.0, self.view.frame.size.width, 20);
    self.labelReplyPorte.frame = CGRectMake(10.0, 30.0, self.view.frame.size.width, 20);
    self.labelLocalizacao.frame = CGRectMake(150.0, 10.0, self.view.frame.size.width, 20);
    self.labelReplyLocalizacao.frame = CGRectMake(150.0, 30.0, self.view.frame.size.width, 20);
    
    self.labelCor.frame = CGRectMake(150.0, 10.0, self.view.frame.size.width, 20);
    self.labelReplyCor.frame = CGRectMake(150.0, 30.0, self.view.frame.size.width, 20);
    
    self.labelFaixa.frame = CGRectMake(10.0, 10.0, self.view.frame.size.width, 20);
    self.labelReplyFaixa.frame = CGRectMake(10.0, 30.0, self.view.frame.size.width, 20);
 
    self.btnAdotar.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    self.btnAdotar.backgroundColor = [UIColor colorWithHexString:@"#212121"];
    self.btnAdotar.tintColor = [UIColor whiteColor];
    self.btnDenunciar.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    self.btnAdotar.titleLabel.text = @"QUERO CONHECER";
    
    UIImageView * imgViewHearth = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hearth"]];
    imgViewHearth.frame = CGRectMake(0, 0, 30, 30);
    imgViewHearth.center = CGPointMake(45, self.btnAdotar.center.y);
    [self.btnAdotar addSubview:imgViewHearth];
    
    [self.btnAdotar addTarget:self action:@selector(queroconhecer) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.labelNomeDog.text = _selectedPet.nome;
    self.labelReplyEspecie.text = _selectedPet.especie;
    self.labelReplyPorte.text = _selectedPet.porte;
    self.labelReplyCor.text = _selectedPet.cor;
    self.labelReplyGenero.text = _selectedPet.genero;
    self.labelReplyFaixa.text = _selectedPet.faixaEtaria;
    self.labelReplyLocalizacao.text = _selectedPet.localizacao;
    
    
    self.btnDenunciar.backgroundColor = [UIColor whiteColor];
    self.btnDenunciar.titleLabel.text = @"DENUNCIAR ANÚNCIO";
    self.btnDenunciar.tintColor = [UIColor colorWithHexString:@"#FF4C4C"];
    
    
    self.labelNomeDog.frame = CGRectMake(10.0, 22.0, self.view.frame.size.width - 140, 20);
    self.labelNomeDog.numberOfLines = 1;
    self.labelNomeDog.text = @"Juarezinho";
    self.labelNomeDog.adjustsFontSizeToFitWidth = YES;
    
    [self.btnLike setTitle:@"" forState:UIControlStateNormal];
    self.btnLike.frame = CGRectMake(200, 10, 50, 45);
    [self.btnLike addTarget:self action:@selector(likePressed) forControlEvents:UIControlEventTouchUpInside];
    if(_selectedPet.like){
        [self.btnLike setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }else{
        [self.btnLike setBackgroundImage:[UIImage imageNamed:@"no-like"] forState:UIControlStateNormal];
    }
    
    [self adjustLabelCurtidasNumber];
    
    if(_selectedPet.numCurtidas > 1 || _selectedPet.numCurtidas == 0)
        self.labelCurtidas.text = @"curtidas";
    else
        self.labelCurtidas.text = @"curtida";
    
    float curtidasPosX = 260.0;
    
    self.labelNumCurtidas.frame = CGRectMake(curtidasPosX, 10, self.view.frame.size.width-curtidasPosX, 30);
    self.labelCurtidas.frame = CGRectMake(curtidasPosX, 30, self.view.frame.size.width-curtidasPosX, 30);
    
    self.labelNumCurtidas.textAlignment = NSTextAlignmentCenter;
    self.labelCurtidas.textAlignment = NSTextAlignmentCenter;
    
    
}

-(void)queroconhecer{
    [self performSegueWithIdentifier:@"goToMsg" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EnviarMensagemViewController * destination = segue.destinationViewController;
    destination.selectedPet = self.selectedPet;
}

-(void)adjustLabelCurtidasNumber{
        self.labelNumCurtidas.text = [NSString stringWithFormat:@"%ld",(long)_selectedPet.numCurtidas];
}

-(void)likePressed{
    _selectedPet.like = !_selectedPet.like;
    if(_selectedPet.like){
        _selectedPet.numCurtidas++;
        [self.btnLike setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }else{
        _selectedPet.numCurtidas--;
        [self.btnLike setBackgroundImage:[UIImage imageNamed:@"no-like"] forState:UIControlStateNormal];
    }
    [self adjustLabelCurtidasNumber];
}

-(void)addHeaderTableView:(NSString *)image{
    
    self.petImageView.alpha = 0.0;
    dispatch_queue_t myCustomQueue = dispatch_queue_create("com.example.MyCustomQueue", NULL);
    dispatch_async(myCustomQueue, ^{
        NSData * info = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:_selectedPet.urlMiniatura]];
        if(info){
            
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               self.petImageView.image = [[UIImage alloc]initWithData:info];
                               [UIView animateWithDuration:0.3 animations:^{
                                   self.petImageView.alpha = 1.0;
                               }];
                               
                           });
        }
    });
    self.petImageView.frame = CGRectMake(0,0, self.view.frame.size.width, HeaderHeight);
    self.petImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view sendSubviewToBack:_petImageView];
    


    
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0, 320.f, 90.f)];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow-layer.png"]];
    [myView addSubview:backgroundView];
    
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(12, 100, self.view.frame.size.width, HeaderHeight)];
    
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    [tableHeaderView addSubview:self.petImageView];
    
    self.tableView.tableHeaderView = tableHeaderView;
    [tableHeaderView addSubview:myView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    UILabel * lblTest = [[UILabel alloc]init];
    
    lblTest.frame = CGRectMake(0, 0, 100, 50);
    lblTest.text = @"testando";
    
    return cell;
}
*/
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yPos = -scrollView.contentOffset.y;
        CGRect imgRect = self.petImageView.frame;
        imgRect.origin.y = scrollView.contentOffset.y;
        imgRect.size.height = HeaderHeight+yPos;
        self.petImageView.frame = imgRect;
//    if (scrollView == self.tableView) {
//        if (scrollView.contentOffset.y > 0) {
//            scrollView.contentOffset = CGPointZero;
//        }
//    }
}
-(void)viewWillAppear:(BOOL)animated
{
    self.petImageView.frame = CGRectMake(0,-HeaderHeight, self.view.frame.size.width, HeaderHeight);
    [super viewWillAppear:animated];
    
}

@end
