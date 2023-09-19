import { $, $stream } from "./zx";

const DEVICE = "Master";

enum ConnectionStatus {
    FULL = 4,
    OFFLINE = 1,
}

function get_icon(status: ConnectionStatus) {
    switch (status) {
        case ConnectionStatus.FULL:
            return "󰤨";
        case ConnectionStatus.OFFLINE:
            return "󰤩 ";
        default:
            return "󰤩 ";
    }
}
// amixer -D pulse events Master
let { stdout } = await $stream`amixer -D pulse sevents ${DEVICE}`;

for await (let _ of stdout as ReadableStream<Buffer>) {
    console.log("tst", _)
    console.log(
        "test"
    );
}
