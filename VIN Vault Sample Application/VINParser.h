//
//  VINParser.h
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/14/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VINParser : NSObject

+ (instancetype)sharedManager;

-(void)parseData:(NSString *)JSONData context:(NSManagedObjectContext *)context
  withCompletion:(void (^)(BOOL success))completion;

@end
