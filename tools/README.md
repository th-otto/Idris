# Runtime tools for Idris

This is a collection of some runtime tools for Idris. Some are
reconstructed, some are rewrittem from scratch.

For the tools that have been reconstructed, this directory will contain
versions that have been been bug-fixed, or otherwise cleaned up.

The directory "orig" has sources of those tools that more closely match
the original distribution.

The tools for now are:
   - date  
     Query or set current date.
   - readclock  
     Reads the current date from IKBD, and prints it.
   - show0  
     Display partition info.
     This can use the HARDDRIVE environment variable to
     address harddisks other than the first, encoded as
     [0-7][0-1] where the first digit specifies the ACSI drive number,
     and the second digit the LUN.
   - ps  
     Print process status.
     This tool has been fixed to be able to work with either kernel version.
   - settime  
     New tool that reads the IKBD clock, and sets current system time
     from it. Only useful if it already contains a valid date, either after
     reboot, or when using Hatari with an option to set the IKBD clock
     to current local time.
     Should be invoked from /adm/init, instead of Setdate.
