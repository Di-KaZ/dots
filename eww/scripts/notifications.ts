import { $, $stream } from "./zx";
import { existsSync, openSync, closeSync, unlinkSync } from "fs";

const LOCK = 'notification_center.lock';
const PANEL = 'notification_panel'

async function toggle() {
    if (existsSync(LOCK)) {
        $`eww close ${PANEL}`;
        unlinkSync(LOCK);
    } else {
        const file = openSync(LOCK, 'w');
        closeSync(file);
        $`eww open ${PANEL}`;
    }
}

interface Notification {
    ['app-name']: {
        data: string;
    }
}

async function get_history() {
    const notifications: Notification[] = JSON.parse(await $`makoctl history`).data;
    notifications.forEach(n => {
        console.log(Object.keys(n))
    })
}

type Parameter = 'toggle' | 'history';

const param: Parameter = process.argv[2] as Parameter;


switch (param) {
    case 'toggle':
        await toggle();
        break;
    case 'history':
        await get_history();
    default:
        break;
}


