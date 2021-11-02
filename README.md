# pulseaudio-d
D static wrappers for libpulse (PulseAudio)  
  
Generated using `dstep`, manually adjusted to compile and work.
# Usage
Please note that while the original file structure is preserved, some adjustment had to be made to make it work with D. Noticeably, all `-` in module names were removed.  
A few things got removed because they wouldn't compile as D code.  
You __have__ to link against `pulse` or `pulse-simple` in your `dub.json`.  
Appears to be based on PulseAudio version 15.0
