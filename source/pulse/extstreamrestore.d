module pulse.extstreamrestore;

version(linux):

import pulse.channelmap;
import pulse.volume;
import pulse.context;
import pulse.operation;
import pulse.proplist;

extern (C):

/***
  This file is part of PulseAudio.

  Copyright 2008 Lennart Poettering

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
 *
 * Routines for controlling module-stream-restore
 */

/** Stores information about one entry in the stream database that is
 * maintained by module-stream-restore. \since 0.9.12 */
struct pa_ext_stream_restore_info
{
    const(char)* name; /**< Identifier string of the stream. A string like "sink-input-by-role:" or similar followed by some arbitrary property value. */
    pa_channel_map channel_map; /**< The channel map for the volume field, if applicable */
    pa_cvolume volume; /**< The volume of the stream when it was seen last, if applicable and saved */
    const(char)* device; /**< The sink/source of the stream when it was last seen, if applicable and saved */
    int mute; /**< The boolean mute state of the stream when it was last seen, if applicable and saved */
}

/** Callback prototype for pa_ext_stream_restore_test(). \since 0.9.12 */
alias pa_ext_stream_restore_test_cb_t = void function (
    pa_context* c,
    uint version_,
    void* userdata);

/** Test if this extension module is available in the server. \since 0.9.12 */
pa_operation* pa_ext_stream_restore_test (
    pa_context* c,
    pa_ext_stream_restore_test_cb_t cb,
    void* userdata);

/** Callback prototype for pa_ext_stream_restore_read(). \since 0.9.12 */
alias pa_ext_stream_restore_read_cb_t = void function (
    pa_context* c,
    const(pa_ext_stream_restore_info)* info,
    int eol,
    void* userdata);

/** Read all entries from the stream database. \since 0.9.12 */
pa_operation* pa_ext_stream_restore_read (
    pa_context* c,
    pa_ext_stream_restore_read_cb_t cb,
    void* userdata);

/** Store entries in the stream database. \since 0.9.12 */
pa_operation* pa_ext_stream_restore_write (
    pa_context* c,
    pa_update_mode_t mode,
    const(pa_ext_stream_restore_info)* data,
    uint n,
    int apply_immediately,
    pa_context_success_cb_t cb,
    void* userdata);

/** Delete entries from the stream database. \since 0.9.12 */
pa_operation* pa_ext_stream_restore_delete (
    pa_context* c,
    const(char*)* s,
    pa_context_success_cb_t cb,
    void* userdata);

/** Subscribe to changes in the stream database. \since 0.9.12 */
pa_operation* pa_ext_stream_restore_subscribe (
    pa_context* c,
    int enable,
    pa_context_success_cb_t cb,
    void* userdata);

/** Callback prototype for pa_ext_stream_restore_set_subscribe_cb(). \since 0.9.12 */
alias pa_ext_stream_restore_subscribe_cb_t = void function (
    pa_context* c,
    void* userdata);

/** Set the subscription callback that is called when
 * pa_ext_stream_restore_subscribe() was called. \since 0.9.12 */
void pa_ext_stream_restore_set_subscribe_cb (
    pa_context* c,
    pa_ext_stream_restore_subscribe_cb_t cb,
    void* userdata);

