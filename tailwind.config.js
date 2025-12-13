/** @type {import('tailwindcss').Config} */
export default {
    content: [
        "./app/views/**/*.html.erb",
        "./app/helpers/**/*.rb",
        "./app/javascript/**/*.js",
        "./app/components/**/*.erb",
        "./app/assets/stylesheets/**/*.css"
    ],
    theme: {
        extend: {},
    },
    plugins: [],
}
