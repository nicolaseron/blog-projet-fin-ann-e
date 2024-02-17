/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./components/**/*.{js,vue,ts}",
    "./layouts/**/*.vue",
    "./pages/**/*.vue",
    "./plugins/**/*.{js,ts}",
    "./app.vue",
    "./error.vue",
  ],
  theme: {
    extend: {
      colors: {
        blue100: "#04bbff",
        blue200: "#0594d0",
        blue300: "#007198",
        blue400: "#003c57",
        blue500: "#051c24",
      },
    },
  },
  plugins: [],
};
