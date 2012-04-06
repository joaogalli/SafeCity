//
//  EmergencyToolbar.m
//  SafeCity
//
//  Created by João Eduardo Galli on 5/4/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "EmergencyToolbar.h"
#import "SettingsViewController.h"
#import "EmergencyCallSettingsViewController.h"
#import "EmergencyTextSettingsViewController.h"
#import "PoliciaDetailViewController.h"
#import "HospitalDetailViewController.h"
#import "PersonalDetailViewController.h"
#import "DisclaimerViewController.h"

@implementation EmergencyToolbar

@synthesize bairro;

static EmergencyToolbar *sharedInstance = nil;

+ (id)sharedInstanceWithParent:(UIViewController*) parent {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] initWithParent:parent];
    }
    
    return sharedInstance;
}

// Get the shared instance and create it if necessary.
+ (EmergencyToolbar *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedInstance] retain];
}

- (void)setDictionaryBairro:(NSDictionary*)bairroDic {
	self.bairro = bairroDic;
}

- (EmergencyToolbar*) initWithParent: (UIViewController*) parent {
	[super init];
	
	self.delegate = self;
	
	viewController = parent;
	
	//self.barStyle = UIBarStyleDefault;
	[self sizeToFit];
	
	//Caclulate the height of the toolbar
	CGFloat toolbarHeight = [self frame].size.height;
	
	//Get the bounds of the parent view
	CGRect rootViewBounds = parent.parentViewController.view.bounds;
	
	//Get the height of the parent view.
	CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds);
	
	//Get the width of the parent view,
	CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds);
	
	//Create a rectangle for the toolbar
	CGRect rectArea = CGRectMake(0, rootViewHeight - toolbarHeight, rootViewWidth, toolbarHeight);
	
	//Reposition and resize the receiver
	[self setFrame:rectArea];
	
	UITabBarItem *disclaimerButton = [[UITabBarItem alloc] initWithTitle:@"Aviso Legal" 
																   image:[UIImage imageNamed:@"disclaimer.png"]
																	 tag:0];
	
	UITabBarItem *configuracoesButton = [[UITabBarItem alloc] initWithTitle:@"Configurações" 
																	  image:[UIImage imageNamed:@"configuracoes.png"]
																		tag:1];
	
	UITabBarItem *policiaButton = [[UITabBarItem alloc] initWithTitle:@"Policia" 
																image:[UIImage imageNamed:@"policia.png"]
																  tag:2];
	
	UITabBarItem *hospitalButton = [[UITabBarItem alloc] initWithTitle:@"Hospital" 
																 image:[UIImage imageNamed:@"hospital.png"]
																   tag:3];
	
	UITabBarItem *personalButton = [[UITabBarItem alloc] initWithTitle:@"Contatos" 
																 image:[UIImage imageNamed:@"personal.png"]
																   tag:4];
	
	[self setItems:[NSArray 
					arrayWithObjects:disclaimerButton, configuracoesButton, policiaButton, hospitalButton, personalButton, nil]
		  animated: TRUE];
	
	return self;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
	//NSLog(@"UITabBarItem selected: %@", item.tag);
	
	switch (item.tag) {
		case 0:
			[self viewDisclaimer];
			break;
		case 1:
			[self viewConfiguration];
			break;
		case 2:
			[self viewPolicia];
			break;
		case 3:
			[self viewHospital];
			break;
		case 4:
			[self viewPersonal];
		default:
			break;
	}
}

- (void) viewDisclaimer {
    DisclaimerViewController *disclaimer = [[DisclaimerViewController alloc] init];
    [[viewController navigationController] pushViewController:disclaimer animated:YES];
    [disclaimer release];
}

- (void) viewConfiguration {
	SettingsViewController *settings = [[SettingsViewController alloc] initWithStyle: UITableViewStyleGrouped];
	[[viewController navigationController] pushViewController:settings animated:YES];
	[settings release];
}

- (void) viewPolicia {
	PoliciaDetailViewController *policiaView = [[PoliciaDetailViewController alloc] initWithBairro:bairro];
	[[viewController navigationController] pushViewController:policiaView animated:YES];
	[policiaView release];
}

- (void) viewHospital {
	HospitalDetailViewController *hospitalView = [[HospitalDetailViewController alloc] initWithBairro:bairro];
	[[viewController navigationController] pushViewController:hospitalView animated:YES];
	[hospitalView release];
}

-(void) viewPersonal {
	PersonalDetailViewController *personalView = [[PersonalDetailViewController alloc] init];
	[[viewController navigationController] pushViewController:personalView animated:YES];
	[personalView release];	
}


//- (void) sendEmergencyText {
//	NSDictionary *dic = [EmergencyTextSettingsViewController getTextInfo];
//	
//	Class smsClass = (NSClassFromString(@"MFMessageComposeViewController"));
//	if (smsClass != nil && [MFMessageComposeViewController canSendText])
//	{
//		MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
//		controller.delegate = self;
//		controller.messageComposeDelegate = self;
//		controller.body = [dic objectForKey:@"mensagem"];
//		controller.recipients = [NSArray arrayWithObjects:[dic objectForKey:@"telefone"], nil];
//		controller.messageComposeDelegate = self;
//		[self presentModalViewController:controller animated:YES];
//	} else {
//		NSString *sms = [[[NSString alloc] initWithString:@"sms://"] stringByAppendingFormat: [dic objectForKey:@"telefone"]];
//		[[UIApplication sharedApplication] openURL: [NSURL URLWithString: sms]];
//	}
//}
//
//- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
//{
//	switch (result) {
//		case MessageComposeResultCancelled:
//			NSLog(@"Cancelled");
//			break;
//		case MessageComposeResultFailed:
//			NSLog(@"Failed");
//			/*
//			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MyApp" message:@"Unknown Error"
//														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//			[alert show];
//			[alert release];
//			*/
//			break;
//		case MessageComposeResultSent:
//			NSLog(@"Sent");
//			break;
//		default:
//			break;
//	}
//	
//	[self dismissModalViewControllerAnimated:YES];
//}

- (void)dismissModalViewControllerAnimated:(BOOL)animated {
}

- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated {
	
}

@end
