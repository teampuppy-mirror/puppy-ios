//
//  EnviarMensagemViewController.m
//  puppy
//
//  Created by Eder Martins on 4/11/15.
//  Copyright (c) 2015 dedeh. All rights reserved.
//

#import "EnviarMensagemViewController.h"
#import "UIColor+hexString.h"

@interface EnviarMensagemViewController ()

@end

@implementation EnviarMensagemViewController{
    UITextView * textView;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [textView resignFirstResponder];
}

- (void)viewDidLoad {
    self.user = [[User alloc]init];
    self.user.nome = [[NSUserDefaults standardUserDefaults] valueForKey:@"nome"];
    self.user.email = [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];
    
    [super viewDidLoad];
    self.title = @"Enviar Mensagem";
    
    
    UILabel * lblMsg = [[UILabel alloc]init];
    lblMsg.frame = CGRectMake(10, 75, self.view.frame.size.width-20, 30);
    lblMsg.text = [NSString stringWithFormat:@"Mensagem para protetor: %@",_selectedPet.nomeProtetor];
    lblMsg.adjustsFontSizeToFitWidth = YES;
    lblMsg.textAlignment = NSTextAlignmentCenter;


    textView = [[UITextView alloc]init];
    textView.frame = CGRectMake(10, 120, self.view.frame.size.width - 20, self.view.frame.size.height - 200);

    
    textView.text = [NSString stringWithFormat:@"Olá protetor %@, estou entrando em contato pois estou interessado em conhecer o %@ %@.", _selectedPet.nomeProtetor, _selectedPet.especie,_selectedPet.nome];
    textView.text = [textView.text stringByAppendingString:[NSString stringWithFormat:@"Por favor, se possivel entrar em contato comigo pelo e-mail: %@\n\n",self.user.email]];
    textView.text = [textView.text stringByAppendingString:[NSString stringWithFormat:@"Atenciosamente, %@",self.user.nome]];
    
    textView.layer.borderColor=[UIColor blackColor].CGColor;
    textView.layer.borderWidth = 2.0f;
    textView.layer.cornerRadius = 2;
    textView.backgroundColor = [UIColor whiteColor];
    textView.clipsToBounds      = YES;
    textView.textAlignment = NSTextAlignmentCenter ;
    
    
    UIButton * btnEnviar = [[UIButton alloc]init];
    btnEnviar.frame = CGRectMake(10,self.view.frame.size.height - 70 , self.view.frame.size.width - 20, 60);
    [btnEnviar setTitle:@"Enviar" forState:UIControlStateNormal];
    
    btnEnviar.backgroundColor = [UIColor colorWithHexString:@"#212121"];
    [self.view addSubview:textView];
    [self.view addSubview:btnEnviar];
    [self.view addSubview:lblMsg];
    
    
}

-(void)enviarMsg{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enviada!"
                                                      message:@"Mensagem Enviada com Sucesso."
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
