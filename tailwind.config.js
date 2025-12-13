/** @type {import('tailwindcss').Config} */
export default {
    content: [
        "./app/views/**/*.html.erb",
        "./app/helpers/**/*.rb",
        "./app/javascript/**/*.js",
        "./app/components/**/*.erb",
        "./app/assets/stylesheets/**/*.css"
    ],
    safelist: [
        // Example: add all dynamic colors or classes here
        'bg-red-500',
        'bg-green-500',
        'bg-blue-500',
        'text-red-500',
        'text-green-500',
        'text-blue-500',
        'hover:bg-red-500',
        'hover:bg-green-500',
        'hover:bg-blue-500',
        'text-white',
        'text-black',
        // Add any other dynamic classes you use
    ],
    theme: {
        extend: {},
    },
    plugins: [],
}
