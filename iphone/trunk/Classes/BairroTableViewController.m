//
//  BairroTableViewController.m
//  SafeCity
//
//  Created by João Eduardo Galli on 5/5/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "BairroTableViewController.h"
#import "FindAllBairros.h"
#import "SafeCityViewController.h"
#import "BairroDetailViewController.h"

@implementation BairroTableViewController

@synthesize tableView;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Bairros";

	//[self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight]; 
	
	FindAllBairros *request = [[FindAllBairros alloc] init];
	[request sendRequests:self];
	
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Meu Destino" 
                                                        message:@"Escolha o bairro aonde se dirige, para conhecer a situação de segurança no lugar." 
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

- (void) onSuccess: (id) object fromRequest: (NSString*) request {
	if (request == [FindAllBairros REQUEST_ID]) {
		if (object) {
			NSMutableArray *unssortedContent = [object retain];
            
            NSSortDescriptor *nomeDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"nome"
                                         ascending:YES
                                          selector:@selector(localizedCaseInsensitiveCompare:)] autorelease];
            NSArray *descriptors = [NSArray arrayWithObjects:nomeDescriptor, nil];
            content = [[NSArray alloc] initWithArray: [unssortedContent sortedArrayUsingDescriptors:descriptors]];
            
            //[nomeDescriptor sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            
			[tableView reloadData];
		} else {
			content = nil;
			[content release];
		}
	}
}

- (void) onFailure: (NSString*) errorMessage fromRequest: (NSString*) request {
	NSLog(@"Mensagem de erro: %@", errorMessage);
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [content count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSDictionary *dic = (NSDictionary*) [content objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [dic objectForKey:@"nome"];
	
	//[dic release];
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *bairro = (NSDictionary*) [content objectAtIndex:indexPath.row];
	
    BairroDetailViewController *bdv = [[BairroDetailViewController alloc] init];
    [bdv setBairro: bairro];
    [[self navigationController] pushViewController:bdv animated:YES];
    [bdv release];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
	[content dealloc];
    //[tableView dealloc]; Ocorre EXC_BAD_ACCESS
    [super dealloc];
}


@end

