module pulse.sample;

import core.stdc.config;

extern (C):

/***
  This file is part of PulseAudio.

  Copyright 2004-2006 Lennart Poettering
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

/** \page sample Sample Format Specifications
 *
 * \section overv_sec Overview
 *
 * PulseAudio is capable of handling a multitude of sample formats, rates
 * and channels, transparently converting and mixing them as needed.
 *
 * \section format_sec Sample Format
 *
 * PulseAudio supports the following sample formats:
 *
 * \li PA_SAMPLE_U8 - Unsigned 8 bit integer PCM.
 * \li PA_SAMPLE_S16LE - Signed 16 integer bit PCM, little endian.
 * \li PA_SAMPLE_S16BE - Signed 16 integer bit PCM, big endian.
 * \li PA_SAMPLE_FLOAT32LE - 32 bit IEEE floating point PCM, little endian.
 * \li PA_SAMPLE_FLOAT32BE - 32 bit IEEE floating point PCM, big endian.
 * \li PA_SAMPLE_ALAW - 8 bit a-Law.
 * \li PA_SAMPLE_ULAW - 8 bit mu-Law.
 * \li PA_SAMPLE_S32LE - Signed 32 bit integer PCM, little endian.
 * \li PA_SAMPLE_S32BE - Signed 32 bit integer PCM, big endian.
 * \li PA_SAMPLE_S24LE - Signed 24 bit integer PCM packed, little endian.
 * \li PA_SAMPLE_S24BE - Signed 24 bit integer PCM packed, big endian.
 * \li PA_SAMPLE_S24_32LE - Signed 24 bit integer PCM in LSB of 32 bit words, little endian.
 * \li PA_SAMPLE_S24_32BE - Signed 24 bit integer PCM in LSB of 32 bit words, big endian.
 *
 * The floating point sample formats have the range from -1.0 to 1.0.
 *
 * The sample formats that are sensitive to endianness have convenience
 * macros for native endian (NE), and reverse endian (RE).
 *
 * \section rate_sec Sample Rates
 *
 * PulseAudio supports any sample rate between 1 Hz and 192000 Hz. There is no
 * point trying to exceed the sample rate of the output device though as the
 * signal will only get downsampled, consuming CPU on the machine running the
 * server.
 *
 * \section chan_sec Channels
 *
 * PulseAudio supports up to 32 individual channels. The order of the
 * channels is up to the application, but they must be continuous. To map
 * channels to speakers, see \ref channelmap.
 *
 * \section calc_sec Calculations
 *
 * The PulseAudio library contains a number of convenience functions to do
 * calculations on sample formats:
 *
 * \li pa_bytes_per_second() - The number of bytes one second of audio will
 *                             take given a sample format.
 * \li pa_frame_size() - The size, in bytes, of one frame (i.e. one set of
 *                       samples, one for each channel).
 * \li pa_sample_size() - The size, in bytes, of one sample.
 * \li pa_bytes_to_usec() - Calculate the time it would take to play a buffer
 *                          of a certain size.
 *
 * \section util_sec Convenience Functions
 *
 * The library also contains a couple of other convenience functions:
 *
 * \li pa_sample_spec_valid() - Tests if a sample format specification is
 *                              valid.
 * \li pa_sample_spec_equal() - Tests if the sample format specifications are
 *                              identical.
 * \li pa_sample_format_to_string() - Return a textual description of a
 *                                    sample format.
 * \li pa_parse_sample_format() - Parse a text string into a sample format.
 * \li pa_sample_spec_snprint() - Create a textual description of a complete
 *                                 sample format specification.
 * \li pa_bytes_snprint() - Pretty print a byte value (e.g. 2.5 MiB).
 */

/** \file
 * Constants and routines for sample type handling
 *
 * See also \subpage sample
 */

/* On Sparc, WORDS_BIGENDIAN needs to be set if _BIG_ENDIAN is defined. */

/** Maximum number of allowed channels */
enum PA_CHANNELS_MAX = 32U;

/** Maximum allowed sample rate */
enum PA_RATE_MAX = 48000U * 8U;

/** Sample format */
enum pa_sample_format
{
    PA_SAMPLE_U8 = 0,
    /**< Unsigned 8 Bit PCM */

    PA_SAMPLE_ALAW = 1,
    /**< 8 Bit a-Law */

    PA_SAMPLE_ULAW = 2,
    /**< 8 Bit mu-Law */

    PA_SAMPLE_S16LE = 3,
    /**< Signed 16 Bit PCM, little endian (PC) */

    PA_SAMPLE_S16BE = 4,
    /**< Signed 16 Bit PCM, big endian */

    PA_SAMPLE_FLOAT32LE = 5,
    /**< 32 Bit IEEE floating point, little endian (PC), range -1.0 to 1.0 */

    PA_SAMPLE_FLOAT32BE = 6,
    /**< 32 Bit IEEE floating point, big endian, range -1.0 to 1.0 */

    PA_SAMPLE_S32LE = 7,
    /**< Signed 32 Bit PCM, little endian (PC) */

    PA_SAMPLE_S32BE = 8,
    /**< Signed 32 Bit PCM, big endian */

    PA_SAMPLE_S24LE = 9,
    /**< Signed 24 Bit PCM packed, little endian (PC). \since 0.9.15 */

    PA_SAMPLE_S24BE = 10,
    /**< Signed 24 Bit PCM packed, big endian. \since 0.9.15 */

    PA_SAMPLE_S24_32LE = 11,
    /**< Signed 24 Bit PCM in LSB of 32 Bit words, little endian (PC). \since 0.9.15 */

    PA_SAMPLE_S24_32BE = 12,
    /**< Signed 24 Bit PCM in LSB of 32 Bit words, big endian. \since 0.9.15 */

    /* Remeber to update
     * https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/SupportedAudioFormats/
     * when adding new formats! */

    PA_SAMPLE_MAX = 13,
    /**< Upper limit of valid sample types */

    PA_SAMPLE_INVALID = -1
    /**< An invalid value */
}

alias pa_sample_format_t = pa_sample_format;

/** Signed 16 Bit PCM, native endian */

/** 32 Bit IEEE floating point, native endian */

/** Signed 32 Bit PCM, native endian */

/** Signed 24 Bit PCM packed, native endian. \since 0.9.15 */

/** Signed 24 Bit PCM in LSB of 32 Bit words, native endian. \since 0.9.15 */

/** Signed 16 Bit PCM reverse endian */

/** 32 Bit IEEE floating point, reverse endian */

/** Signed 32 Bit PCM, reverse endian */

/** Signed 24 Bit PCM, packed reverse endian. \since 0.9.15 */

/** Signed 24 Bit PCM, in LSB of 32 Bit words, reverse endian. \since 0.9.15 */

/** Signed 16 Bit PCM, native endian */
enum PA_SAMPLE_S16NE = pa_sample_format_t.PA_SAMPLE_S16LE;
/** 32 Bit IEEE floating point, native endian */
enum PA_SAMPLE_FLOAT32NE = pa_sample_format_t.PA_SAMPLE_FLOAT32LE;
/** Signed 32 Bit PCM, native endian */
enum PA_SAMPLE_S32NE = pa_sample_format_t.PA_SAMPLE_S32LE;
/** Signed 24 Bit PCM packed, native endian. \since 0.9.15 */
enum PA_SAMPLE_S24NE = pa_sample_format_t.PA_SAMPLE_S24LE;
/** Signed 24 Bit PCM in LSB of 32 Bit words, native endian. \since 0.9.15 */
enum PA_SAMPLE_S24_32NE = pa_sample_format_t.PA_SAMPLE_S24_32LE;

/** Signed 16 Bit PCM, reverse endian */
enum PA_SAMPLE_S16RE = pa_sample_format_t.PA_SAMPLE_S16BE;
/** 32 Bit IEEE floating point, reverse endian */
enum PA_SAMPLE_FLOAT32RE = pa_sample_format_t.PA_SAMPLE_FLOAT32BE;
/** Signed 32 Bit PCM, reverse endian */
enum PA_SAMPLE_S32RE = pa_sample_format_t.PA_SAMPLE_S32BE;
/** Signed 24 Bit PCM, packed reverse endian. \since 0.9.15 */
enum PA_SAMPLE_S24RE = pa_sample_format_t.PA_SAMPLE_S24BE;
/** Signed 24 Bit PCM, in LSB of 32 Bit words, reverse endian. \since 0.9.15 */
enum PA_SAMPLE_S24_32RE = pa_sample_format_t.PA_SAMPLE_S24_32BE;

/** A Shortcut for PA_SAMPLE_FLOAT32NE */
enum PA_SAMPLE_FLOAT32 = PA_SAMPLE_FLOAT32NE;

/** \cond fulldocs */
/* Allow clients to check with #ifdef for these sample formats */
enum PA_SAMPLE_U8 = pa_sample_format_t.PA_SAMPLE_U8;
enum PA_SAMPLE_ALAW = pa_sample_format_t.PA_SAMPLE_ALAW;
enum PA_SAMPLE_ULAW = pa_sample_format_t.PA_SAMPLE_ULAW;
enum PA_SAMPLE_S16LE = pa_sample_format_t.PA_SAMPLE_S16LE;
enum PA_SAMPLE_S16BE = pa_sample_format_t.PA_SAMPLE_S16BE;
enum PA_SAMPLE_FLOAT32LE = pa_sample_format_t.PA_SAMPLE_FLOAT32LE;
enum PA_SAMPLE_FLOAT32BE = pa_sample_format_t.PA_SAMPLE_FLOAT32BE;
enum PA_SAMPLE_S32LE = pa_sample_format_t.PA_SAMPLE_S32LE;
enum PA_SAMPLE_S32BE = pa_sample_format_t.PA_SAMPLE_S32BE;
enum PA_SAMPLE_S24LE = pa_sample_format_t.PA_SAMPLE_S24LE;
enum PA_SAMPLE_S24BE = pa_sample_format_t.PA_SAMPLE_S24BE;
enum PA_SAMPLE_S24_32LE = pa_sample_format_t.PA_SAMPLE_S24_32LE;
enum PA_SAMPLE_S24_32BE = pa_sample_format_t.PA_SAMPLE_S24_32BE;
/** \endcond */

/** A sample format and attribute specification */
struct pa_sample_spec
{
    pa_sample_format_t format;
    /**< The sample format */

    uint rate;
    /**< The sample rate. (e.g. 44100) */

    ubyte channels;
    /**< Audio channels. (1 for mono, 2 for stereo, ...) */
}

/** Type for usec specifications (unsigned). Always 64 bit. */
alias pa_usec_t = c_ulong;

/** Return the amount of bytes that constitute playback of one second of
 * audio, with the specified sample spec. */
size_t pa_bytes_per_second (const(pa_sample_spec)* spec);

/** Return the size of a frame with the specific sample type */
size_t pa_frame_size (const(pa_sample_spec)* spec);

/** Return the size of a sample with the specific sample type */
size_t pa_sample_size (const(pa_sample_spec)* spec);

/** Similar to pa_sample_size() but take a sample format instead of a
 * full sample spec. \since 0.9.15 */
size_t pa_sample_size_of_format (pa_sample_format_t f);

/** Calculate the time it would take to play a buffer of the specified
 * size with the specified sample type. The return value will always
 * be rounded down for non-integral return values. */
pa_usec_t pa_bytes_to_usec (ulong length, const(pa_sample_spec)* spec);

/** Calculates the size of a buffer required, for playback duration
 * of the time specified, with the specified sample type. The
 * return value will always be rounded down for non-integral
 * return values. \since 0.9 */
size_t pa_usec_to_bytes (pa_usec_t t, const(pa_sample_spec)* spec);

/** Initialize the specified sample spec and return a pointer to
 * it. The sample spec will have a defined state but
 * pa_sample_spec_valid() will fail for it. \since 0.9.13 */
pa_sample_spec* pa_sample_spec_init (pa_sample_spec* spec);

/** Return non-zero if the given integer is a valid sample format. \since 5.0 */
int pa_sample_format_valid (uint format);

/** Return non-zero if the rate is within the supported range. \since 5.0 */
int pa_sample_rate_valid (uint rate);

/** Return non-zero if the channel count is within the supported range.
 * \since 5.0 */
int pa_channels_valid (ubyte channels);

/** Return non-zero when the sample type specification is valid */
int pa_sample_spec_valid (const(pa_sample_spec)* spec);

/** Return non-zero when the two sample type specifications match */
int pa_sample_spec_equal (const(pa_sample_spec)* a, const(pa_sample_spec)* b);

/** Return a descriptive string for the specified sample format. \since 0.8 */
const(char)* pa_sample_format_to_string (pa_sample_format_t f);

/** Parse a sample format text. Inverse of pa_sample_format_to_string() */
pa_sample_format_t pa_parse_sample_format (const(char)* format);

/** Maximum required string length for
 * pa_sample_spec_snprint(). Please note that this value can change
 * with any release without warning and without being considered API
 * or ABI breakage. You should not use this definition anywhere where
 * it might become part of an ABI. */
enum PA_SAMPLE_SPEC_SNPRINT_MAX = 32;

/** Pretty print a sample type specification to a string. Returns \a s. */
char* pa_sample_spec_snprint (char* s, size_t l, const(pa_sample_spec)* spec);

/** Maximum required string length for pa_bytes_snprint(). Please note
 * that this value can change with any release without warning and
 * without being considered API or ABI breakage. You should not use
 * this definition anywhere where it might become part of an
 * ABI. \since 0.9.16 */
enum PA_BYTES_SNPRINT_MAX = 11;

/** Pretty print a byte size value (i.e.\ "2.5 MiB"). Returns \a s. */
char* pa_bytes_snprint (char* s, size_t l, uint v);

/** Returns 1 when the specified format is little endian, 0 when
 * big endian. Returns -1 when endianness does not apply to the
 * specified format, or endianess is unknown. \since 0.9.16 */
int pa_sample_format_is_le (pa_sample_format_t f);

/** Returns 1 when the specified format is big endian, 0 when
 * little endian. Returns -1 when endianness does not apply to the
 * specified format, or endianess is unknown. \since 0.9.16 */
int pa_sample_format_is_be (pa_sample_format_t f);

/** Returns 1 when the specified format is native endian, 0 when
 * not. Returns -1 when endianness does not apply to the
 * specified format, or endianess is unknown. \since 0.9.16 */
alias pa_sample_format_is_ne = pa_sample_format_is_le;
/** Returns 1 when the specified format is reverse endian, 0 when
 * native. Returns -1 when endianness does not apply to the
 * specified format, or endianess is unknown. \since 0.9.16 */
alias pa_sample_format_is_re = pa_sample_format_is_be;

