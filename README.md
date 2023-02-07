This is a small World of Warcraft addon that lets you play quotes from Kaamelott to your guild mates.

The audio files for kaamelott come from https://kaamelott-soundboard.2ec0b4.fr/

More quotes will be added soon from other movies

### Basic usage

`/kaamelol search pas faux` search for quotes containing the text "pas faux". Can be shortened to `/kl s pas faux`.

It should print this:


```
results:
31: C'est pas faux
32: Ouais c'est pas faux
```

You can then `/kl 31`, everyone in your guild with the addon installed will hear "C'est pas faux".

There's more commands to broadcast to specific channels or with a given file name, but they're not used often enough to be worth documenting.

### Contributing new sounds

Add the .mp3 in the sound folder, then add an entry in `content.lua`. `FILE` is the file name (without `.mp3`). `TITLE` is the quote text, used for the search and to print the file content.
