//
//  Quote.m
//  NorrisJokes
//
//  Created by Martin Markov on 11/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Quote.h"


@implementation Quote

@synthesize key;
@synthesize message;
@synthesize dateAdded;
@synthesize dateModified;
@synthesize plusVotes;
@synthesize minusVotes;

-(id)initWithID:(int)key Message:(NSString *)message DateAdded:(NSDate *)dateAdded DateModified:(NSDate *)dateModified PlusVotes:(int)plusVotes MinusVotes:(int)minusVotes{
    self = [super init];
    if(self) {
        self.key = key;
        self.message = message;
        self.dateAdded = dateAdded;
        self.dateModified = dateModified;
        self.plusVotes = plusVotes;
        self.minusVotes = minusVotes;
        
    }
    return self;
}
@end
