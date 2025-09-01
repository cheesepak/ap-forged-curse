# The Forged Curse (with Archipelago Support)

A lone dwarf follows a peculiar white cricket through dark tunnels and stumbles upon the entrance to a long forgotten, ancient forge. Once sealed away by unknown magic, the outer barrier is weak enough to enter and explore. Fight strange creatures and discover the mystery of the Forged Curse in this Rogue inspired bumpRPG adventure made in Pico-8 with [Archipelago](https://archipelago.gg/) implementation.

This version of The Forged Curse is shipped with AP integration and has been modified to use the GPIO layer to communicate with archipelago.js. The game has 54 checks: 52 chests, the map check, and the forge check. The client includes a compendium with maps, tips, and a vanilla walkthrough to help you learn the game if needed. The original game is included in the` vanilla/` folder and you can play it in-browser on [itch.io](https://chairodactyl.itch.io/the-forged-curse).

- GPIO implementation and AP web client based on [AP Air Delivery by qwint](https://github.com/qwint/ap-air-delivery) and [AP MetroCUBEvania by Amazia](https://github.com/ap-metrocubevania)
- [pico8-gpio-listener](https://github.com/benwiley4000/pico8-gpio-listener) 
- [archipelago.js](https://www.npmjs.com/package/archipelago.js) 

PIGSquad [Summer Slow Jam July 2025: Party Games Submission](https://itch.io/jam/ssjparty) ![Cubepig gif](client/img/cubepig.gif)  

---

Features we would like to add at some point:
- Deathlink
- Progressive Armor and Swords
- Items visible in your world are the correct items (instead of it being the Archipelago logo for everything)

---

## ![archipelago logo](client/img/ap-logo.png) How To Play Archipelago / Randomizer
### Generate a Game / Setup
1. To generate a game the host will need to download and install the [Archipelago core](https://github.com/ArchipelagoMW/Archipelago/releases/) (scroll down to the section titled Assets). **Forged Curse is a custom integration so a multiworld game cannot be generated using the website.**
2. The host needs to download `forgedcurse.apworld` from [the latest release](https://github.com/cheesepak/ap-forged-curse/releases) and move `forgedcurse.apworld` to Archipelago's `custom_worlds` folder. All Forged Curse players will need to download `client.zip` and `ForgedCurse.yaml`. This template .yaml file can be edited with any basic text editor such as notepad, just be sure the formatting and file extension remain unchanged. Each player must add their chosen name entered on the line that begins with 'name: '. 
3. Next, the host will need to collect a `ForgedCurse.yaml` file from each player. Within their installed Archipelago folder, the host will need to add the .yaml files to the `Players` folder and run ArchipelagoGenerate.exe. After the generator runs (a commandline program which will appear briefly), a zip file will be created in the output folder.

### Host / Play 
1. To host the game, the host will need to navigate to [Archipelago's host a pre-generated game](https://archipelago.gg/uploads), click the Upload button, and upload the generated zip file. The website will then load a page titled SEED INFO, on which the host will need to click the yellow link that says Create New Room. This will take the host to a page listing the room's details, a table of the expected players, and a server console window.
2. This page should then be shared with the other players so that they can reference the port number, player name, server log, and access their tracker.
3. Each player playing The Forged Curse, including the host if applicable, will need to unzip `client.zip` and open index.html with a web browser.
4. On the page that opens, each player will need to enter the port number and player name as they appear on the room page and press the submit button (no password needed unless one was set). The text fields should disappear and the server log should show the player connected.
5. Once connected, press the triangular play button in the Pico-8 window and start playing! When a chest is opened you may not get an item, but the server should show a record of who opened which chest. If no record appears, or you don't seem to be receiving items, reload the page and repeat the steps to connect.

#### *Notes:* 
- *If you're playing a single player randomizer, you are considered the host.*
- *The client is also hosted on [hauntedmachine.dev](https://hauntedmachine.dev/games/forged-curse/client/).*

## ![bat gif](client/img/bat.gif) Project Structure 
- `client/`
    - `img/` Images for the client and compendium
    - `vanilla/` Exported files of vanilla version of the game
        - `vanillaforged.html` web player
        - `vanillaforged.js` cart data
        - `vanillaforged.p8` Pico-8 file of vanilla version of the game
    - `compendium.html` Compendium of items, enemies, and maps
    - `forged-curse.js` cartdata
    - `index.html` Pico-8 Archipelago client / web player
- `forgedcurse/`
    - `__init__.py` Archipelago integration
- `Forged Curse.yaml` Default Forged Curse .yaml template 
- `forgedcurse.apworld` .apworld file for game generation
- `forgedcurserando.p8` Pico-8 file of Archipelago integrated version of the game
