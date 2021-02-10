# hugo-audio

## About

This [Hugo](https://gohugo.io) theme component provides a shortcode: `audio` for embedding videos using
the [HTML audio element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio).

It comes with english and german localization. Other languages welcome! Send your pull request.

## Features

This shortcode uses Hugo [Page Resources](https://gohugo.io/content-management/page-resources/). The audio to display __
must be placed in the [page bundle](https://gohugo.io/content-management/page-bundles/)__.

The shortcode takes one mandatory argument: the filename of the audio file to display, __without the extension__. It
detects automatically if several versions of the file exists in the page bundle, and add accordingly the multiple `src`
tags.

When the browser doesn't support
the [HTML audio element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio), the shortcode displays a
localized notice allowing the audio download for local playing.

Following video formats are supported:

- MP3 (extension `.mp3`)

Default values:

- Browser's default controls are displayed (`controls` attribute is always included)
- Audio can be preloaded (`preload="auto"` attribute is always included)
- Audio width is 100% (`width="100%"` attribute is included); this can be changed by indicating the desired width when
  calling the shortcode, see example below)
- Following audio attributes can be set: `muted="true"`, `autoplay="true"` and `loop="true"`.
- Default settings are used for other audio attributes

When no audio file of the given name is found in the supported format (see above), the shortcode __intentionally fails__
with a `No valid audio file with filename <filename> found.` error.

## Usage

1. Add `hugo-audio` as a submodule to be able to get upstream changes later
    ```bash
    git submodule add https://github.com/heinrichreimer/hugo-audio.git themes/hugo-audio
    ```
2. Add `hugo-audio` as the left-most element of the `theme` list variable in your site's or theme's configuration
   file `config.yaml` or `config.toml`. Example, with `config.yaml`:
    ```yaml
    theme: ["hugo-audio", "my-theme"]
    ```
   or, with `config.toml`,
    ```toml
    theme = ["hugo-audio", "my-theme"]
    ```
3. Place your audio file(s) in the [page bundle](https://gohugo.io/content-management/page-bundles/) of your post.
4. In your site, use the shortcode, this way, indicating the audio filename __without its extension__. If your video
   file is `my-beautiful-screencast.mp4`, type this:
    ```go
    {{< audio src="my-beautiful-recording" >}}
    ```
   or
    ```go
    {{< audio src="my-beautiful-recording" width="600px" >}}
    ```

### Thanks

- To [Nicolas Martignoni](https://github.com/martignoni), for the hugo-video shortcode on which this shortcode is based.
- To [Tom McKenzie](https://github.com/grrowl), for implementing `muted`, `autoplay` and `loop` video attributes
  support.
- To [Olaf Haag](https://github.com/OlafHaag) and [Paul Lettington](https://github.com/plett), for raising and fixing
  some bugs.
- To [Arsenii Lyashenko](https://github.com/ark0f), for implementing `controls` disabling option.

### Licence

Copyright © 2020 Jan Heinrich Reimer

All the source code is licensed under GPL 3 or any later version

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public
License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later
version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the
implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
details.
