//
//  SafeCityViewController.h
//  SafeCity
//
//  Created by João Eduardo Galli on 3/11/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RequestCallback.h"
#import "EmergencyToolbar.h"

@interface SafeCityViewController : UIViewController <CLLocationManagerDelegate, RequestCallback> {
    IBOutlet UIImageView *loadingImage, *backgroundImage;
    IBOutlet UILabel* version;
    NSMutableArray *imageArray;
    
	EmergencyToolbar *emergencyToolBar;
	
	CLLocationManager *locationManager;
	NSMutableData *receivedData;
	
    BOOL localizando, splashOnScreen;
    int coordenadasCounter;
    NSString *latitude, *longitude;
    double horizontalAccuracy;
    NSTimer *locationTimeExpiration;
}

@property (nonatomic, retain) IBOutlet UILabel* version;
@property (nonatomic, retain) IBOutlet UIImageView *loadingImage, *backgroundImage;
@property (retain, nonatomic) CLLocationManager *locationManager;

- (void)initLoadingImage;

- (void)showSplash;
- (void)hideSplash;

- (void)startStandardUpdates;
- (void) searchForBairroWithLatitude: (NSString*) latitudeParam andLongitude: (NSString*) longitudeParam;
- (void) expirouTempoLocalizando;

- (IBAction) showMeuDestino: (id) sender;

@end