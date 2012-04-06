//
//  ContatoDetailViewController.h
//  SafeCity
//
//  Created by João Eduardo Galli on 5/5/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const ContatoFileName;

@interface ContatoDetailViewController : UIViewController {
	IBOutlet UITextField *nomeField, *telefoneField;
	NSInteger *contatoNumber;
    IBOutlet UIImageView *formBackgroundImage;
}

@property (retain, nonatomic) IBOutlet UITextField *nomeField;
@property (retain, nonatomic) IBOutlet UITextField *telefoneField;
@property (nonatomic) NSInteger *contatoNumber;
@property (nonatomic, retain) IBOutlet UIImageView *formBackgroundImage;

- (IBAction) salvar: (id) sender;
- (IBAction) textFieldDoneEditing:(id)sender;
- (IBAction) backgroundTap:(id)sender;

- (NSString*) dataFilePath;
- (void) applicationWillResignActive:(NSNotification*) notification;
+ (NSArray*) getContato: (int) number;

@end
