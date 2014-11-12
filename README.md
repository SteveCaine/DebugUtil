DebugUtil
=========

This repository contains code to log data from a running iOS app to Xcode's debugger console, from where it can be captured into text files for further analysis. 

The code is designed to be active in Debug builds, but silent in all other builds, so it can remain in production code for use in the next development cycle. 

Two kinds of debugging are provided here: an NSLog substitute that becomes NSLog (or falls silent) in Release builds, and C++ overloads of the ostream<< operator of std::out in C++/Objective-C++ code that become no-ops in Release builds.

Also in this repository are two simple app projects to demonstrate the use of this code: 'DebugDemo' for the NSLog variant and 'Demo_dout' for the C++/Objective-C++ variant. See the 'MasterViewController' class in each for most examples of this code's use. 

The key function in the first variant -- MyLog(format,...) -- has the same signature as NSLog() and is #define'd to replace it in Debug builds. In all other builds MyLog() becomes a no-op while NSLog() is restored.

In the same files are functions using MyLog to write out values for various enumerations, structs, objects, and iOS system states. 

The key component in the second variant is a pair of namespaces to wrap the '<<' operator on output streams to std::out/std:err in the Xcode environment. By renaming the stream object from 'cout' to 'dout' (with a template in the non-debug variant to capture all such output and make it no-ops) the debugging code can remain after an app ships, waiting for the next development cycle.

My other public repositories on GitHub use files in this repository, on the assumption all the repositories have been copied/cloned to the same parent folder. To simplify this, my GitHub repository 'unix-scripts' includes a script named 'cloneall' to automate the download of all my public repositories to a single Mac folder; the script contains detailed instructions on its use.  

This code is distributed under the terms of the MIT license. See file "LICENSE" in this repository for details.

Copyright (c) 2010-2014 Steve Caine.<br>
@SteveCaine on github.com
