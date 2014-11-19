# TKSoundCloudParser
## Download songs from SoundCloud and more

### Intro
TKSoundCloudParser is a parser for the SoundCloud API written in Objective-C.

### How do I TKSoundCloudParser?
Just drag the "TKSoundCloudParser" folder to your project and import the header file.

Get information from the API:
```obj-c
[TKSoundCloudParser getSoundCloudInformationForURL:https://soundcloud.com/vinylalkohol withBlock:^(NSDictionary *responseData, NSError *error) {
    // Do something with the responseData dictionary which contains lot of information

    label.text = [NSString stringWithFormat:@"%@", [responseData objectForKey:@"username"]];
}];
```

Download a song:
```obj-c
[TKSoundCloudParser getSoundCloudTrackForURL:https://soundcloud.com/vinylalkohol/jahresgl-ckblick withBlock:^(NSData *trackData, NSString *artist, NSString *title, NSError *error) {
    if (!error) {
        // Save the song

        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@ - %@.mp3", documentsDirectory, artist, title];
        [trackData writeToFile:filePath atomically:YES];
    } else {
        NSLog(@"[TKSoudCloudParser] Following error occured: %@", error);
    }
}];
```

### How do I get?
Right here!

### How do I compile?
You should know that. :P

### License?
Pretty much the BSD license, just don't repackage it and call it your own please!

Also if you do make some changes, feel free to make a pull request and help make things more awesome!

### Contact Info?
If you have any support requests please feel free to email me at shinvou[at]gmail[dot]com.

Otherwise, feel free to follow me on twitter: [@biscoditch](https:///www.twitter.com/biscoditch)!

### Special Thanks
/
