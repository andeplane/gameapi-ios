//
//  PlayerScore.h
//  ObjectiveCTest
//
//  This file is part of the official Playtomic API for iOS games.  
//  Playtomic is a real time analytics platform for casual games 
//  and services that go in casual games.  If you haven't used it 
//  before check it out:
//  http://playtomic.com/
//
//  Created by ben at the above domain on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//
//  Documentation is available at:
//  http://playtomic.com/api/ios
//
// PLEASE NOTE:
// You may modify this SDK if you wish but be kind to our servers.  Be
// careful about modifying the analytics stuff as it may give you 
// borked reports.
//
// If you make any awesome improvements feel free to let us know!
//
// -------------------------------------------------------------------------
// THIS SOFTWARE IS PROVIDED BY PLAYTOMIC, LLC "AS IS" AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <Foundation/Foundation.h>


@interface PlaytomicScore : NSObject {
    NSString *name;
    NSInteger points;
    NSDate *date;
    NSString *relativeDate;
    NSMutableDictionary *customData;
    long rank;
}

- (id)initWithName:(NSString*)pname 
         andPoints:(NSInteger)ppoints 
           andDate:(NSDate*)pdate 
   andRelativeDate:(NSString*)relativedate 
     andCustomData:(NSMutableDictionary*)customdata 
           andRank: (long)rank;

- (id)initNewScoreWithName:(NSString*)pname 
                 andPoints:(NSInteger)ppoints;

- (NSString*)getName;

- (NSInteger)getPoints;

- (NSDate*)getDate;

- (long)getRank;

- (NSString*)getRelativeDate;

- (NSMutableDictionary*)getCustomData;

- (NSString*)getCustomValue:(NSString*)key;

- (void)addCustomValue:(NSString*)key 
              andValue:(NSString*)value;

@end
