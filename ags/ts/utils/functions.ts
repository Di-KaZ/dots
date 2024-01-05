export function clamp(text: string, length: number, ellipsis: string = '...') {
  if (text.length > 20) return `${text.slice(0, length)}${ellipsis}`;
  return text;
}
