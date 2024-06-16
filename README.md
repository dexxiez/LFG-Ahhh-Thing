# LFG Uhhh Thing

This is a World of Warcraft addon developed by Jun Ceena & Dexxiez mah ballz.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed a suitable text editor like Visual Studio Code.
- You have installed the Lua Language Server extension for your editor. For Visual Studio Code, you can install it from the [VSCode Marketplace](https://marketplace.visualstudio.com/items?itemName=sumneko.lua).

## Installing LFG Uhhh Thing

To install LFG Uhhh Thing, follow these steps:

1. Clone the repository to your local machine.
2. Copy the entire project folder into your World of Warcraft `_classic_/Interface/AddOns` directory.

NOTE: Better yet, clone the repository directly into the `AddOns` directory. Make sure there are no symbols or hyphens in the folder name, otherwise the addon will not load.

## Using LFG Uhhh Thing

Once installed, you can use the addon in-game by typing `/lfgat` in the chat. This will open the addon's interface.

## EmmyLua Notation

EmmyLua is a plugin/ideology for Lua development which provides a lot of features to help you write code faster. It is also used to provide type hinting and autocompletion in Lua Language Server.

Here's a basic example of how to use EmmyLua notation:

```lua
--- @class Player : Object  -- This defines a new class named Player which inherits from Object
local Player = {}

--- @field public name string  -- This defines a public field named name of type string
Player.name = ""

--- @param name string  -- This defines a parameter named name of type string
--- @return Player  -- This defines the return type of the function
function Player:new(name)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.name = name
    return o
end
```

## Contact

If you want to contact the authors, you can reach Jun Ceena & Dexxiez mah ballz at `<email>`. (yes, we're not giving you our email addresses.)

## License

NO
