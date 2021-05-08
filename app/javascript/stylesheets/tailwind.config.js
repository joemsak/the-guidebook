module.exports = {
  purge:  {
    content: [
      "./app/**/*.html.erb",
      "./app/helpers/**/*.rb",
      "./app/javascript/**/*.js",
      "./app/javascript/**/*.vue",
    ],
    safelist: ['btn'],
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {
      translate: ['active'],
    },
  },
  plugins: [],
}
