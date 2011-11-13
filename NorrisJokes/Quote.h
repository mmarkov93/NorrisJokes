//
//  Quote.h
//  NorrisJokes
//
//  Created by Martin Markov on 11/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum Category {
    TestCategory
}Category;

@interface Quote : NSObject {
    NSString *message;
    NSDate *dateAdded;
    NSString *author;
    Category category;
    double rating;
    int votes;
    double userVote;
    
}

@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSDate *dateAdded;
@property (nonatomic, retain) NSString *author;
@property Category category;
@property double rating;
@property int votes;
@property double userVote;

@end
