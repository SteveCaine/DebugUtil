DebugUtil
=========

This repository contains code to log data from a running iOS app to Xcode's debugger console, including data specific to CoreLocation and MapKit, from where it can be captured into text files for further analysis. 

The code is designed to be active in Debug builds, but silent in all other builds, so it can remain in production code for use in the next development cycle. 

The key function -- MyLog(format,...) -- has the same signature as NSLog() and is #define'd to replace it in Debug builds. In all other builds MyLog() becomes a no-op while NSLog() is restored.

Also in this repository is a simple 'DebugDemo' app to demonstrate the use of this debug code. 

My other public repositories on GitHub use files in this repository, on the assumption all the repositories have been copied/cloned to the same parent folder. To simplify this, my GitHub repository 'unix-scripts' includes a script named 'cloneall' to automate the download of all my public repositories to a single Mac folder; the script contains detailed instructions on its use.  

This code is distributed under the terms of the MIT license. See file "LICENSE" in this repository for details.

Copyright (c) 2011-2014 Steve Caine.<br>
@SteveCaine on github.com
