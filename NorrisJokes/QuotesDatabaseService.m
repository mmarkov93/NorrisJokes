//
//  QuotesDatabaseService.m
//  NorrisJokes
//
//  Created by Rali on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuotesDatabaseService.h"
#import "Quote.h"
@implementation QuotesDatabaseService
@synthesize _database;
- (id)init {
    NSString *documentsDirectory = [[NSString alloc]init];
    if ((self = [super init])) {
        BOOL success;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDirectory = [paths objectAtIndex:0];
       // NSLog(@"RAAAAAA:%@",documentsDirectory);
        NSString *writableDBPath = @"/Users/Rali/Documents/IphoneProjects/NorrisJokes";
       // NSLog(@"RALICA:%@",writableDBPath);
        [writableDBPath stringByExpandingTildeInPath];
        success = [fileManager fileExistsAtPath:writableDBPath];
        if (!success) {
            // The writable database does not exist, so copy the default to the appropriate location.
           NSString *defaultDBPath = @"/Users/Rali/Documents/IphoneProjects/NorrisJokes/NorrisJokes/data.sqlite";
           // NSLog(@"RALICA2:%@",defaultDBPath);
           // [defaultDBPath stringByExpandingTildeInPath];
            success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
            if (!success) {
                NSAssert1(0, @"Failed to create writable database file with message ‘%@’.", [error localizedDescription]);
            }
        }
        
    }
    NSString *path = @"/Users/Rali/Documents/IphoneProjects/NorrisJokes/NorrisJokes/data.sqlite";
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &_database) == SQLITE_OK) {
        
        NSLog(@"Database Successfully Opened");
        
    } else {
        NSLog(@"Error in opening database");
    }
    
    return self;
}

//-(void)getMostViewed{
//    //NSArray *arr = [[NSArray alloc]init];
//    sqlite3_stmt *statement = nil;
//    const char *sql= "select * from Quotes";
//    if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL)) {
//        NSAssert1(0, @"Error preparing statement", sqlite3_errmsg(_database));
//    } else {
//
//        while (sqlite3_step(statement)==SQLITE_ROW) {
//            int temp = atoi((char*)sqlite3_column_text(statement, 0));
//            NSString *tempstr = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
//            NSString *str2 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
//            //[str2 stringByAppendingString:@" +0600"];
//            NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
//            [dateFormater setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
//            NSDate *tempdate = [dateFormater dateFromString:str2];
//            NSString *str = [[NSString alloc]initWithString:@"abv"];
//            [str stringByAppendingString:@"%"];
//             NSString *sql =[[NSString alloc]initWithFormat: @"select * from Quotes where message like %%%@",str];
//            [sql stringByAppendingString:@"abv%"];
//            NSLog(@"MESSAGE:%@",sql);
//        }
//    }
//}

//-(NSArray*)searchByString:(NSString *)str{
//    NSMutableArray *arr = [[NSMutableArray alloc]init];
//    sqlite3_stmt *statement = nil;
//     NSString *sql =[[NSString alloc]initWithFormat: @"select * from Quotes"];
//    //NSLog(@"%@",sql);
//    //const char *sql= "select * from Quotes where message like @%",str ;
//    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, NULL)) {
//        NSAssert1(0, @"Error preparing statement", sqlite3_errmsg(_database));
//    } else {
//        while (sqlite3_step(statement)==SQLITE_ROW) {
//            NSString *str2 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
//            //NSLog(@"RAAAAA:%@"[[str2 rangeOfString:str].location ]);
//            if ([[str2 lowercaseString] rangeOfString: [str lowercaseString]].location != NSNotFound) {
//                int temp = atoi((char*)sqlite3_column_text(statement, 0));
//                NSString *tempstr = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
//                
//                NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
//                [dateFormater setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
//                NSDate *tempdateCr = [dateFormater dateFromString:str2];
//                NSString *str3 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
//                NSDate *tempdateMo = [dateFormater dateFromString:str3];
//                int tempPV = atoi((char*)sqlite3_column_text(statement, 4));
//                int tempMV = atoi((char*)sqlite3_column_text(statement, 5));
//                Quote *quote1 = [[Quote alloc]initWithID:temp Message:tempstr DateAdded:tempdateCr DateModified:tempdateMo PlusVotes:tempPV MinusVotes:tempMV];
//                [arr addObject:quote1];
//            }
//        }
//    }
//    sqlite3_finalize(statement);
//    NSArray *temp = [[NSArray alloc]initWithArray:arr];
//    return temp;
//}

-(NSArray*)getTopQuotes{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    sqlite3_stmt *statement = nil;
    const char *sql= "select * from Quotes order by PlusVotes DESC limit 0, 50";
    if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL)) {
        NSAssert1(0, @"Error preparing statement", sqlite3_errmsg(_database));
    } else {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSString *str2 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
            //NSLog(@"RAAAAA:%@"[[str2 rangeOfString:str].location ]);
            
                int temp = atoi((char*)sqlite3_column_text(statement, 0));
                NSString *tempstr = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                
                NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
                [dateFormater setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
                NSDate *tempdateCr = [dateFormater dateFromString:str2];
                NSString *str3 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                NSDate *tempdateMo = [dateFormater dateFromString:str3];
                int tempPV = atoi((char*)sqlite3_column_text(statement, 4));
                int tempMV = atoi((char*)sqlite3_column_text(statement, 5));
            NSLog(@"PLUSVOTES:%d",tempPV);
                Quote *quote1 = [[Quote alloc]initWithID:temp Message:tempstr DateAdded:tempdateCr DateModified:tempdateMo PlusVotes:tempPV MinusVotes:tempMV];
                [arr addObject:quote1];
            
        }
    }
    sqlite3_finalize(statement);
    NSArray *temp = [[NSArray alloc]initWithArray:arr];
    return temp;
}

-(NSArray*)getRecentlyAdded{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    sqlite3_stmt *statement = nil;
    const char *sql= "select * from Quotes order by DateAdded DESC limit 0, 50";
    if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL)) {
        NSAssert1(0, @"Error preparing statement", sqlite3_errmsg(_database));
    } else {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSString *str2 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
            //NSLog(@"RAAAAA:%@"[[str2 rangeOfString:str].location ]);
            
            int temp = atoi((char*)sqlite3_column_text(statement, 0));
            NSString *tempstr = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
            
            NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
            [dateFormater setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
            NSDate *tempdateCr = [dateFormater dateFromString:str2];
            NSString *str3 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
            NSDate *tempdateMo = [dateFormater dateFromString:str3];
            int tempPV = atoi((char*)sqlite3_column_text(statement, 4));
            int tempMV = atoi((char*)sqlite3_column_text(statement, 5));
            NSLog(@"PLUSVOTES:%@",tempdateCr);
            Quote *quote1 = [[Quote alloc]initWithID:temp Message:tempstr DateAdded:tempdateCr DateModified:tempdateMo PlusVotes:tempPV MinusVotes:tempMV];
            [arr addObject:quote1];
            
        }
    }
    sqlite3_finalize(statement);
    NSArray *temp = [[NSArray alloc]initWithArray:arr];
    return temp;

}

@end
