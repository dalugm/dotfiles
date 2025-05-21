// eslint.config.js
import { defineConfig } from 'eslint/config'
// import eslintPrettierConfig from 'eslint-config-prettier/flat'
// import tailwind from 'eslint-plugin-tailwindcss'

export default defineConfig([
  // ...tailwind.configs['flat/recommended'],
  // eslintPrettierConfig,
  {
    rules: {
      semi: 'error',
    },
  },
])
