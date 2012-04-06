//
//  BairroTableViewController.h
//  SafeCity
//
//  Created by João Eduardo Galli on 5/5/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestCallback.h"

@interface BairroTableViewController : UIViewController <RequestCallback, UITableViewDelegate, UITableViewDataSource> {
	NSArray *content;
	IBOutlet UITableView *tableView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
