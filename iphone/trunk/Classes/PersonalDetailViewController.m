//
//  PersonalDetailViewController.m
//  SafeCity
//
//  Created by João Eduardo Galli on 7/11/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "PersonalDetailViewController.h"
#import "ContatoDetailViewController.h"
#import "Preferences.h"

@implementation PersonalDetailViewController

@synthesize contato1Label, contato2Label, contato3Label;
@synthesize ligar1Button, ligar2Button, ligar3Button;
@synthesize contato1, contato2, contato3;
@synthesize formBackgroundImage;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Contatos";
	
    formBackgroundImage.image = [UIImage imageNamed: 
                                 [NSString stringWithFormat: @"background-tela-%@.png", [Preferences get: @"city"]]];

	[self populateContactLabel:contato1Label Button:ligar1Button fromNumber:1];
	[self populateContactLabel:contato2Label Button:ligar2Button fromNumber:2];
	[self populateContactLabel:contato3Label Button:ligar3Button fromNumber:3];
    
    contato1 = [ContatoDetailViewController getContato:1];
    contato2 = [ContatoDetailViewController getContato:2];
    contato3 = [ContatoDetailViewController getContato:3];
    
    if ([self isContatoEmpty:contato1] && [self isContatoEmpty:contato2] && [self isContatoEmpty:contato3]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Contatos" 
                                                            message:@"Acesse a opção Configurações para inserir os dados dos contatos para emergências." 
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    
}

- (BOOL)isContatoEmpty: (NSArray *) contato {
    if (contato) {
        NSString* nome = (NSString *) [contato objectAtIndex:0];
        NSString* telefone = (NSString *) [contato objectAtIndex:1];
        
        if (nome && nome.length > 0 &&
            telefone && telefone.length > 0) {
            return NO;
        }
    }
    
    return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)populateContactLabel: (UILabel*) label Button: (UIButton*) button fromNumber: (int) number {
	NSArray *array = [ContatoDetailViewController getContato:number];
	
	if (array) {
		NSString *title = (NSString*) [array objectAtIndex:0];
		
		if (title != nil && ![title isEqualToString:@""]) {
			label.text = [NSString stringWithFormat:@"Contato %i: %@", number, title];
			button.enabled = true;
			[button setTitle:[NSString stringWithFormat:@"Ligar para: %@", [array objectAtIndex:1] ] 
					forState:UIControlStateNormal];
		} else {
			label.text = @"Contato não cadastrado";
			[button setTitle:@"" forState:UIControlStateDisabled];
			button.enabled = false;
		}
	}
	
	[array release];
}

- (void)ligar:(id)sender {
	NSArray *array = nil;
	
	if (sender == ligar1Button) {
		array = contato1;
	} else if (sender == ligar2Button) {
		array = contato2;
	} else if (sender == ligar3Button) {
		array = contato3;
	}
	
	if (array) {
		NSLog(@"Ligando: %@", [array objectAtIndex:1]);
        
        @try {
            NSString *urlTelefone = [@"tel:" stringByAppendingString:[array objectAtIndex:1]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: urlTelefone]];
        }
        @catch (id e) {
            NSLog(@"%@", e);
        }
	}
	
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
