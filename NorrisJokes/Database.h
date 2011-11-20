//
//  Database.h
//  NorrisJokes
//
//  Created by Martin Markov on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define databaseName    "database"

@interface Database : NSObject

-(void) connectDatabase;
-(NSArray*)getQuotesFromDataBase;
-(void)putQuotesIntoDataBase:(NSArray*) quotes;
-(void)closeDatabase;


@end
