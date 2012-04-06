//
//  DisclaimerViewController.h
//  SafeCity
//
//  Created by João Eduardo Galli on 7/29/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisclaimerViewController : UIViewController {
    IBOutlet UIImageView *formBackgroundImage;
    IBOutlet UITextView *disclaimerText;
}

@property (nonatomic, retain) IBOutlet UIImageView *formBackgroundImage;
@property (nonatomic, retain) IBOutlet UITextView *disclaimerText;

@end
