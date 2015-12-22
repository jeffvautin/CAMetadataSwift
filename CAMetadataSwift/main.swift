//
//  main.swift
//  CAMetadataSwift
//
//  Created by Jeff Vautin on 12/20/15.
//  Copyright © 2015 Jeff Vautin. All rights reserved.
//

import Foundation
import AudioToolbox

if (Process.argc < 2) {
    print("Usage: CAMetadata /full/path/to/audiofile\n")
    exit(1)
}

let audioFilePath = (Process.arguments[1] as NSString).stringByExpandingTildeInPath
let audioURL = NSURL.fileURLWithPath(audioFilePath)

var audioFile: AudioFileID = nil
var theErr = noErr

theErr = AudioFileOpenURL(audioURL, AudioFilePermissions.ReadPermission, 0, &audioFile)

assert(theErr == noErr)

var dictionarySize: UInt32 = 0
var isWriteable: UInt32 = 0

theErr = AudioFileGetPropertyInfo(audioFile, kAudioFilePropertyInfoDictionary, &dictionarySize, &isWriteable)

assert(theErr == noErr)

var dictionary: CFDictionaryRef? = nil
theErr = AudioFileGetProperty(audioFile, kAudioFilePropertyInfoDictionary, &dictionarySize, &dictionary)

assert(theErr == noErr)
print("dictionary: \(dictionary)")

theErr = AudioFileClose(audioFile)
assert(theErr == noErr)

exit(0)