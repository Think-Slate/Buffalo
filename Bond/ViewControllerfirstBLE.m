//
//  ViewController.m
//  FindMyKeys
//
//  Created by Tim Wurman on 4/5/2014
//

#import "ViewControllerfirstBLE.h"

@interface ViewController ()


@end

@implementation ViewController{
    
}

@synthesize ble;

- (void)viewDidLoad
{
    ble = [[BLE alloc]init];
    [ble controlSetup:1];
    ble.delegate = self;
    connected = false;
    firstTime = true;
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)onTick:(NSTimer *)timer
{
            if([ble isConnected])
            {
                printf("inConnect\n");
                UInt8 buf[1] = {0x01};
                NSData *d = [[NSData alloc]initWithBytes:buf length:1];
                [ble write:d];
                connected = 1;
                firstTime = 0;
                [_firstConnection setTitle:@"Disconnect" forState:UIControlStateNormal];
                printf("out of connect\n");
            }
            else
            {
                printf("Out of here");
            }

}

- (IBAction)sendConnect {
    printf("sending data to board\n");
    if(![ble isConnected])
    {
                    [self scanForPeripherals];
        [self performSelector:@selector(onTick:) withObject:nil afterDelay:7.5];
    }
    
    else
        printf("No bueno");
}

- (IBAction)sendDisconnect {
    printf("sending data to board\n");
    if([ble isConnected]){
        printf("inSendDisconnect");
        UInt8 buf[1] = {0x00};
        NSData *d = [[NSData alloc]initWithBytes:buf length:1];
        [ble write:d];
         [self disconnectFromPeripheral];
        [_firstConnection setTitle:@"Connect" forState:UIControlStateNormal];
        firstTime = 1;
        connected = 0;
    }
}

- (IBAction)firstConnection:(id)sender {
	
    //check if password is correct
    //send arming signal
    
    if (connected) {
        printf("1");
    }else{
        printf("0");
    }
            //check if password is correct
        //send arming signal
        if(!connected && ![ble isConnected]){
            [self sendConnect];
        }
        else
        {
            [self sendDisconnect];
        }
}
    




#pragma mark - BLEDelegate
-(void)bleDidConnect{

}

-(void)bleDidDisconnect{
    
}

-(void)bleDidReceiveData:(unsigned int *)data length:(int)length{
    // 0x12D52043
    if(data[0] == 0xEAB7BACD){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Tyler Devries: We received the message: we would use that to either ping a server or another phone via bluetooth" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
        //alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    else if(data[0] == 0xE0E0E01F){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Victor Vainberg: We received the message: we would use that to either ping a server or another phone via bluetooth" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [alert show];
    }
    
    else if(data[0] == 0xE0E0D02F)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Johnny Appleseed: We received the message: we would use that to either ping a server or another phone via bluetooth" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [alert show];

    }
    else{
         UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Unknown code" message:@"We received a code that we were not expecting" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
                [alert show];
    // NSLog(@"Value of message = %@", data[0]);

    }

}

-(void)bleDidUpdateRSSI:(NSNumber *)rssi{
	//do nothing
}

#pragma mark - BLE Actions
-(void)scanForPeripherals{
	[self disconnectFromPeripheral];
	
    if(ble.peripherals){
        ble.peripherals = nil;
    }
    
    [ble findBLEPeripherals:2];
    [NSTimer scheduledTimerWithTimeInterval:(float)3.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
}

-(void)disconnectFromPeripheral{
     //this seems like its for disconnecting...
     if(ble.activePeripheral){
         if (ble.activePeripheral.isConnected) {
             [[ble CM] cancelPeripheralConnection:[ble activePeripheral]];
         
         }
     }
}

-(void)connectionTimer:(NSTimer*)timer{
	
	
    if(ble.peripherals.count > 0){
		
        [ble connectPeripheral:[ble.peripherals objectAtIndex:0]];
		[NSTimer scheduledTimerWithTimeInterval:(float)300.0 target:self selector:@selector(disconnectTimer:) userInfo:nil repeats:NO];
        
    } else {
        
		UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Device not in range" message:@"Could not connect to device. Must be within 100ft of your location" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
		//alert.alertViewStyle = UIAlertViewStylePlainTextInput;
		[alert show];
    }
    
}

-(void)disconnectTimer:(NSTimer*)timer{
	if (ble.activePeripheral.isConnected) {
		[self disconnectFromPeripheral];
		UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Disconnected From Device" message:@"Press Retry to Reconnect" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
		//alert.alertViewStyle = UIAlertViewStylePlainTextInput;
		[alert show];
		
	} else {
		//not working properly
		[timer invalidate];
	}
	
}

//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
////    currentLocation = [locations objectAtIndex:0];
////    [locationManager stopUpdatingLocation];
////    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
////    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
////     {
////         if (!(error))
////         {
////             CLPlacemark *placemark = [placemarks objectAtIndex:0];
////             NSLog(@"\nCurrent Location Detected\n");
////             NSLog(@"placemark %@",placemark);
////             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
////             NSString *Address = [[NSString alloc]initWithString:locatedAt];
////			 
////			 //get time
////			 NSDate *today = [NSDate date];
////			 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
////			 // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
////			 [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
////			 [dateFormatter setDateStyle:NSDateFormatterShortStyle];
////			 NSString *currentDate = [dateFormatter stringFromDate:today];
////			 
////			 NSString *lastSeen = [NSString stringWithFormat:@"Last Seen:\n%@\n%@", currentDate, Address];
////			 self.locationLabel.text = lastSeen;
////			 
////			 //store last location
////			 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////			 NSString *location = self.locationLabel.text;	//change to address
////			 [defaults setObject:Address forKey:@"lastLocation"];
////			 [defaults setObject:currentDate forKey:@"lastTime"];
////			 //[defaults setObject:placemark forKey:@"placeMark"];
////			 NSLog(@"Logging location: \n%@\n",location);
////			 [defaults synchronize];
////
////         }
////         else
////         {
////             NSLog(@"Geocode failed with error %@", error);
////             NSLog(@"\nCurrent Location Not Detected\n");
////             //return;
////         }
////		 
////     }];
//}
//
//-(void)CurrentLocationIdentifier
//{
//    //---- For getting current gps location
////    locationManager = [CLLocationManager new];
////    locationManager.delegate = self;
////    locationManager.distanceFilter = kCLDistanceFilterNone;
////    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
////    [locationManager startUpdatingLocation];
//    //------
//}

@end
