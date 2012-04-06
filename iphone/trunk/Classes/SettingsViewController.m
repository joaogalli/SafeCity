//
//  SettingsViewController.m
//  SafeCity
//
//  Created by João Eduardo Galli on 5/4/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "SettingsViewController.h"
#import "ContatoDetailViewController.h"
#import "EmergencyCallSettingsViewController.h"
#import "EmergencyTextSettingsViewController.h"

@implementation SettingsViewController

- (void) initWithStyle:(UITableViewStyle)style {
	[super initWithStyle:style];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"Settings viewDidLoad");
    [super viewDidLoad];

	listOfItems = [[NSMutableArray alloc] init];
	
	NSArray *contatoArr = [NSArray arrayWithObjects:@"Contato 1", @"Contato 2", @"Contato 3", nil];
	NSArray *emergenciaArr = [NSArray arrayWithObjects:@"Configurar número", nil]; 
							  //@"Text Message", nil];

	NSDictionary *contatoDic = [NSDictionary dictionaryWithObject:contatoArr forKey:@"options"];
	NSDictionary *emergenciaDic = [NSDictionary dictionaryWithObject:emergenciaArr forKey:@"options"];

	[listOfItems addObject:contatoDic];
	[listOfItems addObject:emergenciaDic];
	
	self.navigationItem.title = @"Configuração";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {	
	return [listOfItems count];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	//Number of rows it should expect should be based on the section
	NSDictionary *dictionary = [listOfItems objectAtIndex:section];
	NSArray *array = [dictionary objectForKey:@"options"];
		
	return [array count];
}

//RootViewController.m
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

	switch (section) {
		case 0:
			return @"Contatos";
		case 1:
			return @"Emergência";
		default:
			return @"Erro";
	}
}

// Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Set up the cell...
	
	//First get the dictionary object
	NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
	NSArray *array = [dictionary objectForKey:@"options"];
	NSString *cellValue = [array objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cellValue;
    
    static NSString* nenhumContato = @"  Nenhum número configurado.";
    
    if (indexPath.section == 0) {
        NSArray *contato = [ContatoDetailViewController getContato:(indexPath.row + 1)];
	
        if (contato) {
            
            NSString* nome = (NSString *) [contato objectAtIndex:0];
            NSString* telefone = (NSString *) [contato objectAtIndex:1];
        
            if (nome && nome.length > 0 &&
                telefone && telefone.length > 0) {
                    
                cell.detailTextLabel.text = [NSString stringWithFormat: @"  %@: %@", [contato objectAtIndex:0], [contato objectAtIndex:1]];
                [contato release];
            } else {
                cell.detailTextLabel.text = nenhumContato;
            }
        } else {
            cell.detailTextLabel.text = nenhumContato;
        }
    } else if (indexPath.section == 1) {
        NSString* phoneNumber = [EmergencyCallSettingsViewController getPhoneNumber];
        
        if (phoneNumber) {
            cell.detailTextLabel.text = [NSString stringWithFormat: @"  %@", phoneNumber];
        } else {
            cell.detailTextLabel.text = nenhumContato;
        }
    }
    
	return cell;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
	NSArray *array = [dictionary objectForKey:@"options"];
	NSString *cellValue = [array objectAtIndex:indexPath.row];
	
	switch (indexPath.section) {
		case 0: {
            switch (indexPath.row) {
                case 0:
                case 1:
                case 2: {
                    ContatoDetailViewController *contatoView = [[ContatoDetailViewController alloc] initWithNumber:(indexPath.row + 1)];
                    contatoView.title = @"Contato";
                    [self.navigationController pushViewController:contatoView animated:YES];
                    [contatoView release];			
                }
                break;
            }
            
		}
			 break;
		case 1: {
			switch (indexPath.row) {
				case 0: {
					EmergencyCallSettingsViewController *emergencyView = [[EmergencyCallSettingsViewController alloc] init];
					[self.navigationController pushViewController:emergencyView animated:YES];
					[emergencyView release];					
				}
					break;
				//case 1: {
//					EmergencyTextSettingsViewController *text = [[EmergencyTextSettingsViewController alloc] init];
//					[self.navigationController pushViewController:text animated:YES];
//					[text release];
//				}
//					break;
			}
			
		}
		break;
	}
	
//	NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
//	NSArray *array = [dictionary objectForKey:@"options"];
//	NSString *cellValue = [array objectAtIndex:indexPath.row];
}

// Altura do header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 100.0f;
    } else {
        return 40.0f;
    }
}

// Componente do header.
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {

        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 310, 100)];
        label.numberOfLines = 4;
        label.text = @"Nesta seção, você carrega os contatos pessoais para suas ligações de emergência.";
        label.backgroundColor = [[UIColor alloc] initWithWhite:0.0f alpha:0.0f];
        
        UIView* v = [[UIView alloc] init];
        [v addSubview:label];
        
        return v;
    } else {
        return nil;
    }
}

// Altura do Footer
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	if (section == 1) {
		return 50.0f;
	} else {
		return 0.0f;
	}
}

// Componente do footer.
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	if (section == 1) {
		return [[[UIView alloc] init] autorelease];
	} else { return nil; }
}

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
	[listOfItems release];
    [super dealloc];
}


@end
