import { readableStreamToText, spawn } from "bun";
import stringArgv from "string-argv";

const exec = (c: string) => {
  return spawn(stringArgv(c));
};

const quote = (cmd: TemplateStringsArray, ...args: Array<string | number>) => {
  return cmd.reduce((acc, cur, i) => {
    return acc + cur + (args[i] || "");
  }, "");
};

const execWrapper = (
  cmd: TemplateStringsArray,
  ...args: Array<string | number>
) => {
  if (typeof cmd === "string") {
    return exec(cmd);
  } else {
    return exec(quote(cmd, ...args));
  }
};

export const $stream = (
  cmd: TemplateStringsArray,
  ...args: Array<string | number>
) => {
  return execWrapper(cmd, ...args);
};

export const $ = async (
  cmd: TemplateStringsArray,
  ...args: Array<string | number>
) => readableStreamToText(execWrapper(cmd, ...args).stdout);
