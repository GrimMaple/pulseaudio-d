module pulse.xmalloc;

extern (C):

/***
  This file is part of PulseAudio.

  Copyright 2004-2006 Lennart Poettering

  PulseAudio is free software; you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published
  by the Free Software Foundation; either version 2.1 of the License,
  or (at your option) any later version.

  PulseAudio is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with PulseAudio; if not, see <http://www.gnu.org/licenses/>.
***/

/** \file
 * Memory allocation functions.
 */

/** Allocate the specified number of bytes, just like malloc() does. However, in case of OOM, terminate */
void* pa_xmalloc (size_t l);

/** Same as pa_xmalloc(), but initialize allocated memory to 0 */
void* pa_xmalloc0 (size_t l);

/**  The combination of pa_xmalloc() and realloc() */
void* pa_xrealloc (void* ptr, size_t size);

/** Free allocated memory */
void pa_xfree (void* p);

/** Duplicate the specified string, allocating memory with pa_xmalloc() */
char* pa_xstrdup (const(char)* s);

/** Duplicate the specified string, but truncate after l characters */
char* pa_xstrndup (const(char)* s, size_t l);

/** Duplicate the specified memory block */
void* pa_xmemdup (const(void)* p, size_t l);

/** Internal helper for pa_xnew() */
void* _pa_xnew_internal (size_t n, size_t k);

void* _pa_xnew_internal (size_t n, size_t k);

/** Allocate n new structures of the specified type. */

/** Internal helper for pa_xnew0() */
void* _pa_xnew0_internal (size_t n, size_t k);

void* _pa_xnew0_internal (size_t n, size_t k);

/** Same as pa_xnew() but set the memory to zero */

/** Internal helper for pa_xnew0() */
void* _pa_xnewdup_internal (const(void)* p, size_t n, size_t k);

void* _pa_xnewdup_internal (const(void)* p, size_t n, size_t k);

/** Same as pa_xnew() but duplicate the specified data */

/** Internal helper for pa_xrenew() */
void* _pa_xrenew_internal (void* p, size_t n, size_t k);

void* _pa_xrenew_internal (void* p, size_t n, size_t k);

/** Reallocate n new structures of the specified type. */

