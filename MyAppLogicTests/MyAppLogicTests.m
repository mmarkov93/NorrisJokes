//
//  MyAppLogicTests.m
//  MyAppLogicTests
//
//  Created by Rali on 12/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MyAppLogicTests.h"
#import "DatabaseService.h"
#import "Quote.h"

@implementation MyAppLogicTests
    


- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testDatabaseConnect
{
    DatabaseService *database = [[DatabaseService alloc] init];
    BOOL isConnected = [database connect];
    
    STAssertTrue(isConnected, @"Database is not connected");
    [database close];
}

-(void)testDatabaseGetQuotes
{
    DatabaseService *dbManager = [[DatabaseService alloc] init];
    BOOL isConnected = [dbManager connect];
    
    NSArray *quotes = [dbManager getQuotes];
    NSMutableArray *expectedQuotes = [[NSMutableArray alloc] init];
    
    if (isConnected) {
        const char *sqlStatement = "select * from quotes";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(dbManager.database , sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                Quote *quote = [[Quote alloc] init];
				quote.key = sqlite3_column_int(compiledStatement, 1);
				quote.message = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				quote.dateAdded = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                quote.author = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                quote.category = sqlite3_column_int(compiledStatement, 5);
                quote.rating = sqlite3_column_double(compiledStatement, 6);
                quote.votes = sqlite3_column_int(compiledStatement, 7);
                quote.userVote = sqlite3_column_double(compiledStatement, 8);
				                
				// Add the animal object to the animals Array
				[expectedQuotes addObject:quote];
                
			}
		}
    }
    [dbManager close];
    NSMutableArray *intermediate = [NSMutableArray arrayWithArray:expectedQuotes];
    [intermediate removeObjectsInArray:quotes];
    NSUInteger diff = 0;

    
    STAssertEquals(diff,[intermediate count] ,@"Method getQuotes is not working properly");
    
}

-(void)testDatabasePutQuotes{
    DatabaseService *dbManager = [[DatabaseService alloc] init];
    BOOL isConnected = [dbManager connect];
    Quote *quote = [[Quote alloc]init];
    quote.key = 1;
    NSArray *arrayOne = [NSArray arrayWithObject:quote];
    
    
    [dbManager putQuotes:arrayOne];
    NSMutableArray *expectedQuotes = [[NSMutableArray alloc] init];
    
    if (isConnected) {
        const char *sqlStatement = "select * from quotes";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(dbManager.database , sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                Quote *quote = [[Quote alloc] init];
				quote.key = sqlite3_column_int(compiledStatement, 1);
				quote.message = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				quote.dateAdded = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                quote.author = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                quote.category = sqlite3_column_int(compiledStatement, 5);
                quote.rating = sqlite3_column_double(compiledStatement, 6);
                quote.votes = sqlite3_column_int(compiledStatement, 7);
                quote.userVote = sqlite3_column_double(compiledStatement, 8);
                
				// Add the animal object to the animals Array
				[expectedQuotes addObject:quote];
                
			}
		}

    }
    Quote *tmp = [expectedQuotes lastObject];
    
    STAssertEquals(tmp.key, quote.key, @"Method putQuotes is not working properly");
    
}


@end
