# [kak-prints](https://github.com/cameron-yee/kak-prints)

A [Kakoune](http://kakoune.org/) plugin for working with print statements because I still debug like a scrub.

## Installation

### Installing with plug.kak

To install with plug.kak, add the following to your kakrc, then run the :plug-install command:

### Usage

#### .kakrc config

```
plug 'cameron-yee/kak-prints' config %{
    # Suggested user mode mapping
    map global user p ':enter-user-mode<space>prints<ret>' -docstring 'print statement mode'
}
```

#### Prints mode mappings

| key   | action                                         |
| ----- | ---------------------------------------------- |
| c     | toggle line comments for print statement lines |
| d     | delete print statement lines                   |
