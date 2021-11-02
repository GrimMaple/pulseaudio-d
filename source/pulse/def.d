module pulse.def;

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
 * Global definitions */

/** The state of a connection context */
enum pa_context_state
{
    PA_CONTEXT_UNCONNECTED = 0, /**< The context hasn't been connected yet */
    PA_CONTEXT_CONNECTING = 1, /**< A connection is being established */
    PA_CONTEXT_AUTHORIZING = 2, /**< The client is authorizing itself to the daemon */
    PA_CONTEXT_SETTING_NAME = 3, /**< The client is passing its application name to the daemon */
    PA_CONTEXT_READY = 4, /**< The connection is established, the context is ready to execute operations */
    PA_CONTEXT_FAILED = 5, /**< The connection failed or was disconnected */
    PA_CONTEXT_TERMINATED = 6 /**< The connection was terminated cleanly */
}

alias pa_context_state_t = pa_context_state;

/** Return non-zero if the passed state is one of the connected states. \since 0.9.11 */
int PA_CONTEXT_IS_GOOD (pa_context_state_t x);

/** \cond fulldocs */
enum PA_CONTEXT_UNCONNECTED = pa_context_state_t.PA_CONTEXT_UNCONNECTED;
enum PA_CONTEXT_CONNECTING = pa_context_state_t.PA_CONTEXT_CONNECTING;
enum PA_CONTEXT_AUTHORIZING = pa_context_state_t.PA_CONTEXT_AUTHORIZING;
enum PA_CONTEXT_SETTING_NAME = pa_context_state_t.PA_CONTEXT_SETTING_NAME;
enum PA_CONTEXT_READY = pa_context_state_t.PA_CONTEXT_READY;
enum PA_CONTEXT_FAILED = pa_context_state_t.PA_CONTEXT_FAILED;
enum PA_CONTEXT_TERMINATED = pa_context_state_t.PA_CONTEXT_TERMINATED;
// enum PA_CONTEXT_IS_GOOD = PA_CONTEXT_IS_GOOD;
/** \endcond */

/** The state of a stream */
enum pa_stream_state
{
    PA_STREAM_UNCONNECTED = 0, /**< The stream is not yet connected to any sink or source */
    PA_STREAM_CREATING = 1, /**< The stream is being created */
    PA_STREAM_READY = 2, /**< The stream is established, you may pass audio data to it now */
    PA_STREAM_FAILED = 3, /**< An error occurred that made the stream invalid */
    PA_STREAM_TERMINATED = 4 /**< The stream has been terminated cleanly */
}

alias pa_stream_state_t = pa_stream_state;

/** Return non-zero if the passed state is one of the connected states. \since 0.9.11 */
int PA_STREAM_IS_GOOD (pa_stream_state_t x);

/** \cond fulldocs */
enum PA_STREAM_UNCONNECTED = pa_stream_state_t.PA_STREAM_UNCONNECTED;
enum PA_STREAM_CREATING = pa_stream_state_t.PA_STREAM_CREATING;
enum PA_STREAM_READY = pa_stream_state_t.PA_STREAM_READY;
enum PA_STREAM_FAILED = pa_stream_state_t.PA_STREAM_FAILED;
enum PA_STREAM_TERMINATED = pa_stream_state_t.PA_STREAM_TERMINATED;
// enum PA_STREAM_IS_GOOD = PA_STREAM_IS_GOOD;
/** \endcond */

/** The state of an operation */
enum pa_operation_state
{
    PA_OPERATION_RUNNING = 0,
    /**< The operation is still running */
    PA_OPERATION_DONE = 1,
    /**< The operation has completed */
    PA_OPERATION_CANCELLED = 2
    /**< The operation has been cancelled. Operations may get cancelled by the
     * application, or as a result of the context getting disconnected while the
     * operation is pending. */
}

alias pa_operation_state_t = pa_operation_state;

/** \cond fulldocs */
enum PA_OPERATION_RUNNING = pa_operation_state_t.PA_OPERATION_RUNNING;
enum PA_OPERATION_DONE = pa_operation_state_t.PA_OPERATION_DONE;
enum PA_OPERATION_CANCELED = pa_operation_state_t.PA_OPERATION_CANCELLED;
enum PA_OPERATION_CANCELLED = pa_operation_state_t.PA_OPERATION_CANCELLED;
/** \endcond */

/** An invalid index */
enum PA_INVALID_INDEX = cast(uint) -1;

/** Some special flags for contexts. */
enum pa_context_flags
{
    PA_CONTEXT_NOFLAGS = 0x0000U,
    /**< Flag to pass when no specific options are needed (used to avoid casting)  \since 0.9.19 */
    PA_CONTEXT_NOAUTOSPAWN = 0x0001U,
    /**< Disabled autospawning of the PulseAudio daemon if required */
    PA_CONTEXT_NOFAIL = 0x0002U
    /**< Don't fail if the daemon is not available when pa_context_connect() is
     * called, instead enter PA_CONTEXT_CONNECTING state and wait for the daemon
     * to appear.  \since 0.9.15 */
}

alias pa_context_flags_t = pa_context_flags;

/** \cond fulldocs */
/* Allow clients to check with #ifdef for those flags */
enum PA_CONTEXT_NOAUTOSPAWN = pa_context_flags_t.PA_CONTEXT_NOAUTOSPAWN;
enum PA_CONTEXT_NOFAIL = pa_context_flags_t.PA_CONTEXT_NOFAIL;
/** \endcond */

/** Direction bitfield - while we currently do not expose anything bidirectional,
  one should test against the bit instead of the value (e.g.\ if (d & PA_DIRECTION_OUTPUT)),
  because we might add bidirectional stuff in the future. \since 2.0
*/
enum pa_direction
{
    PA_DIRECTION_OUTPUT = 0x0001U, /**< Output direction */
    PA_DIRECTION_INPUT = 0x0002U /**< Input direction */
}

alias pa_direction_t = pa_direction;

/** \cond fulldocs */
enum PA_DIRECTION_OUTPUT = pa_direction_t.PA_DIRECTION_OUTPUT;
enum PA_DIRECTION_INPUT = pa_direction_t.PA_DIRECTION_INPUT;
/** \endcond */

/** The type of device we are dealing with */
enum pa_device_type
{
    PA_DEVICE_TYPE_SINK = 0, /**< Playback device */
    PA_DEVICE_TYPE_SOURCE = 1 /**< Recording device */
}

alias pa_device_type_t = pa_device_type;

/** \cond fulldocs */
enum PA_DEVICE_TYPE_SINK = pa_device_type_t.PA_DEVICE_TYPE_SINK;
enum PA_DEVICE_TYPE_SOURCE = pa_device_type_t.PA_DEVICE_TYPE_SOURCE;
/** \endcond */

/** The direction of a pa_stream object */
enum pa_stream_direction
{
    PA_STREAM_NODIRECTION = 0, /**< Invalid direction */
    PA_STREAM_PLAYBACK = 1, /**< Playback stream */
    PA_STREAM_RECORD = 2, /**< Record stream */
    PA_STREAM_UPLOAD = 3 /**< Sample upload stream */
}

alias pa_stream_direction_t = pa_stream_direction;

/** \cond fulldocs */
enum PA_STREAM_NODIRECTION = pa_stream_direction_t.PA_STREAM_NODIRECTION;
enum PA_STREAM_PLAYBACK = pa_stream_direction_t.PA_STREAM_PLAYBACK;
enum PA_STREAM_RECORD = pa_stream_direction_t.PA_STREAM_RECORD;
enum PA_STREAM_UPLOAD = pa_stream_direction_t.PA_STREAM_UPLOAD;
/** \endcond */

/** Some special flags for stream connections. */
enum pa_stream_flags
{
    PA_STREAM_NOFLAGS = 0x0000U,
    /**< Flag to pass when no specific options are needed (used to avoid casting)  \since 0.9.19 */

    PA_STREAM_START_CORKED = 0x0001U,
    /**< Create the stream corked, requiring an explicit
     * pa_stream_cork() call to uncork it. */

    PA_STREAM_INTERPOLATE_TIMING = 0x0002U,
    /**< Interpolate the latency for this stream. When enabled,
     * pa_stream_get_latency() and pa_stream_get_time() will try to
     * estimate the current record/playback time based on the local
     * time that passed since the last timing info update.  Using this
     * option has the advantage of not requiring a whole roundtrip
     * when the current playback/recording time is needed. Consider
     * using this option when requesting latency information
     * frequently. This is especially useful on long latency network
     * connections. It makes a lot of sense to combine this option
     * with PA_STREAM_AUTO_TIMING_UPDATE. */

    PA_STREAM_NOT_MONOTONIC = 0x0004U,
    /**< Don't force the time to increase monotonically. If this
     * option is enabled, pa_stream_get_time() will not necessarily
     * return always monotonically increasing time values on each
     * call. This may confuse applications which cannot deal with time
     * going 'backwards', but has the advantage that bad transport
     * latency estimations that caused the time to jump ahead can
     * be corrected quickly, without the need to wait. (Please note
     * that this flag was named PA_STREAM_NOT_MONOTONOUS in releases
     * prior to 0.9.11. The old name is still defined too, for
     * compatibility reasons. */

    PA_STREAM_AUTO_TIMING_UPDATE = 0x0008U,
    /**< If set timing update requests are issued periodically
     * automatically. Combined with PA_STREAM_INTERPOLATE_TIMING you
     * will be able to query the current time and latency with
     * pa_stream_get_time() and pa_stream_get_latency() at all times
     * without a packet round trip.*/

    PA_STREAM_NO_REMAP_CHANNELS = 0x0010U,
    /**< Don't remap channels by their name, instead map them simply
     * by their index. Implies PA_STREAM_NO_REMIX_CHANNELS. Only
     * supported when the server is at least PA 0.9.8. It is ignored
     * on older servers.\since 0.9.8 */

    PA_STREAM_NO_REMIX_CHANNELS = 0x0020U,
    /**< When remapping channels by name, don't upmix or downmix them
     * to related channels. Copy them into matching channels of the
     * device 1:1. Only supported when the server is at least PA
     * 0.9.8. It is ignored on older servers. \since 0.9.8 */

    PA_STREAM_FIX_FORMAT = 0x0040U,
    /**< Use the sample format of the sink/device this stream is being
     * connected to, and possibly ignore the format the sample spec
     * contains -- but you still have to pass a valid value in it as a
     * hint to PulseAudio what would suit your stream best. If this is
     * used you should query the used sample format after creating the
     * stream by using pa_stream_get_sample_spec(). Also, if you
     * specified manual buffer metrics it is recommended to update
     * them with pa_stream_set_buffer_attr() to compensate for the
     * changed frame sizes. Only supported when the server is at least
     * PA 0.9.8. It is ignored on older servers.
     *
     * When creating streams with pa_stream_new_extended(), this flag has no
     * effect. If you specify a format with PCM encoding, and you want the
     * server to choose the sample format, then you should leave the sample
     * format unspecified in the pa_format_info object. This also means that
     * you can't use pa_format_info_from_sample_spec(), because that function
     * always sets the sample format.
     *
     * \since 0.9.8 */

    PA_STREAM_FIX_RATE = 0x0080U,
    /**< Use the sample rate of the sink, and possibly ignore the rate
     * the sample spec contains. Usage similar to
     * PA_STREAM_FIX_FORMAT. Only supported when the server is at least
     * PA 0.9.8. It is ignored on older servers.
     *
     * When creating streams with pa_stream_new_extended(), this flag has no
     * effect. If you specify a format with PCM encoding, and you want the
     * server to choose the sample rate, then you should leave the rate
     * unspecified in the pa_format_info object. This also means that you can't
     * use pa_format_info_from_sample_spec(), because that function always sets
     * the sample rate.
     *
     * \since 0.9.8 */

    PA_STREAM_FIX_CHANNELS = 0x0100,
    /**< Use the number of channels and the channel map of the sink,
     * and possibly ignore the number of channels and the map the
     * sample spec and the passed channel map contain. Usage similar
     * to PA_STREAM_FIX_FORMAT. Only supported when the server is at
     * least PA 0.9.8. It is ignored on older servers.
     *
     * When creating streams with pa_stream_new_extended(), this flag has no
     * effect. If you specify a format with PCM encoding, and you want the
     * server to choose the channel count and/or channel map, then you should
     * leave the channels and/or the channel map unspecified in the
     * pa_format_info object. This also means that you can't use
     * pa_format_info_from_sample_spec(), because that function always sets
     * the channel count (but if you only want to leave the channel map
     * unspecified, then pa_format_info_from_sample_spec() works, because it
     * accepts a NULL channel map).
     *
     * \since 0.9.8 */

    PA_STREAM_DONT_MOVE = 0x0200U,
    /**< Don't allow moving of this stream to another
     * sink/device. Useful if you use any of the PA_STREAM_FIX_ flags
     * and want to make sure that resampling never takes place --
     * which might happen if the stream is moved to another
     * sink/source with a different sample spec/channel map. Only
     * supported when the server is at least PA 0.9.8. It is ignored
     * on older servers. \since 0.9.8 */

    PA_STREAM_VARIABLE_RATE = 0x0400U,
    /**< Allow dynamic changing of the sampling rate during playback
     * with pa_stream_update_sample_rate(). Only supported when the
     * server is at least PA 0.9.8. It is ignored on older
     * servers. \since 0.9.8 */

    PA_STREAM_PEAK_DETECT = 0x0800U,
    /**< Find peaks instead of resampling. \since 0.9.11 */

    PA_STREAM_START_MUTED = 0x1000U,
    /**< Create in muted state. If neither PA_STREAM_START_UNMUTED nor
     * PA_STREAM_START_MUTED are set, it is left to the server to decide
     * whether to create the stream in muted or in unmuted
     * state. \since 0.9.11 */

    PA_STREAM_ADJUST_LATENCY = 0x2000U,
    /**< Try to adjust the latency of the sink/source based on the
     * requested buffer metrics and adjust buffer metrics
     * accordingly. Also see pa_buffer_attr. This option may not be
     * specified at the same time as PA_STREAM_EARLY_REQUESTS. \since
     * 0.9.11 */

    PA_STREAM_EARLY_REQUESTS = 0x4000U,
    /**< Enable compatibility mode for legacy clients that rely on a
     * "classic" hardware device fragment-style playback model. If
     * this option is set, the minreq value of the buffer metrics gets
     * a new meaning: instead of just specifying that no requests
     * asking for less new data than this value will be made to the
     * client it will also guarantee that requests are generated as
     * early as this limit is reached. This flag should only be set in
     * very few situations where compatibility with a fragment-based
     * playback model needs to be kept and the client applications
     * cannot deal with data requests that are delayed to the latest
     * moment possible. (Usually these are programs that use usleep()
     * or a similar call in their playback loops instead of sleeping
     * on the device itself.) Also see pa_buffer_attr. This option may
     * not be specified at the same time as
     * PA_STREAM_ADJUST_LATENCY. \since 0.9.12 */

    PA_STREAM_DONT_INHIBIT_AUTO_SUSPEND = 0x8000U,
    /**< If set this stream won't be taken into account when it is
     * checked whether the device this stream is connected to should
     * auto-suspend. \since 0.9.15 */

    PA_STREAM_START_UNMUTED = 0x10000U,
    /**< Create in unmuted state. If neither PA_STREAM_START_UNMUTED
     * nor PA_STREAM_START_MUTED are set it is left to the server to decide
     * whether to create the stream in muted or in unmuted
     * state. \since 0.9.15 */

    PA_STREAM_FAIL_ON_SUSPEND = 0x20000U,
    /**< If the sink/source this stream is connected to is suspended
     * during the creation of this stream, cause it to fail. If the
     * sink/source is being suspended during creation of this stream,
     * make sure this stream is terminated. \since 0.9.15 */

    PA_STREAM_RELATIVE_VOLUME = 0x40000U,
    /**< If a volume is passed when this stream is created, consider
     * it relative to the sink's current volume, never as absolute
     * device volume. If this is not specified the volume will be
     * consider absolute when the sink is in flat volume mode,
     * relative otherwise. \since 0.9.20 */

    PA_STREAM_PASSTHROUGH = 0x80000U
    /**< Used to tag content that will be rendered by passthrough sinks.
     * The data will be left as is and not reformatted, resampled.
     * \since 1.0 */
}

alias pa_stream_flags_t = pa_stream_flags;

/** \cond fulldocs */

/* English is an evil language */
enum PA_STREAM_NOT_MONOTONOUS = pa_stream_flags_t.PA_STREAM_NOT_MONOTONIC;

/* Allow clients to check with #ifdef for those flags */
enum PA_STREAM_START_CORKED = pa_stream_flags_t.PA_STREAM_START_CORKED;
enum PA_STREAM_INTERPOLATE_TIMING = pa_stream_flags_t.PA_STREAM_INTERPOLATE_TIMING;
enum PA_STREAM_NOT_MONOTONIC = pa_stream_flags_t.PA_STREAM_NOT_MONOTONIC;
enum PA_STREAM_AUTO_TIMING_UPDATE = pa_stream_flags_t.PA_STREAM_AUTO_TIMING_UPDATE;
enum PA_STREAM_NO_REMAP_CHANNELS = pa_stream_flags_t.PA_STREAM_NO_REMAP_CHANNELS;
enum PA_STREAM_NO_REMIX_CHANNELS = pa_stream_flags_t.PA_STREAM_NO_REMIX_CHANNELS;
enum PA_STREAM_FIX_FORMAT = pa_stream_flags_t.PA_STREAM_FIX_FORMAT;
enum PA_STREAM_FIX_RATE = pa_stream_flags_t.PA_STREAM_FIX_RATE;
enum PA_STREAM_FIX_CHANNELS = pa_stream_flags_t.PA_STREAM_FIX_CHANNELS;
enum PA_STREAM_DONT_MOVE = pa_stream_flags_t.PA_STREAM_DONT_MOVE;
enum PA_STREAM_VARIABLE_RATE = pa_stream_flags_t.PA_STREAM_VARIABLE_RATE;
enum PA_STREAM_PEAK_DETECT = pa_stream_flags_t.PA_STREAM_PEAK_DETECT;
enum PA_STREAM_START_MUTED = pa_stream_flags_t.PA_STREAM_START_MUTED;
enum PA_STREAM_ADJUST_LATENCY = pa_stream_flags_t.PA_STREAM_ADJUST_LATENCY;
enum PA_STREAM_EARLY_REQUESTS = pa_stream_flags_t.PA_STREAM_EARLY_REQUESTS;
enum PA_STREAM_DONT_INHIBIT_AUTO_SUSPEND = pa_stream_flags_t.PA_STREAM_DONT_INHIBIT_AUTO_SUSPEND;
enum PA_STREAM_START_UNMUTED = pa_stream_flags_t.PA_STREAM_START_UNMUTED;
enum PA_STREAM_FAIL_ON_SUSPEND = pa_stream_flags_t.PA_STREAM_FAIL_ON_SUSPEND;
enum PA_STREAM_RELATIVE_VOLUME = pa_stream_flags_t.PA_STREAM_RELATIVE_VOLUME;
enum PA_STREAM_PASSTHROUGH = pa_stream_flags_t.PA_STREAM_PASSTHROUGH;

/** \endcond */

/** Playback and record buffer metrics */
struct pa_buffer_attr
{
    uint maxlength;
    /**< Maximum length of the buffer in bytes. Setting this to (uint32_t) -1
     * will initialize this to the maximum value supported by server,
     * which is recommended.
     *
     * In strict low-latency playback scenarios you might want to set this to
     * a lower value, likely together with the PA_STREAM_ADJUST_LATENCY flag.
     * If you do so, you ensure that the latency doesn't grow beyond what is
     * acceptable for the use case, at the cost of getting more underruns if
     * the latency is lower than what the server can reliably handle. */

    uint tlength;
    /**< Playback only: target length of the buffer. The server tries
     * to assure that at least tlength bytes are always available in
     * the per-stream server-side playback buffer. The server will
     * only send requests for more data as long as the buffer has
     * less than this number of bytes of data.
     *
     * It is recommended to set this to (uint32_t) -1, which will
     * initialize this to a value that is deemed sensible by the
     * server. However, this value will default to something like 2s;
     * for applications that have specific latency requirements
     * this value should be set to the maximum latency that the
     * application can deal with.
     *
     * When PA_STREAM_ADJUST_LATENCY is not set this value will
     * influence only the per-stream playback buffer size. When
     * PA_STREAM_ADJUST_LATENCY is set the overall latency of the sink
     * plus the playback buffer size is configured to this value. Set
     * PA_STREAM_ADJUST_LATENCY if you are interested in adjusting the
     * overall latency. Don't set it if you are interested in
     * configuring the server-side per-stream playback buffer
     * size. */

    uint prebuf;
    /**< Playback only: pre-buffering. The server does not start with
     * playback before at least prebuf bytes are available in the
     * buffer. It is recommended to set this to (uint32_t) -1, which
     * will initialize this to the same value as tlength, whatever
     * that may be.
     *
     * Initialize to 0 to enable manual start/stop control of the stream.
     * This means that playback will not stop on underrun and playback
     * will not start automatically, instead pa_stream_cork() needs to
     * be called explicitly. If you set this value to 0 you should also
     * set PA_STREAM_START_CORKED. Should underrun occur, the read index
     * of the output buffer overtakes the write index, and hence the
     * fill level of the buffer is negative.
     *
     * Start of playback can be forced using pa_stream_trigger() even
     * though the prebuffer size hasn't been reached. If a buffer
     * underrun occurs, this prebuffering will be again enabled. */

    uint minreq;
    /**< Playback only: minimum request. The server does not request
     * less than minreq bytes from the client, instead waits until the
     * buffer is free enough to request more bytes at once. It is
     * recommended to set this to (uint32_t) -1, which will initialize
     * this to a value that is deemed sensible by the server. This
     * should be set to a value that gives PulseAudio enough time to
     * move the data from the per-stream playback buffer into the
     * hardware playback buffer. */

    uint fragsize;
    /**< Recording only: fragment size. The server sends data in
     * blocks of fragsize bytes size. Large values diminish
     * interactivity with other operations on the connection context
     * but decrease control overhead. It is recommended to set this to
     * (uint32_t) -1, which will initialize this to a value that is
     * deemed sensible by the server. However, this value will default
     * to something like 2s; For applications that have specific
     * latency requirements this value should be set to the maximum
     * latency that the application can deal with.
     *
     * If PA_STREAM_ADJUST_LATENCY is set the overall source latency
     * will be adjusted according to this value. If it is not set the
     * source latency is left unmodified. */
}

/** Error values as used by pa_context_errno(). Use pa_strerror() to convert these values to human readable strings */
enum pa_error_code
{
    PA_OK = 0, /**< No error */
    PA_ERR_ACCESS = 1, /**< Access failure */
    PA_ERR_COMMAND = 2, /**< Unknown command */
    PA_ERR_INVALID = 3, /**< Invalid argument */
    PA_ERR_EXIST = 4, /**< Entity exists */
    PA_ERR_NOENTITY = 5, /**< No such entity */
    PA_ERR_CONNECTIONREFUSED = 6, /**< Connection refused */
    PA_ERR_PROTOCOL = 7, /**< Protocol error */
    PA_ERR_TIMEOUT = 8, /**< Timeout */
    PA_ERR_AUTHKEY = 9, /**< No authentication key */
    PA_ERR_INTERNAL = 10, /**< Internal error */
    PA_ERR_CONNECTIONTERMINATED = 11, /**< Connection terminated */
    PA_ERR_KILLED = 12, /**< Entity killed */
    PA_ERR_INVALIDSERVER = 13, /**< Invalid server */
    PA_ERR_MODINITFAILED = 14, /**< Module initialization failed */
    PA_ERR_BADSTATE = 15, /**< Bad state */
    PA_ERR_NODATA = 16, /**< No data */
    PA_ERR_VERSION = 17, /**< Incompatible protocol version */
    PA_ERR_TOOLARGE = 18, /**< Data too large */
    PA_ERR_NOTSUPPORTED = 19, /**< Operation not supported \since 0.9.5 */
    PA_ERR_UNKNOWN = 20, /**< The error code was unknown to the client */
    PA_ERR_NOEXTENSION = 21, /**< Extension does not exist. \since 0.9.12 */
    PA_ERR_OBSOLETE = 22, /**< Obsolete functionality. \since 0.9.15 */
    PA_ERR_NOTIMPLEMENTED = 23, /**< Missing implementation. \since 0.9.15 */
    PA_ERR_FORKED = 24, /**< The caller forked without calling execve() and tried to reuse the context. \since 0.9.15 */
    PA_ERR_IO = 25, /**< An IO error happened. \since 0.9.16 */
    PA_ERR_BUSY = 26, /**< Device or resource busy. \since 0.9.17 */
    PA_ERR_MAX = 27 /**< Not really an error but the first invalid error code */
}

alias pa_error_code_t = pa_error_code;

/** \cond fulldocs */
enum PA_OK = pa_error_code_t.PA_OK;
enum PA_ERR_ACCESS = pa_error_code_t.PA_ERR_ACCESS;
enum PA_ERR_COMMAND = pa_error_code_t.PA_ERR_COMMAND;
enum PA_ERR_INVALID = pa_error_code_t.PA_ERR_INVALID;
enum PA_ERR_EXIST = pa_error_code_t.PA_ERR_EXIST;
enum PA_ERR_NOENTITY = pa_error_code_t.PA_ERR_NOENTITY;
enum PA_ERR_CONNECTIONREFUSED = pa_error_code_t.PA_ERR_CONNECTIONREFUSED;
enum PA_ERR_PROTOCOL = pa_error_code_t.PA_ERR_PROTOCOL;
enum PA_ERR_TIMEOUT = pa_error_code_t.PA_ERR_TIMEOUT;
enum PA_ERR_AUTHKEY = pa_error_code_t.PA_ERR_AUTHKEY;
enum PA_ERR_INTERNAL = pa_error_code_t.PA_ERR_INTERNAL;
enum PA_ERR_CONNECTIONTERMINATED = pa_error_code_t.PA_ERR_CONNECTIONTERMINATED;
enum PA_ERR_KILLED = pa_error_code_t.PA_ERR_KILLED;
enum PA_ERR_INVALIDSERVER = pa_error_code_t.PA_ERR_INVALIDSERVER;
enum PA_ERR_MODINITFAILED = pa_error_code_t.PA_ERR_MODINITFAILED;
enum PA_ERR_BADSTATE = pa_error_code_t.PA_ERR_BADSTATE;
enum PA_ERR_NODATA = pa_error_code_t.PA_ERR_NODATA;
enum PA_ERR_VERSION = pa_error_code_t.PA_ERR_VERSION;
enum PA_ERR_TOOLARGE = pa_error_code_t.PA_ERR_TOOLARGE;
enum PA_ERR_NOTSUPPORTED = pa_error_code_t.PA_ERR_NOTSUPPORTED;
enum PA_ERR_UNKNOWN = pa_error_code_t.PA_ERR_UNKNOWN;
enum PA_ERR_NOEXTENSION = pa_error_code_t.PA_ERR_NOEXTENSION;
enum PA_ERR_OBSOLETE = pa_error_code_t.PA_ERR_OBSOLETE;
enum PA_ERR_NOTIMPLEMENTED = pa_error_code_t.PA_ERR_NOTIMPLEMENTED;
enum PA_ERR_FORKED = pa_error_code_t.PA_ERR_FORKED;
enum PA_ERR_MAX = pa_error_code_t.PA_ERR_MAX;
/** \endcond */

/** Subscription event mask, as used by pa_context_subscribe() */
enum pa_subscription_mask
{
    PA_SUBSCRIPTION_MASK_NULL = 0x0000U,
    /**< No events */

    PA_SUBSCRIPTION_MASK_SINK = 0x0001U,
    /**< Sink events */

    PA_SUBSCRIPTION_MASK_SOURCE = 0x0002U,
    /**< Source events */

    PA_SUBSCRIPTION_MASK_SINK_INPUT = 0x0004U,
    /**< Sink input events */

    PA_SUBSCRIPTION_MASK_SOURCE_OUTPUT = 0x0008U,
    /**< Source output events */

    PA_SUBSCRIPTION_MASK_MODULE = 0x0010U,
    /**< Module events */

    PA_SUBSCRIPTION_MASK_CLIENT = 0x0020U,
    /**< Client events */

    PA_SUBSCRIPTION_MASK_SAMPLE_CACHE = 0x0040U,
    /**< Sample cache events */

    PA_SUBSCRIPTION_MASK_SERVER = 0x0080U,
    /**< Other global server changes. */

    /** \cond fulldocs */
    PA_SUBSCRIPTION_MASK_AUTOLOAD = 0x0100U,
    /**< \deprecated Autoload table events. */
    /** \endcond */

    PA_SUBSCRIPTION_MASK_CARD = 0x0200U,
    /**< Card events. \since 0.9.15 */

    PA_SUBSCRIPTION_MASK_ALL = 0x02ffU
    /**< Catch all events */
}

alias pa_subscription_mask_t = pa_subscription_mask;

/** Subscription event types, as used by pa_context_subscribe() */
enum pa_subscription_event_type
{
    PA_SUBSCRIPTION_EVENT_SINK = 0x0000U,
    /**< Event type: Sink */

    PA_SUBSCRIPTION_EVENT_SOURCE = 0x0001U,
    /**< Event type: Source */

    PA_SUBSCRIPTION_EVENT_SINK_INPUT = 0x0002U,
    /**< Event type: Sink input */

    PA_SUBSCRIPTION_EVENT_SOURCE_OUTPUT = 0x0003U,
    /**< Event type: Source output */

    PA_SUBSCRIPTION_EVENT_MODULE = 0x0004U,
    /**< Event type: Module */

    PA_SUBSCRIPTION_EVENT_CLIENT = 0x0005U,
    /**< Event type: Client */

    PA_SUBSCRIPTION_EVENT_SAMPLE_CACHE = 0x0006U,
    /**< Event type: Sample cache item */

    PA_SUBSCRIPTION_EVENT_SERVER = 0x0007U,
    /**< Event type: Global server change, only occurring with PA_SUBSCRIPTION_EVENT_CHANGE. */

    /** \cond fulldocs */
    PA_SUBSCRIPTION_EVENT_AUTOLOAD = 0x0008U,
    /**< \deprecated Event type: Autoload table changes. */
    /** \endcond */

    PA_SUBSCRIPTION_EVENT_CARD = 0x0009U,
    /**< Event type: Card \since 0.9.15 */

    PA_SUBSCRIPTION_EVENT_FACILITY_MASK = 0x000FU,
    /**< A mask to extract the event type from an event value */

    PA_SUBSCRIPTION_EVENT_NEW = 0x0000U,
    /**< A new object was created */

    PA_SUBSCRIPTION_EVENT_CHANGE = 0x0010U,
    /**< A property of the object was modified */

    PA_SUBSCRIPTION_EVENT_REMOVE = 0x0020U,
    /**< An object was removed */

    PA_SUBSCRIPTION_EVENT_TYPE_MASK = 0x0030U
    /**< A mask to extract the event operation from an event value */
}

alias pa_subscription_event_type_t = pa_subscription_event_type;

/** Return one if an event type t matches an event mask bitfield */
extern (D) auto pa_subscription_match_flags(T0, T1)(auto ref T0 m, auto ref T1 t)
{
    return !!(m & (1 << (t & pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_FACILITY_MASK)));
}

/** \cond fulldocs */
enum PA_SUBSCRIPTION_MASK_NULL = pa_subscription_mask_t.PA_SUBSCRIPTION_MASK_NULL;
enum PA_SUBSCRIPTION_MASK_SINK = pa_subscription_mask_t.PA_SUBSCRIPTION_MASK_SINK;
enum PA_SUBSCRIPTION_MASK_SOURCE = pa_subscription_mask_t.PA_SUBSCRIPTION_MASK_SOURCE;
enum PA_SUBSCRIPTION_MASK_SINK_INPUT = pa_subscription_mask_t.PA_SUBSCRIPTION_MASK_SINK_INPUT;
enum PA_SUBSCRIPTION_MASK_SOURCE_OUTPUT = pa_subscription_mask_t.PA_SUBSCRIPTION_MASK_SOURCE_OUTPUT;
enum PA_SUBSCRIPTION_MASK_MODULE = pa_subscription_mask_t.PA_SUBSCRIPTION_MASK_MODULE;
enum PA_SUBSCRIPTION_MASK_CLIENT = pa_subscription_mask_t.PA_SUBSCRIPTION_MASK_CLIENT;
enum PA_SUBSCRIPTION_MASK_SAMPLE_CACHE = pa_subscription_mask_t.PA_SUBSCRIPTION_MASK_SAMPLE_CACHE;
enum PA_SUBSCRIPTION_MASK_SERVER = pa_subscription_mask_t.PA_SUBSCRIPTION_MASK_SERVER;
enum PA_SUBSCRIPTION_MASK_AUTOLOAD = pa_subscription_mask_t.PA_SUBSCRIPTION_MASK_AUTOLOAD;
enum PA_SUBSCRIPTION_MASK_CARD = pa_subscription_mask_t.PA_SUBSCRIPTION_MASK_CARD;
enum PA_SUBSCRIPTION_MASK_ALL = pa_subscription_mask_t.PA_SUBSCRIPTION_MASK_ALL;
enum PA_SUBSCRIPTION_EVENT_SINK = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_SINK;
enum PA_SUBSCRIPTION_EVENT_SOURCE = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_SOURCE;
enum PA_SUBSCRIPTION_EVENT_SINK_INPUT = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_SINK_INPUT;
enum PA_SUBSCRIPTION_EVENT_SOURCE_OUTPUT = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_SOURCE_OUTPUT;
enum PA_SUBSCRIPTION_EVENT_MODULE = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_MODULE;
enum PA_SUBSCRIPTION_EVENT_CLIENT = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_CLIENT;
enum PA_SUBSCRIPTION_EVENT_SAMPLE_CACHE = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_SAMPLE_CACHE;
enum PA_SUBSCRIPTION_EVENT_SERVER = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_SERVER;
enum PA_SUBSCRIPTION_EVENT_AUTOLOAD = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_AUTOLOAD;
enum PA_SUBSCRIPTION_EVENT_CARD = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_CARD;
enum PA_SUBSCRIPTION_EVENT_FACILITY_MASK = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_FACILITY_MASK;
enum PA_SUBSCRIPTION_EVENT_NEW = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_NEW;
enum PA_SUBSCRIPTION_EVENT_CHANGE = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_CHANGE;
enum PA_SUBSCRIPTION_EVENT_REMOVE = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_REMOVE;
enum PA_SUBSCRIPTION_EVENT_TYPE_MASK = pa_subscription_event_type_t.PA_SUBSCRIPTION_EVENT_TYPE_MASK;
/** \endcond */

/** A structure for all kinds of timing information of a stream. See
 * pa_stream_update_timing_info() and pa_stream_get_timing_info(). The
 * total output latency a sample that is written with
 * pa_stream_write() takes to be played may be estimated by
 * sink_usec+buffer_usec+transport_usec (where buffer_usec is defined
 * as pa_bytes_to_usec(write_index-read_index)). The output buffer
 * which buffer_usec relates to may be manipulated freely (with
 * pa_stream_write()'s seek argument, pa_stream_flush() and friends),
 * the buffers sink_usec and source_usec relate to are first-in
 * first-out (FIFO) buffers which cannot be flushed or manipulated in
 * any way. The total input latency a sample that is recorded takes to
 * be delivered to the application is:
 * source_usec+buffer_usec+transport_usec-sink_usec. (Take care of
 * sign issues!) When connected to a monitor source sink_usec contains
 * the latency of the owning sink. The two latency estimations
 * described here are implemented in pa_stream_get_latency().
 *
 * All time values are in the sound card clock domain, unless noted
 * otherwise. The sound card clock usually runs at a slightly different
 * rate than the system clock.
 *
 * Please note that this structure can be extended as part of evolutionary
 * API updates at any time in any new release.
 * */
struct pa_timing_info
{
    timeval timestamp;
    /**< The system clock time when this timing info structure was
     * current. */

    int synchronized_clocks;
    /**< Non-zero if the local and the remote machine have
     * synchronized clocks. If synchronized clocks are detected
     * transport_usec becomes much more reliable. However, the code
     * that detects synchronized clocks is very limited and unreliable
     * itself. */

    pa_usec_t sink_usec;
    /**< Time in usecs a sample takes to be played on the sink. For
     * playback streams and record streams connected to a monitor
     * source. */

    pa_usec_t source_usec;
    /**< Time in usecs a sample takes from being recorded to being
     * delivered to the application. Only for record streams. */

    pa_usec_t transport_usec;
    /**< Estimated time in usecs a sample takes to be transferred
     * to/from the daemon. For both playback and record streams. */

    int playing;
    /**< Non-zero when the stream is currently not underrun and data
     * is being passed on to the device. Only for playback
     * streams. This field does not say whether the data is actually
     * already being played. To determine this check whether
     * since_underrun (converted to usec) is larger than sink_usec.*/

    int write_index_corrupt;
    /**< Non-zero if write_index is not up-to-date because a local
     * write command that corrupted it has been issued in the time
     * since this latency info was current . Only write commands with
     * SEEK_RELATIVE_ON_READ and SEEK_RELATIVE_END can corrupt
     * write_index. */

    long write_index;
    /**< Current write index into the playback buffer in bytes. Think
     * twice before using this for seeking purposes: it might be out
     * of date at the time you want to use it. Consider using
     * PA_SEEK_RELATIVE instead. */

    int read_index_corrupt;
    /**< Non-zero if read_index is not up-to-date because a local
     * pause or flush request that corrupted it has been issued in the
     * time since this latency info was current. */

    long read_index;
    /**< Current read index into the playback buffer in bytes. Think
     * twice before using this for seeking purposes: it might be out
     * of date at the time you want to use it. Consider using
     * PA_SEEK_RELATIVE_ON_READ instead. */

    pa_usec_t configured_sink_usec;
    /**< The configured latency for the sink. \since 0.9.11 */

    pa_usec_t configured_source_usec;
    /**< The configured latency for the source. \since 0.9.11 */

    long since_underrun;
    /**< Bytes that were handed to the sink since the last underrun
     * happened, or since playback started again after the last
     * underrun. playing will tell you which case it is. \since
     * 0.9.11 */
}

/** A structure for the spawn api. This may be used to integrate auto
 * spawned daemons into your application. For more information see
 * pa_context_connect(). When spawning a new child process the
 * waitpid() is used on the child's PID. The spawn routine will not
 * block or ignore SIGCHLD signals, since this cannot be done in a
 * thread compatible way. You might have to do this in
 * prefork/postfork. */
struct pa_spawn_api
{
    void function () prefork;
    /**< Is called just before the fork in the parent process. May be
     * NULL. */

    void function () postfork;
    /**< Is called immediately after the fork in the parent
     * process. May be NULL.*/

    void function () atfork;
    /**< Is called immediately after the fork in the child
     * process. May be NULL. It is not safe to close all file
     * descriptors in this function unconditionally, since a UNIX
     * socket (created using socketpair()) is passed to the new
     * process. */
}

/** Seek type for pa_stream_write(). */
enum pa_seek_mode
{
    PA_SEEK_RELATIVE = 0,
    /**< Seek relative to the write index. */

    PA_SEEK_ABSOLUTE = 1,
    /**< Seek relative to the start of the buffer queue. */

    PA_SEEK_RELATIVE_ON_READ = 2,
    /**< Seek relative to the read index. */

    PA_SEEK_RELATIVE_END = 3
    /**< Seek relative to the current end of the buffer queue. */
}

alias pa_seek_mode_t = pa_seek_mode;

/** \cond fulldocs */
enum PA_SEEK_RELATIVE = pa_seek_mode_t.PA_SEEK_RELATIVE;
enum PA_SEEK_ABSOLUTE = pa_seek_mode_t.PA_SEEK_ABSOLUTE;
enum PA_SEEK_RELATIVE_ON_READ = pa_seek_mode_t.PA_SEEK_RELATIVE_ON_READ;
enum PA_SEEK_RELATIVE_END = pa_seek_mode_t.PA_SEEK_RELATIVE_END;
/** \endcond */

/** Special sink flags. */
enum pa_sink_flags
{
    PA_SINK_NOFLAGS = 0x0000U,
    /**< Flag to pass when no specific options are needed (used to avoid casting)  \since 0.9.19 */

    PA_SINK_HW_VOLUME_CTRL = 0x0001U,
    /**< Supports hardware volume control. This is a dynamic flag and may
     * change at runtime after the sink has initialized */

    PA_SINK_LATENCY = 0x0002U,
    /**< Supports latency querying */

    PA_SINK_HARDWARE = 0x0004U,
    /**< Is a hardware sink of some kind, in contrast to
     * "virtual"/software sinks \since 0.9.3 */

    PA_SINK_NETWORK = 0x0008U,
    /**< Is a networked sink of some kind. \since 0.9.7 */

    PA_SINK_HW_MUTE_CTRL = 0x0010U,
    /**< Supports hardware mute control. This is a dynamic flag and may
     * change at runtime after the sink has initialized \since 0.9.11 */

    PA_SINK_DECIBEL_VOLUME = 0x0020U,
    /**< Volume can be translated to dB with pa_sw_volume_to_dB(). This is a
     * dynamic flag and may change at runtime after the sink has initialized
     * \since 0.9.11 */

    PA_SINK_FLAT_VOLUME = 0x0040U,
    /**< This sink is in flat volume mode, i.e.\ always the maximum of
     * the volume of all connected inputs. \since 0.9.15 */

    PA_SINK_DYNAMIC_LATENCY = 0x0080U,
    /**< The latency can be adjusted dynamically depending on the
     * needs of the connected streams. \since 0.9.15 */

    PA_SINK_SET_FORMATS = 0x0100U
    /**< The sink allows setting what formats are supported by the connected
     * hardware. The actual functionality to do this might be provided by an
     * extension. \since 1.0 */

    /** \cond fulldocs */
    /* PRIVATE: Server-side values -- do not try to use these at client-side.
     * The server will filter out these flags anyway, so you should never see
     * these flags in sinks. */

    /**< This sink shares the volume with the master sink (used by some filter
     * sinks). */

    /**< The HW volume changes are syncronized with SW volume. */
    /** \endcond */
}

alias pa_sink_flags_t = pa_sink_flags;

/** \cond fulldocs */
enum PA_SINK_HW_VOLUME_CTRL = pa_sink_flags_t.PA_SINK_HW_VOLUME_CTRL;
enum PA_SINK_LATENCY = pa_sink_flags_t.PA_SINK_LATENCY;
enum PA_SINK_HARDWARE = pa_sink_flags_t.PA_SINK_HARDWARE;
enum PA_SINK_NETWORK = pa_sink_flags_t.PA_SINK_NETWORK;
enum PA_SINK_HW_MUTE_CTRL = pa_sink_flags_t.PA_SINK_HW_MUTE_CTRL;
enum PA_SINK_DECIBEL_VOLUME = pa_sink_flags_t.PA_SINK_DECIBEL_VOLUME;
enum PA_SINK_FLAT_VOLUME = pa_sink_flags_t.PA_SINK_FLAT_VOLUME;
enum PA_SINK_DYNAMIC_LATENCY = pa_sink_flags_t.PA_SINK_DYNAMIC_LATENCY;
enum PA_SINK_SET_FORMATS = pa_sink_flags_t.PA_SINK_SET_FORMATS;

/** \endcond */

/** Sink state. \since 0.9.15 */
enum pa_sink_state
{
    /* enum serialized in u8 */
    PA_SINK_INVALID_STATE = -1,
    /**< This state is used when the server does not support sink state introspection \since 0.9.15 */

    PA_SINK_RUNNING = 0,
    /**< Running, sink is playing and used by at least one non-corked sink-input \since 0.9.15 */

    PA_SINK_IDLE = 1,
    /**< When idle, the sink is playing but there is no non-corked sink-input attached to it \since 0.9.15 */

    PA_SINK_SUSPENDED = 2,
    /**< When suspended, actual sink access can be closed, for instance \since 0.9.15 */

    /** \cond fulldocs */
    /* PRIVATE: Server-side values -- DO NOT USE THIS ON THE CLIENT
     * SIDE! These values are *not* considered part of the official PA
     * API/ABI. If you use them your application might break when PA
     * is upgraded. Also, please note that these values are not useful
     * on the client side anyway. */

    PA_SINK_INIT = -2,
    /**< Initialization state */

    PA_SINK_UNLINKED = -3
    /**< The state when the sink is getting unregistered and removed from client access */
    /** \endcond */
}

alias pa_sink_state_t = pa_sink_state;

/** Returns non-zero if sink is playing: running or idle. \since 0.9.15 */
int PA_SINK_IS_OPENED (pa_sink_state_t x);

/** Returns non-zero if sink is running. \since 1.0 */
int PA_SINK_IS_RUNNING (pa_sink_state_t x);

/** \cond fulldocs */
enum PA_SINK_INVALID_STATE = pa_sink_state_t.PA_SINK_INVALID_STATE;
enum PA_SINK_RUNNING = pa_sink_state_t.PA_SINK_RUNNING;
enum PA_SINK_IDLE = pa_sink_state_t.PA_SINK_IDLE;
enum PA_SINK_SUSPENDED = pa_sink_state_t.PA_SINK_SUSPENDED;
enum PA_SINK_INIT = pa_sink_state_t.PA_SINK_INIT;
enum PA_SINK_UNLINKED = pa_sink_state_t.PA_SINK_UNLINKED;
// enum PA_SINK_IS_OPENED = PA_SINK_IS_OPENED;
/** \endcond */

/** Special source flags.  */
enum pa_source_flags
{
    PA_SOURCE_NOFLAGS = 0x0000U,
    /**< Flag to pass when no specific options are needed (used to avoid casting)  \since 0.9.19 */

    PA_SOURCE_HW_VOLUME_CTRL = 0x0001U,
    /**< Supports hardware volume control. This is a dynamic flag and may
     * change at runtime after the source has initialized */

    PA_SOURCE_LATENCY = 0x0002U,
    /**< Supports latency querying */

    PA_SOURCE_HARDWARE = 0x0004U,
    /**< Is a hardware source of some kind, in contrast to
     * "virtual"/software source \since 0.9.3 */

    PA_SOURCE_NETWORK = 0x0008U,
    /**< Is a networked source of some kind. \since 0.9.7 */

    PA_SOURCE_HW_MUTE_CTRL = 0x0010U,
    /**< Supports hardware mute control. This is a dynamic flag and may
     * change at runtime after the source has initialized \since 0.9.11 */

    PA_SOURCE_DECIBEL_VOLUME = 0x0020U,
    /**< Volume can be translated to dB with pa_sw_volume_to_dB(). This is a
     * dynamic flag and may change at runtime after the source has initialized
     * \since 0.9.11 */

    PA_SOURCE_DYNAMIC_LATENCY = 0x0040U,
    /**< The latency can be adjusted dynamically depending on the
     * needs of the connected streams. \since 0.9.15 */

    PA_SOURCE_FLAT_VOLUME = 0x0080U
    /**< This source is in flat volume mode, i.e.\ always the maximum of
     * the volume of all connected outputs. \since 1.0 */

    /** \cond fulldocs */
    /* PRIVATE: Server-side values -- do not try to use these at client-side.
     * The server will filter out these flags anyway, so you should never see
     * these flags in sources. */

    /**< This source shares the volume with the master source (used by some filter
     * sources). */

    /**< The HW volume changes are syncronized with SW volume. */
}

alias pa_source_flags_t = pa_source_flags;

/** \cond fulldocs */
enum PA_SOURCE_HW_VOLUME_CTRL = pa_source_flags_t.PA_SOURCE_HW_VOLUME_CTRL;
enum PA_SOURCE_LATENCY = pa_source_flags_t.PA_SOURCE_LATENCY;
enum PA_SOURCE_HARDWARE = pa_source_flags_t.PA_SOURCE_HARDWARE;
enum PA_SOURCE_NETWORK = pa_source_flags_t.PA_SOURCE_NETWORK;
enum PA_SOURCE_HW_MUTE_CTRL = pa_source_flags_t.PA_SOURCE_HW_MUTE_CTRL;
enum PA_SOURCE_DECIBEL_VOLUME = pa_source_flags_t.PA_SOURCE_DECIBEL_VOLUME;
enum PA_SOURCE_DYNAMIC_LATENCY = pa_source_flags_t.PA_SOURCE_DYNAMIC_LATENCY;
enum PA_SOURCE_FLAT_VOLUME = pa_source_flags_t.PA_SOURCE_FLAT_VOLUME;

/** \endcond */

/** Source state. \since 0.9.15 */
enum pa_source_state
{
    PA_SOURCE_INVALID_STATE = -1,
    /**< This state is used when the server does not support source state introspection \since 0.9.15 */

    PA_SOURCE_RUNNING = 0,
    /**< Running, source is recording and used by at least one non-corked source-output \since 0.9.15 */

    PA_SOURCE_IDLE = 1,
    /**< When idle, the source is still recording but there is no non-corked source-output \since 0.9.15 */

    PA_SOURCE_SUSPENDED = 2,
    /**< When suspended, actual source access can be closed, for instance \since 0.9.15 */

    /** \cond fulldocs */
    /* PRIVATE: Server-side values -- DO NOT USE THIS ON THE CLIENT
     * SIDE! These values are *not* considered part of the official PA
     * API/ABI. If you use them your application might break when PA
     * is upgraded. Also, please note that these values are not useful
     * on the client side anyway. */

    PA_SOURCE_INIT = -2,
    /**< Initialization state */

    PA_SOURCE_UNLINKED = -3
    /**< The state when the source is getting unregistered and removed from client access */
    /** \endcond */
}

alias pa_source_state_t = pa_source_state;

/** Returns non-zero if source is recording: running or idle. \since 0.9.15 */
int PA_SOURCE_IS_OPENED (pa_source_state_t x);

/** Returns non-zero if source is running \since 1.0 */
int PA_SOURCE_IS_RUNNING (pa_source_state_t x);

/** \cond fulldocs */
enum PA_SOURCE_INVALID_STATE = pa_source_state_t.PA_SOURCE_INVALID_STATE;
enum PA_SOURCE_RUNNING = pa_source_state_t.PA_SOURCE_RUNNING;
enum PA_SOURCE_IDLE = pa_source_state_t.PA_SOURCE_IDLE;
enum PA_SOURCE_SUSPENDED = pa_source_state_t.PA_SOURCE_SUSPENDED;
enum PA_SOURCE_INIT = pa_source_state_t.PA_SOURCE_INIT;
enum PA_SOURCE_UNLINKED = pa_source_state_t.PA_SOURCE_UNLINKED;
// enum PA_SOURCE_IS_OPENED = PA_SOURCE_IS_OPENED;
/** \endcond */

/** A generic free() like callback prototype */
alias pa_free_cb_t = void function (void* p);

/** A stream policy/meta event requesting that an application should
 * cork a specific stream. See pa_stream_event_cb_t for more
 * information. \since 0.9.15 */
enum PA_STREAM_EVENT_REQUEST_CORK = "request-cork";

/** A stream policy/meta event requesting that an application should
 * cork a specific stream. See pa_stream_event_cb_t for more
 * information, \since 0.9.15 */
enum PA_STREAM_EVENT_REQUEST_UNCORK = "request-uncork";

/** A stream event notifying that the stream is going to be
 * disconnected because the underlying sink changed and no longer
 * supports the format that was originally negotiated. Clients need
 * to connect a new stream to renegotiate a format and continue
 * playback. \since 1.0 */
enum PA_STREAM_EVENT_FORMAT_LOST = "format-lost";

/** Port availability / jack detection status
 * \since 2.0 */
enum pa_port_available
{
    PA_PORT_AVAILABLE_UNKNOWN = 0, /**< This port does not support jack detection \since 2.0 */
    PA_PORT_AVAILABLE_NO = 1, /**< This port is not available, likely because the jack is not plugged in. \since 2.0 */
    PA_PORT_AVAILABLE_YES = 2 /**< This port is available, likely because the jack is plugged in. \since 2.0 */
}

alias pa_port_available_t = pa_port_available;

/** \cond fulldocs */
enum PA_PORT_AVAILABLE_UNKNOWN = pa_port_available_t.PA_PORT_AVAILABLE_UNKNOWN;
enum PA_PORT_AVAILABLE_NO = pa_port_available_t.PA_PORT_AVAILABLE_NO;
enum PA_PORT_AVAILABLE_YES = pa_port_available_t.PA_PORT_AVAILABLE_YES;

/** \endcond */

/** Port type. New types can be added in the future, so applications should
 * gracefully handle situations where a type identifier doesn't match any item
 * in this enumeration. \since 14.0 */
enum pa_device_port_type
{
    PA_DEVICE_PORT_TYPE_UNKNOWN = 0,
    PA_DEVICE_PORT_TYPE_AUX = 1,
    PA_DEVICE_PORT_TYPE_SPEAKER = 2,
    PA_DEVICE_PORT_TYPE_HEADPHONES = 3,
    PA_DEVICE_PORT_TYPE_LINE = 4,
    PA_DEVICE_PORT_TYPE_MIC = 5,
    PA_DEVICE_PORT_TYPE_HEADSET = 6,
    PA_DEVICE_PORT_TYPE_HANDSET = 7,
    PA_DEVICE_PORT_TYPE_EARPIECE = 8,
    PA_DEVICE_PORT_TYPE_SPDIF = 9,
    PA_DEVICE_PORT_TYPE_HDMI = 10,
    PA_DEVICE_PORT_TYPE_TV = 11,
    PA_DEVICE_PORT_TYPE_RADIO = 12,
    PA_DEVICE_PORT_TYPE_VIDEO = 13,
    PA_DEVICE_PORT_TYPE_USB = 14,
    PA_DEVICE_PORT_TYPE_BLUETOOTH = 15,
    PA_DEVICE_PORT_TYPE_PORTABLE = 16,
    PA_DEVICE_PORT_TYPE_HANDSFREE = 17,
    PA_DEVICE_PORT_TYPE_CAR = 18,
    PA_DEVICE_PORT_TYPE_HIFI = 19,
    PA_DEVICE_PORT_TYPE_PHONE = 20,
    PA_DEVICE_PORT_TYPE_NETWORK = 21,
    PA_DEVICE_PORT_TYPE_ANALOG = 22
}

alias pa_device_port_type_t = pa_device_port_type;

