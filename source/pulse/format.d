module pulse.format;

version(linux):

import pulse.proplist;
import pulse.sample;
import pulse.channelmap;

extern (C):

/***
  This file is part of PulseAudio.

  Copyright 2011 Intel Corporation
  Copyright 2011 Collabora Multimedia
  Copyright 2011 Arun Raghavan <arun.raghavan@collabora.co.uk>

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
 * Utility functions for handling a stream or sink format. */

/** Represents the type of encoding used in a stream or accepted by a sink. \since 1.0 */
enum pa_encoding
{
    PA_ENCODING_ANY = 0,
    /**< Any encoding format, PCM or compressed */

    PA_ENCODING_PCM = 1,
    /**< Any PCM format */

    PA_ENCODING_AC3_IEC61937 = 2,
    /**< AC3 data encapsulated in IEC 61937 header/padding */

    PA_ENCODING_EAC3_IEC61937 = 3,
    /**< EAC3 data encapsulated in IEC 61937 header/padding */

    PA_ENCODING_MPEG_IEC61937 = 4,
    /**< MPEG-1 or MPEG-2 (Part 3, not AAC) data encapsulated in IEC 61937 header/padding */

    PA_ENCODING_DTS_IEC61937 = 5,
    /**< DTS data encapsulated in IEC 61937 header/padding */

    PA_ENCODING_MPEG2_AAC_IEC61937 = 6,
    /**< MPEG-2 AAC data encapsulated in IEC 61937 header/padding. \since 4.0 */

    PA_ENCODING_TRUEHD_IEC61937 = 7,
    /**< Dolby TrueHD data encapsulated in IEC 61937 header/padding. \since 13.0 */

    PA_ENCODING_DTSHD_IEC61937 = 8,
    /**< DTS-HD Master Audio encapsulated in IEC 61937 header/padding. \since 13.0 */

    /* Remeber to update
     * https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/SupportedAudioFormats/
     * when adding new encodings! */

    PA_ENCODING_MAX = 9,
    /**< Valid encoding types must be less than this value */

    PA_ENCODING_INVALID = -1
    /**< Represents an invalid encoding */
}

alias pa_encoding_t = pa_encoding;

/** \cond fulldocs */
enum PA_ENCODING_ANY = pa_encoding_t.PA_ENCODING_ANY;
enum PA_ENCODING_PCM = pa_encoding_t.PA_ENCODING_PCM;
enum PA_ENCODING_AC3_IEC61937 = pa_encoding_t.PA_ENCODING_AC3_IEC61937;
enum PA_ENCODING_EAC3_IEC61937 = pa_encoding_t.PA_ENCODING_EAC3_IEC61937;
enum PA_ENCODING_MPEG_IEC61937 = pa_encoding_t.PA_ENCODING_MPEG_IEC61937;
enum PA_ENCODING_DTS_IEC61937 = pa_encoding_t.PA_ENCODING_DTS_IEC61937;
enum PA_ENCODING_MPEG2_AAC_IEC61937 = pa_encoding_t.PA_ENCODING_MPEG2_AAC_IEC61937;
enum PA_ENCODING_TRUEHD_IEC61937 = pa_encoding_t.PA_ENCODING_TRUEHD_IEC61937;
enum PA_ENCODING_DTSHD_IEC61937 = pa_encoding_t.PA_ENCODING_DTSHD_IEC61937;
enum PA_ENCODING_MAX = pa_encoding_t.PA_ENCODING_MAX;
enum PA_ENCODING_INVALID = pa_encoding_t.PA_ENCODING_INVALID;
/** \endcond */

/** Returns a printable string representing the given encoding type. \since 1.0 */
const(char)* pa_encoding_to_string (pa_encoding_t e);

/** Converts a string of the form returned by \a pa_encoding_to_string() back to
 * a \a pa_encoding_t. \since 1.0 */
pa_encoding_t pa_encoding_from_string (const(char)* encoding);

/** Represents the format of data provided in a stream or processed by a sink. \since 1.0 */
struct pa_format_info
{
    pa_encoding_t encoding;
    /**< The encoding used for the format */

    pa_proplist* plist;
    /**< Additional encoding-specific properties such as sample rate, bitrate, etc. */
}

/** Allocates a new \a pa_format_info structure. Clients must initialise at
 * least the encoding field themselves. Free with pa_format_info_free. \since 1.0 */
pa_format_info* pa_format_info_new ();

/** Returns a new \a pa_format_info struct and representing the same format as \a src. \since 1.0 */
pa_format_info* pa_format_info_copy (const(pa_format_info)* src);

/** Frees a \a pa_format_info structure. \since 1.0 */
void pa_format_info_free (pa_format_info* f);

/** Returns non-zero when the format info structure is valid. \since 1.0 */
int pa_format_info_valid (const(pa_format_info)* f);

/** Returns non-zero when the format info structure represents a PCM
 * (i.e.\ uncompressed data) format. \since 1.0 */
int pa_format_info_is_pcm (const(pa_format_info)* f);

/** Returns non-zero if the format represented by \a first is a subset of
 * the format represented by \a second. This means that \a second must
 * have all the fields that \a first does, but the reverse need not
 * be true. This is typically expected to be used to check if a
 * stream's format is compatible with a given sink. In such a case,
 * \a first would be the sink's format and \a second would be the
 * stream's. \since 1.0 */
int pa_format_info_is_compatible (const(pa_format_info)* first, const(pa_format_info)* second);

/** Maximum required string length for
 * pa_format_info_snprint(). Please note that this value can change
 * with any release without warning and without being considered API
 * or ABI breakage. You should not use this definition anywhere where
 * it might become part of an ABI. \since 1.0 */
enum PA_FORMAT_INFO_SNPRINT_MAX = 256;

/** Make a human-readable string representing the given format. Returns \a s. \since 1.0 */
char* pa_format_info_snprint (char* s, size_t l, const(pa_format_info)* f);

/** Parse a human-readable string of the form generated by
 * \a pa_format_info_snprint() into a pa_format_info structure. \since 1.0 */
pa_format_info* pa_format_info_from_string (const(char)* str);

/** Utility function to take a \a pa_sample_spec and generate the corresponding
 * \a pa_format_info.
 *
 * Note that if you want the server to choose some of the stream parameters,
 * for example the sample rate, so that they match the device parameters, then
 * you shouldn't use this function. In order to allow the server to choose
 * a parameter value, that parameter must be left unspecified in the
 * pa_format_info object, and this function always specifies all parameters. An
 * exception is the channel map: if you pass NULL for the channel map, then the
 * channel map will be left unspecified, allowing the server to choose it.
 *
 * \since 2.0 */
pa_format_info* pa_format_info_from_sample_spec (const(pa_sample_spec)* ss, const(pa_channel_map)* map);

/** Utility function to generate a \a pa_sample_spec and \a pa_channel_map corresponding to a given \a pa_format_info. The
 * conversion for PCM formats is straight-forward. For non-PCM formats, if there is a fixed size-time conversion (i.e. all
 * IEC61937-encapsulated formats), a "fake" sample spec whose size-time conversion corresponds to this format is provided and
 * the channel map argument is ignored. For formats with variable size-time conversion, this function will fail. Returns a
 * negative integer if conversion failed and 0 on success. \since 2.0 */
int pa_format_info_to_sample_spec (const(pa_format_info)* f, pa_sample_spec* ss, pa_channel_map* map);

/** Represents the type of value type of a property on a \ref pa_format_info. \since 2.0 */
enum pa_prop_type_t
{
    PA_PROP_TYPE_INT = 0,
    /**< Integer property */

    PA_PROP_TYPE_INT_RANGE = 1,
    /**< Integer range property */

    PA_PROP_TYPE_INT_ARRAY = 2,
    /**< Integer array property */

    PA_PROP_TYPE_STRING = 3,
    /**< String property */

    PA_PROP_TYPE_STRING_ARRAY = 4,
    /**< String array property */

    PA_PROP_TYPE_INVALID = -1
    /**< Represents an invalid type */
}

/** \cond fulldocs */
enum PA_PROP_TYPE_INT = pa_prop_type_t.PA_PROP_TYPE_INT;
enum PA_PROP_TYPE_INT_RANGE = pa_prop_type_t.PA_PROP_TYPE_INT_RANGE;
enum PA_PROP_TYPE_INT_ARRAY = pa_prop_type_t.PA_PROP_TYPE_INT_ARRAY;
enum PA_PROP_TYPE_STRING = pa_prop_type_t.PA_PROP_TYPE_STRING;
enum PA_PROP_TYPE_STRING_ARRAY = pa_prop_type_t.PA_PROP_TYPE_STRING_ARRAY;
enum PA_PROP_TYPE_INVALID = pa_prop_type_t.PA_PROP_TYPE_INVALID;
/** \endcond */

/** Gets the type of property \a key in a given \ref pa_format_info. \since 2.0 */
pa_prop_type_t pa_format_info_get_prop_type (const(pa_format_info)* f, const(char)* key);

/** Gets an integer property from the given format info. Returns 0 on success and a negative integer on failure. \since 2.0 */
int pa_format_info_get_prop_int (const(pa_format_info)* f, const(char)* key, int* v);
/** Gets an integer range property from the given format info. Returns 0 on success and a negative integer on failure.
 * \since 2.0 */
int pa_format_info_get_prop_int_range (const(pa_format_info)* f, const(char)* key, int* min, int* max);
/** Gets an integer array property from the given format info. \a values contains the values and \a n_values contains the
 * number of elements. The caller must free \a values using \ref pa_xfree. Returns 0 on success and a negative integer on
 * failure. \since 2.0 */
int pa_format_info_get_prop_int_array (const(pa_format_info)* f, const(char)* key, int** values, int* n_values);
/** Gets a string property from the given format info.  The caller must free the returned string using \ref pa_xfree. Returns
 * 0 on success and a negative integer on failure. \since 2.0 */
int pa_format_info_get_prop_string (const(pa_format_info)* f, const(char)* key, char** v);
/** Gets a string array property from the given format info. \a values contains the values and \a n_values contains
 * the number of elements. The caller must free \a values using \ref pa_format_info_free_string_array. Returns 0 on success and
 * a negative integer on failure. \since 2.0 */
int pa_format_info_get_prop_string_array (const(pa_format_info)* f, const(char)* key, char*** values, int* n_values);

/** Frees a string array returned by \ref pa_format_info_get_prop_string_array. \since 2.0 */
void pa_format_info_free_string_array (char** values, int n_values);

/** Gets the sample format stored in the format info. Returns a negative error
 * code on failure. If the sample format property is not set at all, returns a
 * negative integer. \since 13.0 */
int pa_format_info_get_sample_format (const(pa_format_info)* f, pa_sample_format_t* sf);

/** Gets the sample rate stored in the format info. Returns a negative error
 * code on failure. If the sample rate property is not set at all, returns a
 * negative integer. \since 13.0 */
int pa_format_info_get_rate (const(pa_format_info)* f, uint* rate);

/** Gets the channel count stored in the format info. Returns a negative error
 * code on failure. If the channels property is not set at all, returns a
 * negative integer. \since 13.0 */
int pa_format_info_get_channels (const(pa_format_info)* f, ubyte* channels);

/** Gets the channel map stored in the format info. Returns a negative error
 * code on failure. If the channel map property is not
 * set at all, returns a negative integer. \since 13.0 */
int pa_format_info_get_channel_map (const(pa_format_info)* f, pa_channel_map* map);

/** Sets an integer property on the given format info. \since 1.0 */
void pa_format_info_set_prop_int (pa_format_info* f, const(char)* key, int value);
/** Sets a property with a list of integer values on the given format info. \since 1.0 */
void pa_format_info_set_prop_int_array (pa_format_info* f, const(char)* key, const(int)* values, int n_values);
/** Sets a property which can have any value in a given integer range on the given format info. \since 1.0 */
void pa_format_info_set_prop_int_range (pa_format_info* f, const(char)* key, int min, int max);
/** Sets a string property on the given format info. \since 1.0 */
void pa_format_info_set_prop_string (pa_format_info* f, const(char)* key, const(char)* value);
/** Sets a property with a list of string values on the given format info. \since 1.0 */
void pa_format_info_set_prop_string_array (pa_format_info* f, const(char)* key, const(char*)* values, int n_values);

/** Convenience method to set the sample format as a property on the given
 * format.
 *
 * Note for PCM: If the sample format is left unspecified in the pa_format_info
 * object, then the server will select the stream sample format. In that case
 * the stream sample format will most likely match the device sample format,
 * meaning that sample format conversion will be avoided.
 *
 * \since 1.0 */
void pa_format_info_set_sample_format (pa_format_info* f, pa_sample_format_t sf);

/** Convenience method to set the sampling rate as a property on the given
 * format.
 *
 * Note for PCM: If the sample rate is left unspecified in the pa_format_info
 * object, then the server will select the stream sample rate. In that case the
 * stream sample rate will most likely match the device sample rate, meaning
 * that sample rate conversion will be avoided.
 *
 * \since 1.0 */
void pa_format_info_set_rate (pa_format_info* f, int rate);

/** Convenience method to set the number of channels as a property on the given
 * format.
 *
 * Note for PCM: If the channel count is left unspecified in the pa_format_info
 * object, then the server will select the stream channel count. In that case
 * the stream channel count will most likely match the device channel count,
 * meaning that up/downmixing will be avoided.
 *
 * \since 1.0 */
void pa_format_info_set_channels (pa_format_info* f, int channels);

/** Convenience method to set the channel map as a property on the given
 * format.
 *
 * Note for PCM: If the channel map is left unspecified in the pa_format_info
 * object, then the server will select the stream channel map. In that case the
 * stream channel map will most likely match the device channel map, meaning
 * that remixing will be avoided.
 *
 * \since 1.0 */
void pa_format_info_set_channel_map (pa_format_info* f, const(pa_channel_map)* map);

