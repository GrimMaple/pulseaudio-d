module pulse.timeval;

version(linux):

import core.sys.posix.sys.select;

import pulse.sample;

extern (C):

/***
  This file is part of PulseAudio.

  Copyright 2004-2006 Lennart Poettering
  Copyright 2006 Pierre Ossman <ossman@cendio.se> for Cendio AB

  PulseAudio is free software; you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as
  published by the Free Software Foundation; either version 2.1 of the
  License, or (at your option) any later version.

  PulseAudio is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with PulseAudio; if not, see <http://www.gnu.org/licenses/>.
***/

/** \file
 * Utility functions for handling timeval calculations */

/** The number of milliseconds in a second */
enum PA_MSEC_PER_SEC = cast(pa_usec_t) 1000;

/** The number of microseconds in a second */
enum PA_USEC_PER_SEC = cast(pa_usec_t) 1000000;

/** The number of nanoseconds in a second */
enum PA_NSEC_PER_SEC = cast(ulong) 1000000000;

/** The number of microseconds in a millisecond */
enum PA_USEC_PER_MSEC = cast(pa_usec_t) 1000;

/** The number of nanoseconds in a millisecond */
enum PA_NSEC_PER_MSEC = cast(ulong) 1000000;

/** The number of nanoseconds in a microsecond */
enum PA_NSEC_PER_USEC = cast(ulong) 1000;

/** Invalid time in usec. \since 0.9.15 */
enum PA_USEC_INVALID = cast(pa_usec_t) -1;

/** Biggest time in usec. \since 0.9.18 */
enum PA_USEC_MAX = cast(pa_usec_t) -2;

/** Return the current wallclock timestamp, just like UNIX gettimeofday(). */
timeval* pa_gettimeofday (timeval* tv);

/** Calculate the difference between the two specified timeval
 * structs. */
pa_usec_t pa_timeval_diff (const(timeval)* a, const(timeval)* b);

/** Compare the two timeval structs and return 0 when equal, negative when a < b, positive otherwise */
int pa_timeval_cmp (const(timeval)* a, const(timeval)* b);

/** Return the time difference between now and the specified timestamp */
pa_usec_t pa_timeval_age (const(timeval)* tv);

/** Add the specified time in microseconds to the specified timeval structure */
timeval* pa_timeval_add (timeval* tv, pa_usec_t v);

/** Subtract the specified time in microseconds to the specified timeval structure. \since 0.9.11 */
timeval* pa_timeval_sub (timeval* tv, pa_usec_t v);

/** Store the specified usec value in the timeval struct. \since 0.9.7 */
timeval* pa_timeval_store (timeval* tv, pa_usec_t v);

/** Load the specified tv value and return it in usec. \since 0.9.7 */
pa_usec_t pa_timeval_load (const(timeval)* tv);

