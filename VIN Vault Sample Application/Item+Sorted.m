//
//  Item+Sorted.m
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/17/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import "Item+Sorted.h"

@implementation Item (Sorted)

-(NSArray *)sortedOptions {
    NSSortDescriptor *sortBy = [[NSSortDescriptor alloc] initWithKey:@"value" ascending:YES];
    NSArray *sorted = [[self.options allObjects] sortedArrayUsingDescriptors:@[sortBy]];
    return sorted;
}
@end
