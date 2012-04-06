//
//  SafeCityViewController.m
//  SafeCity
//
//  Created by João Eduardo Galli on 3/11/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "SafeCityViewController.h"
#import "BairroDetailViewController.h"
#import "FindBairroByLocation.h"
#import "Bairro.h"
#import "RequestCallback.h"
#import "EmergencyToolbar.h"
#import "FindAllBairros.h"
#import "DicaDetailViewController.h"
#import "EmergencyCallSettingsViewController.h"
#import "BairroTableViewController.h"
#import "AlertaEspecialDetailViewController.h"
#import "Preferences.h"

#define IMAGE_COUNT       6
#define MAX_COORDINATES   5
#define TIMEOUT_LENGTH    8

@implementation SafeCityViewController

@synthesize version, loadingImage, backgroundImage;

- (void) awakeFromNib {
	self.title = @"Localizar";
}

- (void) viewDidLoad {
    NSLog(@"SafeCityViewController.viewDidLoad");
    
    [self initLoadingImage];
    
    backgroundImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"localizando-%@.png", 
                                                 [Preferences get: @"city"]]];
    
    version.text = [Preferences get:@"CFBundleShortVersionString"];
    
    emergencyToolBar = [EmergencyToolbar sharedInstanceWithParent:self];
    [self.navigationController.view addSubview:emergencyToolBar];
}

- (void)viewWillAppear:(BOOL)animated {
	//[super viewWillAppear:animated];
	NSLog(@"SafeCityViewController.viewWillAppear");
    
    [loadingImage startAnimating];
    
    emergencyToolBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    
    [self startStandardUpdates];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"SafeCityViewController.viewWillDisappear");
//    localizando = NO;
    self.navigationController.navigationBarHidden = NO;
    emergencyToolBar.hidden = NO;
    
    [loadingImage stopAnimating];
}

-(void)showSplash
{
    splashOnScreen = YES;
    NSLog(@"SafeCityViewController.showSplash");
    
	UIViewController *modalViewController = [[UIViewController alloc] init];
	
	UIView *vis = [[UIView alloc] initWithFrame: CGRectMake(0,0, 320, 480)];
	[vis setBackgroundColor:[UIColor whiteColor]];
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	imageView.image = [UIImage imageNamed:@"default.png"];
	
	[vis addSubview:imageView];
	
	modalViewController.view = vis;
    
	[self presentModalViewController:modalViewController animated:NO];
	[self performSelector:@selector(hideSplash) withObject:nil afterDelay:1.0];
	
	[vis release];
}

//hide splash screen
- (void)hideSplash{
	[[self modalViewController] dismissModalViewControllerAnimated:NO];
    splashOnScreen = NO;
    //[self showLoading];
}

- (void)initLoadingImage {
    imageArray = [[NSMutableArray alloc] initWithCapacity:IMAGE_COUNT];
    
    // Build array of images, cycling through image names
    for (int i = 1; i <= IMAGE_COUNT; i++)
        [imageArray addObject:[UIImage imageNamed:
                               [NSString stringWithFormat:@"loading-%d.png", i]]];
    
    loadingImage.animationImages = [NSArray arrayWithArray:imageArray];
    loadingImage.animationDuration = 1.0;
    loadingImage.animationRepeatCount = 0;
}

- (void)startStandardUpdates
{
    NSLog(@"SafeCityViewController.startStandardUpdates");
    
    localizando = YES;
    latitude = nil;
    longitude = nil;
    horizontalAccuracy = 999999;
    coordenadasCounter = 0;
    
    if (!locationManager) {
        locationManager = [[CLLocationManager alloc] init];
	
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
	
        // Set a movement threshold for new events.
        locationManager.distanceFilter = kCLDistanceFilterNone;
    }

    [locationManager startUpdatingLocation];

    locationTimeExpiration = [NSTimer scheduledTimerWithTimeInterval:TIMEOUT_LENGTH 
                                     target:self selector:@selector(expirouTempoLocalizando) 
                                   userInfo:nil repeats:NO];
}

- (void) locationManager:(CLLocationManager *)manager 
	 didUpdateToLocation:(CLLocation *)newLocation 
			fromLocation:(CLLocation *)oldLocation
{
   NSLog(@"SafeCityViewController.locationManager, lat: %+.6f , lon: %+.6f e precisão: %f\n",
		  newLocation.coordinate.latitude,
		  newLocation.coordinate.longitude,
          newLocation.horizontalAccuracy);
    
    coordenadasCounter++;
    NSLog(@"Coordenadas %i", coordenadasCounter);

    if (newLocation.horizontalAccuracy <= horizontalAccuracy) {
        NSLog(@"Coordenada com Accuracy melhor atribuida: %+.1f < %+.1f.", newLocation.horizontalAccuracy, horizontalAccuracy);
        horizontalAccuracy = newLocation.horizontalAccuracy;

        latitude = [[NSString stringWithFormat:@"%f", newLocation.coordinate.latitude] retain];
        longitude = [[NSString stringWithFormat:@"%f", newLocation.coordinate.longitude] retain];
    }
    
    if (coordenadasCounter >= MAX_COORDINATES) {
        NSLog(@"Máximo de coordenadas recebidas.");
        [locationTimeExpiration invalidate];
        [locationManager stopUpdatingLocation];
        
        if (localizando) {
            localizando = NO;
            [self searchForBairroWithLatitude:latitude andLongitude:longitude];
        }
    } else {
        NSLog(@"opa");
    }
}

- (void) expirouTempoLocalizando {
    NSLog(@"SafeCityViewController.expirouTempoLocalizando");
    if (localizando) {
        if (latitude && longitude) {
            //[locationTimeExpiration invalidate];
            [locationManager stopUpdatingLocation];
            localizando = NO;
            
            [self searchForBairroWithLatitude:latitude andLongitude:longitude];
        } else {
            // TODO fazer algo, se expirou e não tem localizacao gravada.
        }
    }
}

/* Procura pelo bairro no servidor */
- (void) searchForBairroWithLatitude: (NSString*) latitudeParam andLongitude: (NSString*) longitudeParam {
    NSLog(@"SafeCityViewController.searchBairroWithLatitudeandLongitude");
    FindBairroByLocation* fb = [[FindBairroByLocation alloc] init];
    [fb sendRequests: self withLatitude: latitudeParam andLongitude: longitudeParam];
}

- (void) onSuccess: (id) object fromRequest: (NSString*) request {
    NSLog(@"SafeCityViewController.onSuccess");
    //localizando && 
	if (request == [FindBairroByLocation REQUEST_ID]) {
		//localizando = NO;
        if (object) {
            BairroDetailViewController *bdv = [[BairroDetailViewController alloc] init];
            [bdv setBairro: [object retain]];
            [[self navigationController] pushViewController:bdv animated:YES];
            [bdv release];
		} else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Bairro não encontrado." 
                                            message:@"Não foi encontrado bairro para a sua localização." 
                                            delegate:self cancelButtonTitle:@"Listar todos os bairros" 
                                            otherButtonTitles:nil];
            [alert show];
            [alert release];
		}
	}
}

- (void) onFailure: (NSString*) errorMessage fromRequest: (NSString*) request {
    NSLog(@"SafeCityViewController.onFailure");
    
    localizando = NO;
    
	//NSLog(@"Mensagem de erro: %@", errorMessage);
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Problemas de conexão" message:errorMessage 
												   delegate:self cancelButtonTitle:@"Tentar novamente." 
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"SafeCityViewController.alertViewclickedButtonAtIndex");
    
	if (alertView.title == @"Problemas de conexão") {
        [self startStandardUpdates];
	}
	if (alertView.title == @"Bairro não encontrado.") {
		//[self hideLoading];
        [self showMeuDestino:nil];
	}
}

- (IBAction) showMeuDestino: (id) sender {
	NSLog(@"showMeuDestino");
	BairroTableViewController *bairrosView = [[BairroTableViewController alloc] init];
	[[self navigationController] pushViewController:bairrosView animated:YES];
	[bairrosView release];
}

- (void)didReceiveMemoryWarning {
    NSLog(@"SafeCityViewController.didReceiveMemoryWarning");
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	NSLog(@"SafeCityViewController.viewDidUnload");
}

- (void)dealloc {
	NSLog(@"SafeCityViewController dealloc.");
	[emergencyToolBar release];
    [super dealloc];
}

@end
