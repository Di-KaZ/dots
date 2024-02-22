// /home/getmoussed/.config/ags/ts/utils/functions.ts
function clamp(text, length, ellipsis = "...") {
  if (text.length > 20)
    return `${text.slice(0, length)}${ellipsis}`;
  return text;
}
export {
  clamp
};
