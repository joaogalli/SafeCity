//
//  EmergencyToolbar.h
//  SafeCity
//
//  Created by João Eduardo Galli on 5/4/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface EmergencyToolbar : UITabBar <UITabBarDelegate, UINavigationControllerDelegate> {
	UIViewController *viewController;
	NSMutableData *webData;
	NSDictionary *bairro;
}

@property (nonatomic, retain) NSDictionary *bairro;

+ (id)sharedInstance;
+ (id)sharedInstanceWithParent:(UIViewController*) parent;

- (EmergencyToolbar*) initWithParent: (UIViewController*) parent;
- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated;
- (void)dismissModalViewControllerAnimated:(BOOL)animated;
- (void)setDictionaryBairro:(NSDictionary*)bairroDic;

@end
