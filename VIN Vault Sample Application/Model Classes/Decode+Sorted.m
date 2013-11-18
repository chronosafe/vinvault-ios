//
//  Decode+Sorted.m
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/17/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import "Decode+Sorted.h"

@implementation Decode (Sorted)

-(NSArray *)sortedVehicles {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"trim" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    return [[self.vehicles allObjects] sortedArrayUsingDescriptors:sortDescriptors];
}

@end
