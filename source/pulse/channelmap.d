module pulse.channelmap;

version(linux):

import core.stdc.config;

import pulse.sample;

extern (C):

/***
  This file is part of PulseAudio.

  Copyright 2005-2006 Lennart Poettering
  Copyright 2006 Pierre Ossman <ossman@cendio.se> for Cendio AB

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

/** \page channelmap Channel Maps
 *
 * \section overv_sec Overview
 *
 * Channel maps provide a way to associate channels in a stream with a
 * specific speaker position. This relieves applications of having to
 * make sure their channel order is identical to the final output.
 *
 * \section init_sec Initialisation
 *
 * A channel map consists of an array of \ref pa_channel_position values,
 * one for each channel. This array is stored together with a channel count
 * in a pa_channel_map structure.
 *
 * Before filling the structure, the application must initialise it using
 * pa_channel_map_init(). There are also a number of convenience functions
 * for standard channel mappings:
 *
 * \li pa_channel_map_init_mono() - Create a channel map with only mono audio.
 * \li pa_channel_map_init_stereo() - Create a standard stereo mapping.
 * \li pa_channel_map_init_auto() - Create a standard channel map for a specific
 *                                  number of channels.
 * \li pa_channel_map_init_extend() - Similar to pa_channel_map_init_auto() but
 *                                    synthesize a channel map if no predefined
 *                                    one is known for the specified number of
 *                                    channels.
 *
 * \section conv_sec Convenience Functions
 *
 * The library contains a number of convenience functions for dealing with
 * channel maps:
 *
 * \li pa_channel_map_valid() - Tests if a channel map is valid.
 * \li pa_channel_map_equal() - Tests if two channel maps are identical.
 * \li pa_channel_map_snprint() - Creates a textual description of a channel
 *                                map.
 */

/** \file
 * Constants and routines for channel mapping handling
 *
 * See also \subpage channelmap
 */

/** A list of channel labels */
enum pa_channel_position
{
    PA_CHANNEL_POSITION_INVALID = -1,
    PA_CHANNEL_POSITION_MONO = 0,

    PA_CHANNEL_POSITION_FRONT_LEFT = 1, /**< Apple, Dolby call this 'Left' */
    PA_CHANNEL_POSITION_FRONT_RIGHT = 2, /**< Apple, Dolby call this 'Right' */
    PA_CHANNEL_POSITION_FRONT_CENTER = 3, /**< Apple, Dolby call this 'Center' */

    /** \cond fulldocs */
    PA_CHANNEL_POSITION_LEFT = PA_CHANNEL_POSITION_FRONT_LEFT,
    PA_CHANNEL_POSITION_RIGHT = PA_CHANNEL_POSITION_FRONT_RIGHT,
    PA_CHANNEL_POSITION_CENTER = PA_CHANNEL_POSITION_FRONT_CENTER,
    /** \endcond */

    PA_CHANNEL_POSITION_REAR_CENTER = 4, /**< Microsoft calls this 'Back Center', Apple calls this 'Center Surround', Dolby calls this 'Surround Rear Center' */
    PA_CHANNEL_POSITION_REAR_LEFT = 5, /**< Microsoft calls this 'Back Left', Apple calls this 'Left Surround' (!), Dolby calls this 'Surround Rear Left'  */
    PA_CHANNEL_POSITION_REAR_RIGHT = 6, /**< Microsoft calls this 'Back Right', Apple calls this 'Right Surround' (!), Dolby calls this 'Surround Rear Right'  */

    PA_CHANNEL_POSITION_LFE = 7, /**< Microsoft calls this 'Low Frequency', Apple calls this 'LFEScreen' */
    /** \cond fulldocs */
    PA_CHANNEL_POSITION_SUBWOOFER = PA_CHANNEL_POSITION_LFE,
    /** \endcond */

    PA_CHANNEL_POSITION_FRONT_LEFT_OF_CENTER = 8, /**< Apple, Dolby call this 'Left Center' */
    PA_CHANNEL_POSITION_FRONT_RIGHT_OF_CENTER = 9, /**< Apple, Dolby call this 'Right Center */

    PA_CHANNEL_POSITION_SIDE_LEFT = 10, /**< Apple calls this 'Left Surround Direct', Dolby calls this 'Surround Left' (!) */
    PA_CHANNEL_POSITION_SIDE_RIGHT = 11, /**< Apple calls this 'Right Surround Direct', Dolby calls this 'Surround Right' (!) */

    PA_CHANNEL_POSITION_AUX0 = 12,
    PA_CHANNEL_POSITION_AUX1 = 13,
    PA_CHANNEL_POSITION_AUX2 = 14,
    PA_CHANNEL_POSITION_AUX3 = 15,
    PA_CHANNEL_POSITION_AUX4 = 16,
    PA_CHANNEL_POSITION_AUX5 = 17,
    PA_CHANNEL_POSITION_AUX6 = 18,
    PA_CHANNEL_POSITION_AUX7 = 19,
    PA_CHANNEL_POSITION_AUX8 = 20,
    PA_CHANNEL_POSITION_AUX9 = 21,
    PA_CHANNEL_POSITION_AUX10 = 22,
    PA_CHANNEL_POSITION_AUX11 = 23,
    PA_CHANNEL_POSITION_AUX12 = 24,
    PA_CHANNEL_POSITION_AUX13 = 25,
    PA_CHANNEL_POSITION_AUX14 = 26,
    PA_CHANNEL_POSITION_AUX15 = 27,
    PA_CHANNEL_POSITION_AUX16 = 28,
    PA_CHANNEL_POSITION_AUX17 = 29,
    PA_CHANNEL_POSITION_AUX18 = 30,
    PA_CHANNEL_POSITION_AUX19 = 31,
    PA_CHANNEL_POSITION_AUX20 = 32,
    PA_CHANNEL_POSITION_AUX21 = 33,
    PA_CHANNEL_POSITION_AUX22 = 34,
    PA_CHANNEL_POSITION_AUX23 = 35,
    PA_CHANNEL_POSITION_AUX24 = 36,
    PA_CHANNEL_POSITION_AUX25 = 37,
    PA_CHANNEL_POSITION_AUX26 = 38,
    PA_CHANNEL_POSITION_AUX27 = 39,
    PA_CHANNEL_POSITION_AUX28 = 40,
    PA_CHANNEL_POSITION_AUX29 = 41,
    PA_CHANNEL_POSITION_AUX30 = 42,
    PA_CHANNEL_POSITION_AUX31 = 43,

    PA_CHANNEL_POSITION_TOP_CENTER = 44, /**< Apple calls this 'Top Center Surround' */

    PA_CHANNEL_POSITION_TOP_FRONT_LEFT = 45, /**< Apple calls this 'Vertical Height Left' */
    PA_CHANNEL_POSITION_TOP_FRONT_RIGHT = 46, /**< Apple calls this 'Vertical Height Right' */
    PA_CHANNEL_POSITION_TOP_FRONT_CENTER = 47, /**< Apple calls this 'Vertical Height Center' */

    PA_CHANNEL_POSITION_TOP_REAR_LEFT = 48, /**< Microsoft and Apple call this 'Top Back Left' */
    PA_CHANNEL_POSITION_TOP_REAR_RIGHT = 49, /**< Microsoft and Apple call this 'Top Back Right' */
    PA_CHANNEL_POSITION_TOP_REAR_CENTER = 50, /**< Microsoft and Apple call this 'Top Back Center' */

    PA_CHANNEL_POSITION_MAX = 51
}

alias pa_channel_position_t = pa_channel_position;

/** \cond fulldocs */
enum PA_CHANNEL_POSITION_INVALID = pa_channel_position_t.PA_CHANNEL_POSITION_INVALID;
enum PA_CHANNEL_POSITION_MONO = pa_channel_position_t.PA_CHANNEL_POSITION_MONO;
enum PA_CHANNEL_POSITION_LEFT = pa_channel_position_t.PA_CHANNEL_POSITION_LEFT;
enum PA_CHANNEL_POSITION_RIGHT = pa_channel_position_t.PA_CHANNEL_POSITION_RIGHT;
enum PA_CHANNEL_POSITION_CENTER = pa_channel_position_t.PA_CHANNEL_POSITION_CENTER;
enum PA_CHANNEL_POSITION_FRONT_LEFT = pa_channel_position_t.PA_CHANNEL_POSITION_FRONT_LEFT;
enum PA_CHANNEL_POSITION_FRONT_RIGHT = pa_channel_position_t.PA_CHANNEL_POSITION_FRONT_RIGHT;
enum PA_CHANNEL_POSITION_FRONT_CENTER = pa_channel_position_t.PA_CHANNEL_POSITION_FRONT_CENTER;
enum PA_CHANNEL_POSITION_REAR_CENTER = pa_channel_position_t.PA_CHANNEL_POSITION_REAR_CENTER;
enum PA_CHANNEL_POSITION_REAR_LEFT = pa_channel_position_t.PA_CHANNEL_POSITION_REAR_LEFT;
enum PA_CHANNEL_POSITION_REAR_RIGHT = pa_channel_position_t.PA_CHANNEL_POSITION_REAR_RIGHT;
enum PA_CHANNEL_POSITION_LFE = pa_channel_position_t.PA_CHANNEL_POSITION_LFE;
enum PA_CHANNEL_POSITION_SUBWOOFER = pa_channel_position_t.PA_CHANNEL_POSITION_SUBWOOFER;
enum PA_CHANNEL_POSITION_FRONT_LEFT_OF_CENTER = pa_channel_position_t.PA_CHANNEL_POSITION_FRONT_LEFT_OF_CENTER;
enum PA_CHANNEL_POSITION_FRONT_RIGHT_OF_CENTER = pa_channel_position_t.PA_CHANNEL_POSITION_FRONT_RIGHT_OF_CENTER;
enum PA_CHANNEL_POSITION_SIDE_LEFT = pa_channel_position_t.PA_CHANNEL_POSITION_SIDE_LEFT;
enum PA_CHANNEL_POSITION_SIDE_RIGHT = pa_channel_position_t.PA_CHANNEL_POSITION_SIDE_RIGHT;
enum PA_CHANNEL_POSITION_AUX0 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX0;
enum PA_CHANNEL_POSITION_AUX1 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX1;
enum PA_CHANNEL_POSITION_AUX2 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX2;
enum PA_CHANNEL_POSITION_AUX3 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX3;
enum PA_CHANNEL_POSITION_AUX4 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX4;
enum PA_CHANNEL_POSITION_AUX5 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX5;
enum PA_CHANNEL_POSITION_AUX6 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX6;
enum PA_CHANNEL_POSITION_AUX7 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX7;
enum PA_CHANNEL_POSITION_AUX8 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX8;
enum PA_CHANNEL_POSITION_AUX9 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX9;
enum PA_CHANNEL_POSITION_AUX10 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX10;
enum PA_CHANNEL_POSITION_AUX11 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX11;
enum PA_CHANNEL_POSITION_AUX12 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX12;
enum PA_CHANNEL_POSITION_AUX13 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX13;
enum PA_CHANNEL_POSITION_AUX14 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX14;
enum PA_CHANNEL_POSITION_AUX15 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX15;
enum PA_CHANNEL_POSITION_AUX16 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX16;
enum PA_CHANNEL_POSITION_AUX17 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX17;
enum PA_CHANNEL_POSITION_AUX18 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX18;
enum PA_CHANNEL_POSITION_AUX19 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX19;
enum PA_CHANNEL_POSITION_AUX20 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX20;
enum PA_CHANNEL_POSITION_AUX21 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX21;
enum PA_CHANNEL_POSITION_AUX22 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX22;
enum PA_CHANNEL_POSITION_AUX23 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX23;
enum PA_CHANNEL_POSITION_AUX24 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX24;
enum PA_CHANNEL_POSITION_AUX25 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX25;
enum PA_CHANNEL_POSITION_AUX26 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX26;
enum PA_CHANNEL_POSITION_AUX27 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX27;
enum PA_CHANNEL_POSITION_AUX28 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX28;
enum PA_CHANNEL_POSITION_AUX29 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX29;
enum PA_CHANNEL_POSITION_AUX30 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX30;
enum PA_CHANNEL_POSITION_AUX31 = pa_channel_position_t.PA_CHANNEL_POSITION_AUX31;
enum PA_CHANNEL_POSITION_TOP_CENTER = pa_channel_position_t.PA_CHANNEL_POSITION_TOP_CENTER;
enum PA_CHANNEL_POSITION_TOP_FRONT_LEFT = pa_channel_position_t.PA_CHANNEL_POSITION_TOP_FRONT_LEFT;
enum PA_CHANNEL_POSITION_TOP_FRONT_RIGHT = pa_channel_position_t.PA_CHANNEL_POSITION_TOP_FRONT_RIGHT;
enum PA_CHANNEL_POSITION_TOP_FRONT_CENTER = pa_channel_position_t.PA_CHANNEL_POSITION_TOP_FRONT_CENTER;
enum PA_CHANNEL_POSITION_TOP_REAR_LEFT = pa_channel_position_t.PA_CHANNEL_POSITION_TOP_REAR_LEFT;
enum PA_CHANNEL_POSITION_TOP_REAR_RIGHT = pa_channel_position_t.PA_CHANNEL_POSITION_TOP_REAR_RIGHT;
enum PA_CHANNEL_POSITION_TOP_REAR_CENTER = pa_channel_position_t.PA_CHANNEL_POSITION_TOP_REAR_CENTER;
enum PA_CHANNEL_POSITION_MAX = pa_channel_position_t.PA_CHANNEL_POSITION_MAX;
/** \endcond */

/** A mask of channel positions. \since 0.9.16 */
alias pa_channel_position_mask_t = c_ulong;

/** Makes a bit mask from a channel position. \since 0.9.16 */
extern (D) auto PA_CHANNEL_POSITION_MASK(T)(auto ref T f)
{
    return cast(pa_channel_position_mask_t) cast(ulong)1 << f;
}

/** A list of channel mapping definitions for pa_channel_map_init_auto() */
enum pa_channel_map_def
{
    PA_CHANNEL_MAP_AIFF = 0,
    /**< The mapping from RFC3551, which is based on AIFF-C */

    /** \cond fulldocs */
    PA_CHANNEL_MAP_ALSA = 1,
    /**< The default mapping used by ALSA. This mapping is probably
     * not too useful since ALSA's default channel mapping depends on
     * the device string used. */
    /** \endcond */

    PA_CHANNEL_MAP_AUX = 2,
    /**< Only aux channels */

    PA_CHANNEL_MAP_WAVEEX = 3,
    /**< Microsoft's WAVEFORMATEXTENSIBLE mapping. This mapping works
     * as if all LSBs of dwChannelMask are set.  */

    /** \cond fulldocs */
    PA_CHANNEL_MAP_OSS = 4,
    /**< The default channel mapping used by OSS as defined in the OSS
     * 4.0 API specs. This mapping is probably not too useful since
     * the OSS API has changed in this respect and no longer knows a
     * default channel mapping based on the number of channels. */
    /** \endcond */

    /**< Upper limit of valid channel mapping definitions */
    PA_CHANNEL_MAP_DEF_MAX = 5,

    PA_CHANNEL_MAP_DEFAULT = PA_CHANNEL_MAP_AIFF
    /**< The default channel map */
}

alias pa_channel_map_def_t = pa_channel_map_def;

/** \cond fulldocs */
enum PA_CHANNEL_MAP_AIFF = pa_channel_map_def_t.PA_CHANNEL_MAP_AIFF;
enum PA_CHANNEL_MAP_ALSA = pa_channel_map_def_t.PA_CHANNEL_MAP_ALSA;
enum PA_CHANNEL_MAP_AUX = pa_channel_map_def_t.PA_CHANNEL_MAP_AUX;
enum PA_CHANNEL_MAP_WAVEEX = pa_channel_map_def_t.PA_CHANNEL_MAP_WAVEEX;
enum PA_CHANNEL_MAP_OSS = pa_channel_map_def_t.PA_CHANNEL_MAP_OSS;
enum PA_CHANNEL_MAP_DEF_MAX = pa_channel_map_def_t.PA_CHANNEL_MAP_DEF_MAX;
enum PA_CHANNEL_MAP_DEFAULT = pa_channel_map_def_t.PA_CHANNEL_MAP_DEFAULT;
/** \endcond */

/** A channel map which can be used to attach labels to specific
 * channels of a stream. These values are relevant for conversion and
 * mixing of streams */
struct pa_channel_map
{
    ubyte channels;
    /**< Number of channels mapped */

    pa_channel_position_t[PA_CHANNELS_MAX] map;
    /**< Channel labels */
}

/** Initialize the specified channel map and return a pointer to
 * it. The channel map will have a defined state but
 * pa_channel_map_valid() will fail for it. */
pa_channel_map* pa_channel_map_init (pa_channel_map* m);

/** Initialize the specified channel map for monaural audio and return a pointer to it */
pa_channel_map* pa_channel_map_init_mono (pa_channel_map* m);

/** Initialize the specified channel map for stereophonic audio and return a pointer to it */
pa_channel_map* pa_channel_map_init_stereo (pa_channel_map* m);

/** Initialize the specified channel map for the specified number of
 * channels using default labels and return a pointer to it. This call
 * will fail (return NULL) if there is no default channel map known for this
 * specific number of channels and mapping. */
pa_channel_map* pa_channel_map_init_auto (pa_channel_map* m, uint channels, pa_channel_map_def_t def);

/** Similar to pa_channel_map_init_auto() but instead of failing if no
 * default mapping is known with the specified parameters it will
 * synthesize a mapping based on a known mapping with fewer channels
 * and fill up the rest with AUX0...AUX31 channels  \since 0.9.11 */
pa_channel_map* pa_channel_map_init_extend (pa_channel_map* m, uint channels, pa_channel_map_def_t def);

/** Return a text label for the specified channel position */
const(char)* pa_channel_position_to_string (pa_channel_position_t pos);

/** The inverse of pa_channel_position_to_string(). \since 0.9.16 */
pa_channel_position_t pa_channel_position_from_string (const(char)* s);

/** Return a human readable text label for the specified channel position. \since 0.9.7 */
const(char)* pa_channel_position_to_pretty_string (pa_channel_position_t pos);

/** The maximum length of strings returned by
 * pa_channel_map_snprint(). Please note that this value can change
 * with any release without warning and without being considered API
 * or ABI breakage. You should not use this definition anywhere where
 * it might become part of an ABI. */
enum PA_CHANNEL_MAP_SNPRINT_MAX = 336;

/** Make a human readable string from the specified channel map. Returns \a s. */
char* pa_channel_map_snprint (char* s, size_t l, const(pa_channel_map)* map);

/** Parse a channel position list or well-known mapping name into a
 * channel map structure. This turns the output of
 * pa_channel_map_snprint() and pa_channel_map_to_name() back into a
 * pa_channel_map */
pa_channel_map* pa_channel_map_parse (pa_channel_map* map, const(char)* s);

/** Compare two channel maps. Return 1 if both match. */
int pa_channel_map_equal (const(pa_channel_map)* a, const(pa_channel_map)* b);

/** Return non-zero if the specified channel map is considered valid */
int pa_channel_map_valid (const(pa_channel_map)* map);

/** Return non-zero if the specified channel map is compatible with
 * the specified sample spec. \since 0.9.12 */
int pa_channel_map_compatible (const(pa_channel_map)* map, const(pa_sample_spec)* ss);

/** Returns non-zero if every channel defined in b is also defined in a. \since 0.9.15 */
int pa_channel_map_superset (const(pa_channel_map)* a, const(pa_channel_map)* b);

/** Returns non-zero if it makes sense to apply a volume 'balance'
 * with this mapping, i.e.\ if there are left/right channels
 * available. \since 0.9.15 */
int pa_channel_map_can_balance (const(pa_channel_map)* map);

/** Returns non-zero if it makes sense to apply a volume 'fade'
 * (i.e.\ 'balance' between front and rear) with this mapping, i.e.\ if
 * there are front/rear channels available. \since 0.9.15 */
int pa_channel_map_can_fade (const(pa_channel_map)* map);

/** Returns non-zero if it makes sense to apply a volume 'lfe balance'
 * (i.e.\ 'balance' between LFE and non-LFE channels) with this mapping,
 *  i.e.\ if there are LFE and non-LFE channels available. \since 8.0 */
int pa_channel_map_can_lfe_balance (const(pa_channel_map)* map);

/** Tries to find a well-known channel mapping name for this channel
 * mapping, i.e.\ "stereo", "surround-71" and so on. If the channel
 * mapping is unknown NULL will be returned. This name can be parsed
 * with pa_channel_map_parse() \since 0.9.15 */
const(char)* pa_channel_map_to_name (const(pa_channel_map)* map);

/** Tries to find a human readable text label for this channel
mapping, i.e.\ "Stereo", "Surround 7.1" and so on. If the channel
mapping is unknown NULL will be returned. \since 0.9.15 */
const(char)* pa_channel_map_to_pretty_name (const(pa_channel_map)* map);

/** Returns non-zero if the specified channel position is available at
 * least once in the channel map. \since 0.9.16 */
int pa_channel_map_has_position (const(pa_channel_map)* map, pa_channel_position_t p);

/** Generates a bit mask from a channel map. \since 0.9.16 */
pa_channel_position_mask_t pa_channel_map_mask (const(pa_channel_map)* map);

