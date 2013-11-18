//
//  ItemViewController.h
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/14/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ItemViewController : UITableViewController
@property (strong, nonatomic) Vehicle *vehicle;

@end
