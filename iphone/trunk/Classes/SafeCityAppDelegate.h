//
//  SafeCityAppDelegate.h
//  SafeCity
//
//  Created by João Eduardo Galli on 3/11/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SafeCityViewController;

@interface SafeCityAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

