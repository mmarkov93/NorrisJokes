//
//  QuotesList.h
//  NorrisJokes
//
//  Created by Martin Markov on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuotesList : NSObject {
    NSMutableArray *quotes;
}

@property (nonatomic, retain) NSMutableArray *quotes;

-(void)sortQuotesByDate;
-(void)sortQuotesByRaiting;
-(void)sortQuotesByVotes;
-(void)sortQuotesByAuthor;
-(void)sortQuotesByCategory;

@end
