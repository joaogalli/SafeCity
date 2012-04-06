//
//  BairroDetailViewController.m
//  SafeCity
//
//  Created by João Eduardo Galli on 3/11/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "BairroDetailViewController.h"
#import "Bairro.h"
#import "FindDelitosByBairro.h"
#import "FindDadosUteisByBairro.h"

@implementation BairroDetailViewController

@synthesize nomeBairroLabel, segmentedControl, tableView;
@synthesize detailTextView, detailTitleLabel, detailView;
@synthesize delitos, showDelitos, showTable;

- (void) viewDidLoad
{
}

- (IBAction) segmentedChanged
{
	switch (segmentedControl.selectedSegmentIndex) {
		case 0:
			[self updateDelitos];
			break;
		case 1:
			[self updateDadosUteis];
			break;
	}
}

// Botao de voltar
- (IBAction) dismissScreen: (id) sender
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void) setBairro: (NSDictionary*) bairroDic
{
	bairro = [bairroDic retain];
	
	nomeBairroLabel.text = [bairroDic objectForKey:@"nome"];
	
	[self updateDelitos];
}

- (void) updateDelitos
{
	NSNumber* bairroId = [bairro objectForKey:@"id"];

	if (delitos && [delitos count] > 0) {
		showDelitos = YES;
		[self updateTable];
	} else {
		// Busca os delitos
		FindDelitosByBairro* fab = [[FindDelitosByBairro alloc] init];
		[fab sendRequests:self withBairroId:bairroId];	
	}
}

- (void) updateDadosUteis
{
	NSNumber* bairroId = [bairro objectForKey:@"id"];

	if (dadosUteis && [dadosUteis count] > 0) {
		showDelitos = NO;
		[self updateTable];
	} else {
		// Busca os delitos
		FindDadosUteisByBairro* fab = [[FindDadosUteisByBairro alloc] init];
		[fab sendRequests:self withBairroId:bairroId];	
	}
}

- (void) onSuccess: (NSObject*) object fromRequest: (NSString*) request {
	if (object) {
		if (request == [FindDelitosByBairro REQUEST_ID]) {
			delitos = [object retain];
			showDelitos = YES;
			[self updateTable];

		} else if (request == [FindDadosUteisByBairro REQUEST_ID]) {
			dadosUteis = [object retain];
			showDelitos = NO;
			[self updateTable];
		}
	}
}

- (void) updateTable
{
	[tableView reloadData];
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (showDelitos) {
		NSDictionary* delito = [delitos objectAtIndex:indexPath.row];
		[self showDelitoDetails:delito];
	} else {
		NSDictionary* dados = [dadosUteis objectAtIndex:indexPath.row];
		[self showDadosUteisDetails:dados];
	}
}

- (void) showDelitoDetails: (NSDictionary*) delito
{
	detailTitleLabel.text = [delito objectForKey:@"nome"];
	
	NSString* resourcePath = [NSString stringWithFormat:@"%@\nRecomendação: %@", 
							  [delito objectForKey:@"descricao"],
							  [delito objectForKey:@"recomendacao"]];
	
	detailTextView.text = resourcePath;
	
	tableView.hidden = YES;
	detailView.hidden = NO;
}

- (void) showDadosUteisDetails: (NSDictionary*) dados
{
	detailTitleLabel.text = [dados objectForKey:@"nome"];
	
	NSString* resourcePath = [NSString stringWithFormat:@"%@\nEndereço: %@\nTelefone: %@", 
							  [dados objectForKey:@"descricao"],
							  [dados objectForKey:@"endereco"],
							  [dados objectForKey:@"telefone"]];
	
	detailTextView.text = resourcePath;
	
	tableView.hidden = YES;
	detailView.hidden = NO;
}

- (IBAction) dismissDetailView: (id) sender
{
	tableView.hidden = NO;
	detailView.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableViews
 numberOfRowsInSection:(NSInteger)section
{
	if (showDelitos && delitos) {
		return [delitos count];
	} else if (!showDelitos && dadosUteis) {
		return [dadosUteis count];
	} else {
		return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableViews
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	UITableViewCell *cell = [tableViews
							 dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:SimpleTableIdentifier] autorelease];
	}
	
	NSUInteger row = [indexPath row];
	
	NSString *text = nil;
	
	if (showDelitos) {
		NSDictionary *delito = [delitos objectAtIndex:row];
		text = [delito objectForKey:@"nome"];
	} else {
		NSDictionary *dados = [dadosUteis objectAtIndex:row];
		text = [dados objectForKey:@"nome"];
	}
	
	cell.textLabel.text = text;
	
	return cell;
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
	[dadosUteis release];
	[delitos release];
	[nomeBairroLabel release];
    [super dealloc];
}


@end
