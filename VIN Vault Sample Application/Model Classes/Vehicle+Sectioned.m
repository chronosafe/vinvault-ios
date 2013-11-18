//
//  Vehicle+Sectioned.m
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/14/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import "Vehicle+Sectioned.h"
#import "Vehicle.h"
#import "Item.h"

@implementation Vehicle (Sectioned)
// Return an array of dictionaries, each dictionary key is a section that contains an array of items
-(NSArray *)groupNames {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (Item *item in [self items]) {
        if (![array containsObject:item.group]) {
            [array addObject:item.group];
        }
    }
    // sort the groups by name
    NSArray *sorted = [array sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    return sorted;
}

-(NSArray *)itemsForGroup:(NSString *)name {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (Item *item in [self items]) {
        if ([item.group isEqualToString:name]) {
            [array addObject:item];
        }
    }
    // Sort the items by category
    NSSortDescriptor *sortBy = [[NSSortDescriptor alloc] initWithKey:@"category" ascending:YES];
    NSArray *sorted = [array sortedArrayUsingDescriptors:@[sortBy]];
    return sorted;
}

@end
