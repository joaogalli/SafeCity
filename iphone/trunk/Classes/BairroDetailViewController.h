//
//  BairroDetailViewController.h
//  SafeCity
//
//  Created by João Eduardo Galli on 12/9/11.
//  Copyright (c) 2011 Sovi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BairroDetailViewController : UIViewController {
    NSDictionary* locationBairro;
    IBOutlet UIImageView *formBackgroundImage;
	IBOutlet UITextField *nomeLabel, *delito1Label, *delito2Label;
}

@property (retain, nonatomic) NSDictionary *locationBairro;
@property (nonatomic, retain) IBOutlet UITextField *nomeLabel, *delito1Label, *delito2Label;
@property (nonatomic, retain) IBOutlet UIImageView *dicasView, *alertaEspecialView, *emergenciaView, *meuDestinoView, *formBackgroundImage;

-(void) setBairro: (NSDictionary*) bairro;

- (IBAction) showDicas: (id) sender;
- (IBAction) showEmergencia: (id) sender;
- (IBAction) showAlertaEspecial: (id) sender;
- (IBAction) showMeuDestino: (id) sender;

- (void) searchMyLocation;

@end
