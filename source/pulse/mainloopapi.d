module pulse.mainloopapi;

version(linux):

import core.sys.posix.sys.time;

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
 *
 * Main loop abstraction layer. Both the PulseAudio core and the
 * PulseAudio client library use a main loop abstraction layer. Due to
 * this it is possible to embed PulseAudio into other
 * applications easily. Three main loop implementations are
 * currently available:
 * \li A minimal implementation based on the C library's poll() function
 *     (See \ref mainloop.h).
 * \li A special version of the previous implementation where all of
 *     PulseAudio's internal handling runs in a separate thread
 *     (See \ref thread-mainloop.h).
 * \li A wrapper around the GLIB main loop. Use this to embed PulseAudio into
 *     your GLIB/GTK+/GNOME programs (See \ref glib-mainloop.h).
 *
 * The structure pa_mainloop_api is used as a vtable for the main loop abstraction.
 *
 * This mainloop abstraction layer has no direct support for UNIX signals.
 * Generic, mainloop implementation agnostic support is available through
 * \ref mainloop-signal.h.
 * */

/** An abstract mainloop API vtable */

/** A bitmask for IO events */
enum pa_io_event_flags
{
    PA_IO_EVENT_NULL = 0, /**< No event */
    PA_IO_EVENT_INPUT = 1, /**< Input event */
    PA_IO_EVENT_OUTPUT = 2, /**< Output event */
    PA_IO_EVENT_HANGUP = 4, /**< Hangup event */
    PA_IO_EVENT_ERROR = 8 /**< Error event */
}

alias pa_io_event_flags_t = pa_io_event_flags;

/** An opaque IO event source object */
struct pa_io_event;
/** An IO event callback prototype \since 0.9.3 */
alias pa_io_event_cb_t = void function (pa_mainloop_api* ea, pa_io_event* e, int fd, pa_io_event_flags_t events, void* userdata);
/** A IO event destroy callback prototype \since 0.9.3 */
alias pa_io_event_destroy_cb_t = void function (pa_mainloop_api* a, pa_io_event* e, void* userdata);

/** An opaque timer event source object */
struct pa_time_event;
/** A time event callback prototype \since 0.9.3 */
alias pa_time_event_cb_t = void function (pa_mainloop_api* a, pa_time_event* e, const(timeval)* tv, void* userdata);
/** A time event destroy callback prototype \since 0.9.3 */
alias pa_time_event_destroy_cb_t = void function (pa_mainloop_api* a, pa_time_event* e, void* userdata);

/** An opaque deferred event source object. Events of this type are triggered once in every main loop iteration */
struct pa_defer_event;
/** A defer event callback prototype \since 0.9.3 */
alias pa_defer_event_cb_t = void function (pa_mainloop_api* a, pa_defer_event* e, void* userdata);
/** A defer event destroy callback prototype \since 0.9.3 */
alias pa_defer_event_destroy_cb_t = void function (pa_mainloop_api* a, pa_defer_event* e, void* userdata);

/** An abstract mainloop API vtable */
struct pa_mainloop_api
{
    /** A pointer to some private, arbitrary data of the main loop implementation */
    void* userdata;

    /** Create a new IO event source object */
    pa_io_event* function (pa_mainloop_api* a, int fd, pa_io_event_flags_t events, pa_io_event_cb_t cb, void* userdata) io_new;
    /** Enable or disable IO events on this object */
    void function (pa_io_event* e, pa_io_event_flags_t events) io_enable;
    /** Free a IO event source object */
    void function (pa_io_event* e) io_free;
    /** Set a function that is called when the IO event source is destroyed. Use this to free the userdata argument if required */
    void function (pa_io_event* e, pa_io_event_destroy_cb_t cb) io_set_destroy;

    /** Create a new timer event source object for the specified Unix time */
    pa_time_event* function (pa_mainloop_api* a, const(timeval)* tv, pa_time_event_cb_t cb, void* userdata) time_new;
    /** Restart a running or expired timer event source with a new Unix time */
    void function (pa_time_event* e, const(timeval)* tv) time_restart;
    /** Free a deferred timer event source object */
    void function (pa_time_event* e) time_free;
    /** Set a function that is called when the timer event source is destroyed. Use this to free the userdata argument if required */
    void function (pa_time_event* e, pa_time_event_destroy_cb_t cb) time_set_destroy;

    /** Create a new deferred event source object */
    pa_defer_event* function (pa_mainloop_api* a, pa_defer_event_cb_t cb, void* userdata) defer_new;
    /** Enable or disable a deferred event source temporarily */
    void function (pa_defer_event* e, int b) defer_enable;
    /** Free a deferred event source object */
    void function (pa_defer_event* e) defer_free;
    /** Set a function that is called when the deferred event source is destroyed. Use this to free the userdata argument if required */
    void function (pa_defer_event* e, pa_defer_event_destroy_cb_t cb) defer_set_destroy;

    /** Exit the main loop and return the specified retval*/
    void function (pa_mainloop_api* a, int retval) quit;
}

/** Run the specified callback function once from the main loop using an
 * anonymous defer event. If the mainloop runs in a different thread, you need
 * to follow the mainloop implementation's rules regarding how to safely create
 * defer events. In particular, if you're using \ref pa_threaded_mainloop, you
 * must lock the mainloop before calling this function. */
void pa_mainloop_api_once (pa_mainloop_api* m, void function (pa_mainloop_api* m, void* userdata) callback, void* userdata);

