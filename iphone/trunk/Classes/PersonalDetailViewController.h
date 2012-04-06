//
//  PersonalDetailViewController.h
//  SafeCity
//
//  Created by João Eduardo Galli on 7/11/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PersonalDetailViewController : UIViewController {
	IBOutlet UILabel *contato1Label, *contato2Label, *contato3Label; 
	IBOutlet UIButton *ligar1Button, *ligar2Button, *ligar3Button;
    IBOutlet UIImageView *formBackgroundImage;
}

@property (nonatomic, retain) IBOutlet UILabel *contato1Label, *contato2Label, *contato3Label; 
@property (nonatomic, retain) IBOutlet UIButton *ligar1Button, *ligar2Button, *ligar3Button;
@property (nonatomic, retain) IBOutlet NSArray *contato1, *contato2, *contato3;
@property (nonatomic, retain) IBOutlet UIImageView *formBackgroundImage;

-(void)populateContactLabel: (UILabel*) label Button: (UIButton*) button fromNumber: (int) number;
-(void)ligar:(id)sender;
-(BOOL)isContatoEmpty: (NSArray *) contato;

@end
