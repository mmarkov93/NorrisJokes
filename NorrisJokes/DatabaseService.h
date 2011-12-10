//
//  Database.h
//  NorrisJokes
//
//  Created by Martin Markov on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define kDatabaseName    "database.sql"


@interface DatabaseService : NSObject {
    sqlite3 *database;
    
}

@property sqlite3 *database;

-(BOOL)connect;
-(NSArray*)getQuotes;
-(void)putQuotes:(NSArray*) quotes;
-(void)close;


@end
