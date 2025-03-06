/* eslint-env node */
require("@rushstack/eslint-patch/modern-module-resolution");

module.exports = {
  root: true,
  extends: [
    "plugin:vue/vue3-recommended",
    "eslint:recommended",
    "@vue/eslint-config-prettier",
  ],
  rules: {
    "vue/no-unused-vars": "error",
  },
  env: {
    "cypress/globals": true,
  },
  overrides: [
    {
      files: [
        "**/__tests__/*.{cy,spec}.{js,ts,jsx,tsx}",
        "cypress/e2e/**/*.{cy,spec}.{js,ts,jsx,tsx}",
        "cypress/support/**/*.js",
        "cypress/**/*.js",
      ],
      extends: ["plugin:cypress/recommended"],
      env: {
        "cypress/globals": true,
      },
    },
  ],
  parserOptions: {
    ecmaVersion: "latest",
  },
};
