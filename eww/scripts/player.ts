import { $, $stream } from "./zx";

const PLAYER_IMG_TEMP = "/tmp/eww_player_preview.png";
const MASK_TEMP = "/tmp/eww_player_mask_preview.png";

function truncate(str: string, n: number) {
  return str.length > n ? str.slice(0, n - 1).trim() + "..." : str;
}

interface PlayerStatus {
  status: "Playing" | "Stopped" | "Paused";
  title: string;
  artist: string;
  art?: string;
}

async function get_player_status() {
  let { stdout } = $stream`
  playerctl --follow metadata --format   \
            '{                           \
                "status": "{{status}}",  \
                "title":" {{title}}",     \
                "artist": "{{artist}}",   \
                "art": "{{mpris:artUrl}}"\
            }'`;

  for await (let status of stdout as ReadableStream<Buffer>) {
    try {
      const player_status: PlayerStatus = JSON.parse(
        Buffer.from(status).toString()
      );
      player_status.title = truncate(player_status.title, 15);
      player_status.artist = truncate(player_status.artist, 15);
      console.error(player_status.art);

      if (player_status.art && player_status.art != "") {
        const filepath = player_status.art.replace("file://", "");

        const suqare_ratio = parseFloat(
          await $`convert ${filepath} -format "%[fx:w<h?w:h]" info:`
        );

        // Create a mask with increased rounding
        await $`convert -size ${suqare_ratio}x${suqare_ratio} \
        xc:none -fill white \
        -draw "roundRectangle 0,0 \
        ${suqare_ratio},${suqare_ratio} \
        ${suqare_ratio / 4},${suqare_ratio / 4}" \
        ${MASK_TEMP}`;

        // Apply the mask to the original image
        await $`convert ${filepath} -gravity center \
        -extent "${suqare_ratio}x${suqare_ratio}" ${MASK_TEMP} \
        -alpha Off -compose CopyOpacity -composite ${PLAYER_IMG_TEMP}`;

        player_status.art = PLAYER_IMG_TEMP;
      }
      console.log(JSON.stringify(player_status));
    } catch (e) {
      console.log(JSON.stringify({ status: "Stopped" }));
    }
  }
}

async function toggle() {
  const status = await $`playerctl play-pause`;
  console.log(status);
}

async function prev() {
  const status = await $`playerctl previous`;
  console.log(status);
}

async function next() {
  const status = await $`playerctl next`;
  console.log(status);
}

function help() {
  console.log(
    process.argv[1].substring(process.argv[1].lastIndexOf("/") + 1),
    "[status | toggle | next | prev]"
  );
}

type Parameter = "status" | "toggle" | "next" | "prev";
switch (process.argv[2] as Parameter) {
  case "status":
    await get_player_status();
    break;
  case "toggle":
    await toggle();
    break;
  case "next":
    await next();
    break;
  case "prev":
    await prev();
    break;
  default:
    help();
    break;
}
