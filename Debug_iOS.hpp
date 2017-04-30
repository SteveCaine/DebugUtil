//
//	Debug_iOS.hpp
//	DebugUtil
//
//	Created by Steve Caine on 04/20/17.
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2017 Steve Caine.
//

#ifdef __cplusplus
extern "C" {
#endif
	// C/C++
	// ----------------------------------------------------------------------
	const char* d_Nhex(const void* p, int n, bool treatAsText);
	const char* dd_Nhex(const void* data, int len);
	// ----------------------------------------------------------------------
#ifdef __cplusplus
}
#endif
