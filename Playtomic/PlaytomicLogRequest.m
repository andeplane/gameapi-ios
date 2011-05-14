//
//  PlaytomicRequest.m
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

#import "PlaytomicLogRequest.h"
#import "Playtomic.h"
#import "PlaytomicLog.h"
#import "ASI/ASIHTTPRequest.h"

@interface PlaytomicLogRequest ()
@property (nonatomic,copy) NSString *data;
@property (nonatomic,copy) NSString *trackUrl;
@end

@implementation PlaytomicLogRequest

@synthesize data;
@synthesize trackUrl;

- (id) initWithTrackUrl: (NSString*) url
{
    trackUrl = url;
    data = @"";
    return self;
}

-(void) queue: (NSString*) event
{
    if([data length] == 0)
    {
        data = event;
    }
    else
    {
        data = [data stringByAppendingString:@"~"];
        data = [data stringByAppendingString: event];
    }
}

-(void) massQueue:(NSMutableArray*) eventqueue
{
    while([eventqueue count] > 0)
    {
        id event = [eventqueue objectAtIndex: 0];
        [eventqueue removeObjectAtIndex: 0];
        
        if([data length] == 0)
        {
            data = event;

        }
        else
        {
            data = [data stringByAppendingString:@"~"];
            data = [data stringByAppendingString: event];
            
            if([data length] > 300)
            {
                [self send];
                
                PlaytomicLogRequest* request = [[PlaytomicLogRequest alloc] initWithTrackUrl: trackUrl];
                [request massQueue: eventqueue];
                
                break;
            }
        } 
    }
    
    [self send];
}


-(void) send
{
	NSString *fullurl = self.trackUrl;
    fullurl = [fullurl stringByAppendingString: self.data];
    
    NSLog(fullurl);
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL: [NSURL URLWithString: fullurl]];
    [request HEADRequest];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"request finished");
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"request failed %@", [request error]);
}

@end

