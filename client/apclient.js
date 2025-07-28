   import {
        Client,
        ITEMS_HANDLING_FLAGS,
        SERVER_PACKET_TYPE,
        CLIENT_STATUS,
        CLIENT_PACKET_TYPE,
        CREATE_AS_HINT_MODE,
        COMMON_TAGS,
      } from "https://unpkg.com/archipelago.js@1.0.0/dist/archipelago.js";

      // Create a new Archipelago client
      const client = new Client();
      const form = document.querySelector("#connection-details")

      //pico-8 related declarations
      const gpio = getP8Gpio();
      const loc_flags = {
        "blink chest": 0,
        "eclipse knight sanctuary chest": 1,
        "kobold home chest": 2,
        "kobold cave north chest": 3,
        "temple north chest": 4,
        "unknown priest grave": 5,
        "shed chest": 6,
        "temple south chest": 7,
        "grappling hook chest": 8,
        "mushroom cave": 9,
        "nmr left chest": 10,
        "nmr right chest": 11,
        "kobold cave south chest": 12,
        "pig pen chest": 13,
        "riverside chest": 14,
        "pigcube hideaway chest": 15,
        "kikku chest": 16,
        "fortress lionsmane chest": 17,
        "fortress gnoglic chest": 18,
        "fortress amanita chest": 19,
        "fortress browncap chest": 20,
        "gold armor chest": 21,
        "slime island chest": 22,
        "wooden sword chest": 23,
        "spider storage chest": 24,
        " leather armor chest": 25,
        "fortress blocked chest": 26,
        "orange key chest": 27,
        "waxing moon mimic": 28,
        "gibbous cleric grave chest": 29,
        "red key chest": 30,
        "victory": 31,
        "waxing moon chest": 32,
        "fortress exit chest": 33,
        "anvil chest": 34,
        "secret ingredient mimic": 35,
        "pigcube hall chest": 36,
        "ghr north chest": 37,
        "pigcube closet chest": 38,
        "iron armor chest": 39,
        "iron sword chest": 40,
        "pot maze right chest": 41,
        "pot maze left chest": 42,
        "monty hall door chest": 43,
        "ghr center chest": 44,
        "lower riverbank chest": 45,
        "mini maze center": 46,
        "apogee mage grave chest": 47,
        "mini maze right": 48,
        "secret storage left chest": 49,
        "secret storage center chest": 50,
        "secret storage right chest": 51,
        "fortress closet chest": 52,
        "map check": 53,
        "forge check": 54,
      };

      const item_flags = {
        "heart gem": 0, // did not need a table [0,0]
        "white key": 1,
        "loot": 2,
        "hammer": 3,
        "blue key": 4,
        "skeleton key": 5,
        "green key": 6,
        "crossbow": 7,
        "grappling hook": 8,
        "blink rod": 9,
        "loot": 10,
        "loot": 11,
        "loot": 12,
        "loot": 13,
        "heart gem": 14,
        "loot": 15,
        "crowbar": 16,
        "loot": 17,
        "loot": 18,
        "loot": 19,
        "loot": 20,
        "gold armor": 21,
        "good sword": 22,
        "wooden sword": 23,
        "loot": 24,
        "leather armor": 25,
        "loot": 26,
        "orange key": 27,
        "loot": 28,
        "bellows": 29,
        "red key": 30,
        "victory": 31,
        "push rod": 32,
        "loot": 33,
        "anvil": 34,
        "cricket": 35,
        "loot": 36,
        "loot": 37,
        "health gem": 38,
        "iron armor": 39,
        "iron sword": 40,
        "bombs": 41,
        "loot": 42,
        "loot": 43,
        "loot": 44,
        "loot": 45,
        "loot": 46,
        "boat": 47,
        "loot": 48,
        "loot": 49,
        "heart gem": 50,
        "loot": 51,
        "heart gem": 52,
        "map": 54,
        "arrows": 55,
      };

      const base_id = 99117114115101;

      let checked_locations = [];
      let options = {}

      let thisPlayer = 0;
      let players = {};

      let DeathLink_Amnesty = 0;

      function message_pico8(message) {
        let index = 37;
        //let log = "";
        for (let i = 0; i < message.length; i++) {
          gpio[index] = message[i].charCodeAt(0);
          index++;
        }
      }

      // Set up event listeners
      client.addListener(SERVER_PACKET_TYPE.CONNECTED, (packet) => {
        console.log("Connected to server: ", packet);
        thisPlayer = packet.slot;
        for (let slot in packet.slot_info) {
          players[slot] = {
            "slot": parseInt(slot),
            "name": packet.slot_info[slot].name,
            "alias": "".concat(packet.players[slot-1].alias.split(" ").slice(0,-1)),
            "game": packet.slot_info[slot].game,
          }
        }
        // set up gpio options
        options = client.data.slotData;
        let optionsByte=1;
        if (options.DeathLink !== 0) {
          optionsByte += 2;
          client.send({ cmd: CLIENT_PACKET_TYPE.CONNECT_UPDATE, tags: COMMON_TAGS.DEATH_LINK });
          DeathLink_Amnesty = options.DeathLink_Amnesty;
        }
        if (options.MedalHunt) {
          optionsByte += 4;
        }
        if (options.ExtraCheckpoint) {
          optionsByte += 8;
        }
        if (options.ExtraChecks) {
          optionsByte += 16;
        }
        gpio[20] = optionsByte;

        client.send({ cmd: CLIENT_PACKET_TYPE.SYNC });
      });

      client.addListener(SERVER_PACKET_TYPE.ROOM_UPDATE, (packet) => {
        console.log("Room update: ", packet);
      });

      //add item handler for gpio layer
      client.addListener(SERVER_PACKET_TYPE.RECEIVED_ITEMS, (packet, message) => {
        console.log("Recieved items: ", packet);
        //if this is a sync packet reset all our item addresses without changing anything else
        if (packet.index === 0) {
          for (let i = 10; i < 20; i++) {
            gpio[i] = 0;
          }
        }
        //go through all our item addresses and if they are not set, check the recieved items for their ap id, and set the gpio flag if we recieved it
        //on the scale i expect pico-8 games to be, this will be good enough
        //console.log(`gpio: ${gpio}`)
        for (let i = 0; i < packet.items.length; i++) {
          let item = packet.items[i];
          if (item.item === base_id+9) {
            if (item.player === thisPlayer) {
              message_pico8("found loot");
            } else {
              if (players[item.player].alias === ""){
                message_pico8(`got loot from ${players[item.player].name} :(`.toLowerCase())
              } else {
                message_pico8(`got loot from ${players[item.player].alias} :(`.toLowerCase())
              }
            }
          }
          for (let flag in item_flags) {
            if (base_id + item_flags[flag][1] === item.item) {
              let byte = Math.floor(item_flags[flag] / 8) + 10; // + 10 starts at byte 10 | item_flags[flag][0]
              let item_bit = 2 ** (item_flags[flag] % 8); // item_flags[flag][0]
              if (gpio[byte] & item_bit) {//yes this is supposed to be bitwise and
                console.log(`${flag} has already been received`);
              } else {
                gpio[byte] |= item_bit;
                if (item.player === thisPlayer) {
                  message_pico8(`found ${flag}`.toLowerCase())
                } else {
                  if (players[item.player].alias === ""){
                    message_pico8(`got ${flag} from ${players[item.player].name}`.toLowerCase())
                  } else {
                    message_pico8(`got ${flag} from ${players[item.player].alias}`.toLowerCase())
                  }
                }
              }
            }
          }
        }
      });

      client.addListener(SERVER_PACKET_TYPE.BOUNCED, (packet) =>{
        console.log("Bounced ", packet);
        if (packet.tags === COMMON_TAGS.DEATH_LINK && options.DeathLink !== 0 && packet.data.source !== thisPlayer) {
          gpio[25] = gpio[25] | 1;
          DeathLink_Amnesty += 1;
          if (packet.data.source) {
            if (players[packet.data.source].alias === ""){
              message_pico8(`deathlinked by ${players[packet.data.source].name}`.toLowerCase());
            } else {
              message_pico8(`deathlinked by ${players[packet.data.source].alias}`.toLowerCase());
            }
          } else {
            message_pico8("deathlinked");
          }
        }
      });

      //add location info listener to give game sent item text
      client.addListener(SERVER_PACKET_TYPE.LOCATION_INFO, (packet, message) => {
        console.log("Location Info: ", packet);
        for (let i=0; i<packet.locations.length; i++){
          let location = packet.locations[i];
          if (location.player !== thisPlayer) {
            let itemName = client.items.name(players[location.player].game, location.item)
            if (players[location.player].alias === "") {
              message_pico8(`sent ${itemName} to ${players[location.player].name}`.toLowerCase());
            } else {
              message_pico8(`sent ${itemName} to ${players[location.player].alias}`.toLowerCase());
            }
          }
        }
      });

      // Connect to the Archipelago server
      form.addEventListener("submit", (event) => {
        event.preventDefault()
        const connectionInfo = {
          hostname: document.getElementById("hostname").value,
          port: Number(document.getElementById("port").value),
          password: document.getElementById("password").value,
          game: "Forged Curse",
          name: document.getElementById("slot-name").value,
          items_handling: ITEMS_HANDLING_FLAGS.REMOTE_ALL,
          version: {
            build: 0,
            major: 5,
            minor: 0,
          },
        };
        console.log(connectionInfo.hostname);
        console.log(connectionInfo.port);
        console.log(connectionInfo.name);

        const statusWrapper = document.querySelector(".status-wrapper");
        const connected = document.querySelector(".status-connected");
        const failed = document.querySelector(".status-failed");
        const connecting = document.querySelector(".status-connecting");

        statusWrapper.classList.remove("d-none");
        connected.classList.add("d-none");
        failed.classList.add("d-none");
        connecting.classList.remove("d-none");

        client
          .connect(connectionInfo)
          .then(() => {
            console.log("Connected to the server");
            connecting.classList.add("d-none");
            connected.classList.remove("d-none");
            // You are now connected and authenticated to the server. You can add more code here if need be.
            const toggle = document.querySelector('.toggle-login-form');
            const loginForm = document.querySelector('.login-form');
            toggle.addEventListener('click', () => {
              loginForm.classList.toggle('d-none', !loginForm.classList.contains('d-none'));
            });
            loginForm.classList.add('d-none');
            toggle.classList.remove('d-none');
          })
          .catch((error) => {
            console.error("Failed to connect:", error);
            connecting.classList.add("d-none");
            failed.classList.remove("d-none");
            // Handle the connection error.
          });
      });

      // TO DO: Get this working
      // add location handler for gpio layer
      // sending information to the pico8 will trigger this function sending all checks to ap again
      // if you always send information to the pico8 when the gpio updates, that can cause an infinite loop
      gpio.subscribe(function (newIndices) {
        if (options.DeathLink !== 0 && (gpio[25] & 2) !== 0) {
          console.log("Death");
          gpio[25] = gpio[25] - 2;
              DeathLink_Amnesty -= 1;
              if (DeathLink_Amnesty === 0){
            DeathLink_Amnesty = options.DeathLink_Amnesty;
            client.send({ cmd: CLIENT_PACKET_TYPE.BOUNCE, tags: COMMON_TAGS.DEATH_LINK, data: {"source": thisPlayer}});
            if (options.DeathLink_Amnesty > 1) {
              message_pico8("sent deathlink")
            }
              }
        }
        for (let loc in loc_flags) {
          if ((gpio[Math.floor(loc_flags[loc][0] / 8)] & 2 ** (loc_flags[loc] % 8)) !== 0) { // loc_flags[loc][0]
            if (loc === "victory") {
              client.updateStatus(CLIENT_STATUS.GOAL);
            } else {
              console.log(`Checking location id: ${base_id + loc_flags[loc]}`) // loc_flags[loc][1]
              client.locations.check(base_id + loc_flags[loc]); // loc_flags[loc][1]
              if (!checked_locations.includes(base_id + loc_flags[loc], 0)){ // loc_flags[loc][1]
                client.locations.scout(CREATE_AS_HINT_MODE.NO_HINT, base_id + loc_flags[loc]); // loc_flags[loc][1]
              }
              checked_locations.push(base_id + loc_flags[loc]); // loc_flags[loc][1]
            }
          }
        }
      });

      // TO DO: Get this working
      //** start chat from phar
      client.messages.on("message", onMessage);

      function onMessage(text, nodes) {
          // Plaintext to console, because why not?
          console.log(text);

          const chat = document.getElementById("chat");
          const messageElement = document.createElement("div");

          for (const node of nodes) {
              const nodeElement = document.createElement("span");
              nodeElement.innerText = node.text;

              switch (node.type) {
                  case "entrance":
                      nodeElement.style.color = "#6495ED";
                      break;

                  case "location":
                      nodeElement.style.color = "#00FF7F";
                      break;

                  case "color":
                      // not really correct, but technically the only color nodes the server returns is "green" or "red"
                      // so it's fine enough for an example.
                      nodeElement.style.color = node.color;
                      break;

                  case "player":
                      if (node.player.slot === client.players.self.slot) {
                          // It's us!
                          nodeElement.style.color = "#EE00EE";
                      } else {
                          // It's them!
                          nodeElement.style.color = "#FAFAD2";
                      }
                      break;

                  case "item": {
                      // doesn't account for prog+useful or other combinations, but this is just as an example
                      if (node.item.progression) {
                          nodeElement.style.color = "#AF99EF";
                      } else if (node.item.useful) {
                          nodeElement.style.color = "#6D8BE8";
                      } else if (node.item.trap) {
                          nodeElement.style.color = "#FA8072";
                      } else {
                          nodeElement.style.color = "#00EEEE";
                      }
                  }

                  // no special coloring needed
                  case "text":
                  default:
                      break;
              }

              messageElement.appendChild(nodeElement);
          }

          chat.appendChild(messageElement);
          messageElement.scrollIntoView(false);
      }
      // end chat from phar **/