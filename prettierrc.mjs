// prettier.config.js, .prettierrc.js, prettier.config.mjs, or .prettierrc.mjs

/** @type {import("prettier").Options} */
const config = {
  arrowParens: 'always',
  bracketSpacing: true,
  bracketSameLine: false,
  endOfLine: "lf",
  // // DEPRECATED in v2.4.0, use bracketSameLine instead.
  // jsxBracketSameLine: false,
  jsxSingleQuote: true,
  printWidth: 80,
  quoteProps: 'as-needed',
  semi: true,
  singleQuote: true,
  tabWidth: 2,
  trailingComma: 'all',
  useTabs: false,
};

export default config;
