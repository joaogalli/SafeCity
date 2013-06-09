//
//  BairroDetailViewController.m
//  SafeCity
//
//  Created by João Eduardo Galli on 12/9/11.
//  Copyright (c) 2011 Sovi. All rights reserved.
//

#import "BairroDetailViewController.h"
#import "DicaDetailViewController.h"
#import "EmergencyCallSettingsViewController.h"
#import "AlertaEspecialDetailViewController.h"
#import "BairroTableViewController.h"
#import "Preferences.h"
#import "EmergencyToolbar.h"

@implementation BairroDetailViewController

@synthesize locationBairro;
@synthesize nomeLabel, delito1Label, delito2Label, formBackgroundImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) showDicas: (id) sender {
	DicaDetailViewController *dicasView = [[DicaDetailViewController alloc] initWithBairro: locationBairro];
	[[self navigationController] pushViewController:dicasView animated:YES];
	[dicasView release];
}

- (IBAction) showEmergencia: (id) sender {
    
	NSString *number = [EmergencyCallSettingsViewController getPhoneNumber];
	
	if (number) {
		@try {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString: [@"tel://" stringByAppendingFormat: number]]];
		}
		@catch (NSException * e) {
			NSLog(@"Exception on call: %@", e);
			UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Problemas para fazer ligação" 
															message:@"Não foi possível fazer a ligação para o número desejado." 
														   delegate:self cancelButtonTitle:@"Fechar" 
												  otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}
}

- (IBAction) showAlertaEspecial: (id) sender {
	NSLog(@"showAlertaEspecial");
	AlertaEspecialDetailViewController *controller = [[AlertaEspecialDetailViewController alloc] initWithBairro:locationBairro];
	[[self navigationController] pushViewController:controller animated:YES];
	[controller release];
}

- (IBAction) showMeuDestino: (id) sender {
	NSLog(@"showMeuDestino");
	BairroTableViewController *bairrosView = [[BairroTableViewController alloc] init];
	[[self navigationController] pushViewController:bairrosView animated:YES];
	[bairrosView release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"SafeCity";
    
    self.navigationItem.rightBarButtonItem = 
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                                  target:self action:@selector(searchMyLocation)];
    
    NSString *backgroundImagePath = [NSString stringWithFormat: @"background-tela-%@.png", [Preferences get: @"city"]];
    NSLog(@"Imagem: %@", backgroundImagePath);
    
    // Set Form Background Image
    UIImage *image = [UIImage imageNamed: backgroundImagePath];
    formBackgroundImage.image = image;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self populateForm];
}

-(void) setBairro: (NSDictionary*) bairro {
    NSLog(@"SafeCityViewController.setBairro:");
	locationBairro = bairro;
}

/* Retorna a tela de Localizando */
- (void) searchMyLocation {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) populateForm {
    NSLog(@"SafeCityViewController.populateForm");
    
    NSLog(@"EmergencyToolbar: %@", [EmergencyToolbar sharedInstance]);
    [[EmergencyToolbar sharedInstance] setDictionaryBairro:locationBairro];
    
	[nomeLabel setText:[locationBairro objectForKey:@"nome"]];
	[delito1Label setText:[locationBairro objectForKey:@"delito1"]];
	[delito2Label setText:[locationBairro objectForKey:@"delito2"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [locationBairro release];
    [nomeLabel release];
    [delito1Label release];
    [delito2Label release];
    
    [super dealloc];
}

@end
