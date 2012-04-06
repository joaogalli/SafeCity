//
//  EmergencyCallSettingsViewController.h
//  SafeCity
//
//  Created by João Eduardo Galli on 5/5/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const EmergencyCallFileName;

@interface EmergencyCallSettingsViewController : UIViewController {
	IBOutlet UITextField *telefoneField;
    IBOutlet UITextField *activeField;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIImageView *formBackgroundImage;
}

@property (retain, nonatomic) IBOutlet UITextField *telefoneField;
@property (nonatomic, retain) IBOutlet UIImageView *formBackgroundImage;

+ (NSString*) getPhoneNumber;
- (IBAction) salvar: (id) sender;

@end
