import { watch } from "fs";
import { $ } from "./zx";

async function get_brightness() {
  const current = await $`'brightnessctl -m`;
  console.log(parseInt(current.split(",")[3]));
  watch("/sys/class/backlight/intel_backlight/brightness").addListener(
    "change",
    async () => {
      const current = await $`'brightnessctl -m`;
      console.log(parseInt(current.split(",")[3]));
    }
  );
}

async function write_brightness(percent: number) {
  await $`brightnessctl set ${percent}`;
}

function help() {
  console.log(
    process.argv[1].substring(process.argv[1].lastIndexOf("/") + 1),
    "[status | write $percent]"
  );
}

type Parameter = "status" | "write";

switch (process.argv[2] as Parameter) {
  case "status":
    await get_brightness();
    break;
  case "write":
    await write_brightness(parseInt(process.argv[3]));
    break;
  default:
    help();
    break;
}
