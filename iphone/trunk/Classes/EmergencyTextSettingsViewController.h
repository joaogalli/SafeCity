//
//  EmergencyTextSettingsViewController.h
//  SafeCity
//
//  Created by João Eduardo Galli on 5/5/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const EmergencyTextFileName;

@interface EmergencyTextSettingsViewController : UIViewController <UITextViewDelegate> {
	IBOutlet UITextField *telefoneField;
	IBOutlet UITextView *mensagemView;
	IBOutlet UIScrollView *scrollView;
	CGPoint svos;
}

@property (retain, nonatomic) IBOutlet UITextField *telefoneField;
@property (retain, nonatomic) IBOutlet UITextView *mensagemView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

+ (NSDictionary*) getTextInfo;

- (IBAction) salvar: (id) sender;
- (IBAction) textFieldDoneEditing:(id)sender;
- (IBAction) backgroundTap:(id)sender;

@end
