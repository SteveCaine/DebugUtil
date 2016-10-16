//
//	Debug_iOS.cpp
//	DebugUtil
//
//	Created by Steve Caine on 07/13/11.
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2011-2014 Steve Caine.
//

#include <string>
using namespace std;

#include <iomanip>	// for std::setw(int)
#include <sstream>	// for std::ostringstream
#include <string>

using namespace std;

typedef unsigned char uchar;

static const uchar kFirstPrintingChar  = 0x20;
static const uchar kLastPrintingChar   = 0xD9;
static const uchar kNonPrintingDelChar = 0x7F;

#define isprint_mac(ch) ((uchar)(ch) >= kFirstPrintingChar && (uchar)(ch) <= kLastPrintingChar && ch != kNonPrintingDelChar)

static const char HEX_CHARS[] = "0123456789ABCDEF";

// ----------------------------------------------------------------------
//	write hex and ASCII values of _len_ bytes starting at address _data_
//	(substitute '.' for non-printing chars in ASCII data)
//	output in this format:
//
//	-----------
//	DUMP: 41 bytes at 0x00000000
//	   0: 0000 0000 0000 0000 0000 0000 0000 0000 | ................ |
//	  10: 0000 0000 0000 0000 0000 0000 0000 0000 | ................ |
//	  20: 0000 0000 0000 0000 00				  | .........		 |
//	-----------

extern "C"
const char* dd_Nhex(const void* data, int len)
{
	static std::string result;
	
	std::ostringstream oss;
	
	oss << endl << ("-----------") << endl;
	oss << "DUMP: " << len << " bytes at " << std::hex << (long)data << std::dec << std::endl;
	if (data && len > 0) {
		char	h[44], *hp;
		char	s[22], *sp;
		char	ch;
		short	row, rows, cols;
		const char	*dp = (const char*) data;
		long	bytes = len;
		
		memset(h, 0, sizeof(h)); h[0] = ' ';
		memset(s, 0, sizeof(s)); s[0] = ' ';
		
		row	 = 0;
		rows = (len + 15) / 16;
		while (rows-- > 0) {
			oss << setw(4) << row << ":";
			cols = 8;
			hp = &h[1];
			sp = &s[1];
			while (cols-- > 0) {
				if (bytes > 0) {
					ch = *dp++;								// high byte in word
					*hp++ = HEX_CHARS[(ch & 0xF0) >> 4];	// high nibble in byte
					*hp++ = HEX_CHARS[ ch & 0x0F];			// low nibble in byte
					*sp++ = isprint_mac(ch) ? ch : '.';		// ASCII
					bytes--;
				}
				else {
					// SPC 10-11-13 silence Xcode 5 warning: 'Multiple unsequenced modifications to 'hp''
					//					*hp++ = *hp++ = *sp++ = ' ';			// empty beyond end-of-data
					*hp++ = *sp = ' ';						// empty beyond end-of-data
					*hp++ = *sp++ = ' ';					// empty beyond end-of-data
				}
				if (bytes > 0) {
					ch = *dp++;								// low byte in word
					*hp++ = HEX_CHARS[(ch & 0xF0) >> 4];	// high nibble in byte
					*hp++ = HEX_CHARS[ ch & 0x0F];			// low nibble in byte
					*sp++ = isprint_mac(ch) ? ch : '.';		// ASCII
					bytes--;
				}
				else {
					// SPC 10-11-13 silence Xcode 5 warning: 'Multiple unsequenced modifications to 'hp''
					//					*hp++ = *hp++ = *sp++ = ' ';			// empty beyond end-of-data
					*hp++ = *sp = ' ';						// empty beyond end-of-data
					*hp++ = *sp++ = ' ';					// empty beyond end-of-data
				}
				*hp++ = ' ';								// space between hex columns
			}
			*sp++ = ' ';
			*hp++ = *sp++ = '|';
			oss << (const char*)h << (const char*) s << endl;
			row += 10;
		}
		oss << "-----------" << endl;
	}
	else
		oss << "!dd_Nhex" << endl;
	
	result = oss.str();
	
	// NOTE: Since we're returning an address inside our internal static string,
	// callers should use result right away, as return value is not persistent.
	return result.c_str();
}
// ----------------------------------------------------------------------
//	write EITHER hex OR ASCI values of _len_ bytes starting at address _data_
//	(substitute '.' for non-printing chars in ASCII data)

extern "C"
const char* d_Nhex(const void* data, int len, bool treatAsText)
{
	static std::string result;
	
	result.clear();
	
	if (data && len > 0) {
		result.append("{ ");
		
		const char* cp = static_cast<const char*>(data);
		const char* end = cp + len;
		
		while (cp < end) {
			char ch = *cp++;
			if (treatAsText) {
				if (ch == 0x0D) {
					if (cp[0] != 0x0A)
						result.append(1, '\n'); // Mac CR => Unix linebreak
					else
						++cp;					// DOS CR/LF => Unix linebreak
				}
				else
					result.append(1, isprint_mac(ch) ? ch : '.');	// ASCII
			}
			else {
				result.append(1, HEX_CHARS[(ch & 0xF0) >> 4]);
				result.append(1, HEX_CHARS[ ch & 0x0F]);
				if (cp < end)
					result.append(1, ' ');
			}
		}
		result.append(" }");
	}
	else
		result.assign("!d_Nhex");
	
	return result.c_str();
}
// ----------------------------------------------------------------------
