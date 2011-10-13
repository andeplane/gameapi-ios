//
//  Playtomic.m
//  Playtomic
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

#import "Playtomic.h"
#import "PlaytomicLog.h"
#import "PlaytomicGameVars.h"
#import "PlaytomicGeoIP.h"
#import "PlaytomicLeaderboards.h"
#import "PlaytomicLink.h"
#import "PlaytomicData.h"

@interface Playtomic ()
@property (nonatomic,readwrite) NSInteger gameId;
@property (nonatomic,copy) NSString *gameGuid;
@property (nonatomic,copy) NSString *sourceUrl;
@property (nonatomic,copy) NSString *baseUrl;
@property (assign) PlaytomicLog *log;
@property (assign) PlaytomicGameVars *gameVars;
@property (assign) PlaytomicGeoIP *geoIP;
@property (assign) PlaytomicLeaderboards *leaderboards;
@property (assign) PlaytomicPlayerLevels *playerLevels;
@property (assign) PlaytomicLink *link;
@property (assign) PlaytomicData *data;
@end

@implementation Playtomic

@synthesize gameId;
@synthesize gameGuid;
@synthesize sourceUrl;
@synthesize baseUrl;
@synthesize log;
@synthesize gameVars;
@synthesize geoIP;
@synthesize leaderboards;
@synthesize playerLevels;
@synthesize link;
@synthesize data;

static Playtomic *instance = nil;

+ (void)initialize
{
    if (instance == nil)
    {
        instance = [[self alloc] init];
    }
}

+ (PlaytomicLog*)Log
{
	return instance.log;
}

+ (PlaytomicGameVars*)GameVars
{
	return instance.gameVars;
}

+ (PlaytomicGeoIP*)GeoIP
{
    return instance.geoIP;
}

+ (PlaytomicLeaderboards*)Leaderboards
{
    return instance.leaderboards;
}

+ (PlaytomicPlayerLevels*)PlayerLevels
{
    return instance.playerLevels;
}

+ (PlaytomicLink*) Link
{
    return instance.link;
}

+ (PlaytomicData*) Data
{
    return instance.data;
}

+ (NSInteger) getGameId
{
    return instance.gameId;
}

+ (NSString*) getGameGuid
{
    return instance.gameGuid;
}

+ (NSString*) getSourceUrl
{
    return instance.sourceUrl;
}

+ (NSString*) getBaseUrl
{
    return instance.baseUrl;
}

- (id)initWithGameId:(NSInteger)gameid 
             andGUID:(NSString*)gameguid
{
    NSString *model = [[UIDevice currentDevice] model];
    NSString *system = [[UIDevice currentDevice] systemName];
    NSString *version = [[UIDevice currentDevice] systemVersion];
    
    model = [model stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    system = [system stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    version = [version stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    instance.gameId = gameid;
    instance.gameGuid = gameguid;
    instance.sourceUrl = [NSString stringWithFormat:@"http://ios.com/%@/%@/%@", model, system, version];
    instance.baseUrl = @"ios.com";

    instance.log = [[PlaytomicLog alloc] initWithGameId:gameid andGUID:gameguid];
    instance.gameVars = [[PlaytomicGameVars alloc] init];
    instance.geoIP = [[PlaytomicGeoIP alloc] init];
    instance.leaderboards = [[PlaytomicLeaderboards alloc] init];
    instance.playerLevels = [[PlaytomicPlayerLevels alloc] init];
    instance.link = [[PlaytomicLink alloc] init];
    instance.data = [[PlaytomicData alloc] init];
    return instance;    
}

- (void)dealloc {
    self.gameGuid = nil;
    self.sourceUrl = nil;
    self.baseUrl = nil;
    self.log = nil;
    self.gameVars = nil;
    self.geoIP = nil;
    self.leaderboards = nil;
    self.playerLevels = nil;
    self.link = nil;
    self.data = nil;    
    [super dealloc];
}


@end
