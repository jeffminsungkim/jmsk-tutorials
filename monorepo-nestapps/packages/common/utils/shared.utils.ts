export const capitalize = (str: string): string =>
  str.charAt(0).toUpperCase() + str.substring(1);
export const getRandomNumber = (min, max) =>
  Math.floor(Math.random() * (max - min + 1) + min);
