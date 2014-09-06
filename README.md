DebugUtil
=========

This repository contains code to log data from a running iOS app to Xcode's debugger console, including data specific to CoreLocation and MapKit, from where it can be captured into text files for further analysis. 

The code is designed to be active in Debug builds, but silent in all other builds, so it can remain in production code for use in the next development cycle. 

The key function -- MyLog(format,...) -- has the same signature as NSLog() and is #define'd to replace it in Debug builds. In all other builds MyLog() becomes a no-op while NSLog() is restored.

Also in this repository is a simple 'DebugDemo' app to demonstrate the use of this debug code. 

This code is distributed under the terms of the MIT license. See file "LICENSE" in this repository for details.

Copyright (c) 2011-2014 Steve Caine.
@SteveCaine on github.com
