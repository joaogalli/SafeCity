//
//  DicaDetailViewController.h
//  SafeCity
//
//  Created by João Eduardo Galli on 5/4/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DicaDetailViewController : UIViewController {
	NSDictionary *bairro;
	NSMutableArray *dicas;
	int currentDica;
	IBOutlet UILabel *dicaLabel;
	IBOutlet UITextView *textoLabel;
    IBOutlet UIImageView *maisDicas, *formBackgroundImage;
}

@property (nonatomic, retain) NSDictionary *bairro;
@property (nonatomic, retain) NSMutableArray *dicas;
@property (nonatomic, retain) IBOutlet UILabel *dicaLabel;
@property (nonatomic, retain) IBOutlet UITextView *textoLabel;
@property (nonatomic, retain) IBOutlet UIImageView *maisDicas;
@property (nonatomic, retain) IBOutlet UIImageView *formBackgroundImage;

//- (id) initWithBairro: (NSDictionary*) bairro;
- (void) addDica: (NSString*) dica;
- (void) nextDica: (id) sender;

@end
