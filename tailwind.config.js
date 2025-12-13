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
        // Text colors
        'text-white', 'text-black', 'text-gray-50', 'text-gray-100', 'text-gray-200', 'text-gray-300',
        'text-gray-400', 'text-gray-500', 'text-gray-600', 'text-gray-700', 'text-gray-800', 'text-gray-900',
        'text-red-500', 'text-red-600', 'text-red-700',
        'text-green-500', 'text-green-600', 'text-green-700',
        'text-blue-500', 'text-blue-600', 'text-blue-700',
        'text-yellow-500', 'text-yellow-600', 'text-yellow-700',
        'text-indigo-500', 'text-indigo-600', 'text-indigo-700',
        'text-purple-500', 'text-purple-600', 'text-purple-700',
        'text-pink-500', 'text-pink-600', 'text-pink-700',

        // Background colors
        'bg-white', 'bg-black', 'bg-gray-50', 'bg-gray-100', 'bg-gray-200', 'bg-gray-300',
        'bg-gray-400', 'bg-gray-500', 'bg-gray-600', 'bg-gray-700', 'bg-gray-800', 'bg-gray-900',
        'bg-red-500', 'bg-red-600', 'bg-red-700',
        'bg-green-500', 'bg-green-600', 'bg-green-700',
        'bg-blue-500', 'bg-blue-600', 'bg-blue-700',
        'bg-yellow-500', 'bg-yellow-600', 'bg-yellow-700',
        'bg-indigo-500', 'bg-indigo-600', 'bg-indigo-700',
        'bg-purple-500', 'bg-purple-600', 'bg-purple-700',
        'bg-pink-500', 'bg-pink-600', 'bg-pink-700',

        // Hover variants
        'hover:bg-red-500', 'hover:bg-green-500', 'hover:bg-blue-500',
        'hover:text-white', 'hover:text-black',

        // Border colors
        'border-red-500', 'border-green-500', 'border-blue-500',
        'border-gray-300', 'border-gray-500', 'border-gray-700',

        // Flex / spacing / sizing
        'flex', 'flex-row', 'flex-col', 'items-center', 'justify-center',
        'p-0','p-1','p-2','p-3','p-4','p-5','p-6','p-8','p-10',
        'm-0','m-1','m-2','m-3','m-4','m-5','m-6','m-8','m-10',
        'w-1/2','w-1/3','w-2/3','w-full','h-1/2','h-1/3','h-2/3','h-full',
        'rounded', 'rounded-md', 'rounded-lg', 'rounded-full',

        // Text alignment
        'text-left', 'text-center', 'text-right', 'text-justify',

        // Display / visibility
        'block', 'inline-block', 'hidden', 'visible',

        // Font weight / size
        'font-thin', 'font-light', 'font-normal', 'font-medium', 'font-semibold', 'font-bold', 'font-extrabold',
        'text-xs', 'text-sm', 'text-base', 'text-lg', 'text-xl', 'text-2xl', 'text-3xl', 'text-4xl', 'text-5xl',

        // Shadow / opacity
        'shadow', 'shadow-md', 'shadow-lg', 'opacity-0', 'opacity-25', 'opacity-50', 'opacity-75', 'opacity-100',
    ],
    theme: {
        extend: {},
    },
    plugins: [],
}
