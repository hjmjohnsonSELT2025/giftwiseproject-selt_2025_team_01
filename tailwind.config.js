// File: tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
    content: [
        "./app/views/**/*.html.erb",
        "./app/views/**/*.erb",
        "./app/views/**/*.html.*",
        "./app/components/**/*.{erb,rb,html.erb}",
        "./app/helpers/**/*.rb",
        "./app/javascript/**/*.{js,jsx,ts,tsx}",
        "./app/frontend/**/*.{js,jsx,ts,tsx}",
        "./app/assets/stylesheets/**/*.{css,scss}",
        "./lib/**/*.{rb,erb}",
        "./config/**/*.{rb,erb}"
    ],
    safelist: [
        // explicit commonly-used classes
        'flex','inline-flex','block','inline-block','hidden',
        'items-center','justify-center','justify-between','justify-start','justify-end',
        'rounded','rounded-sm','rounded-md','rounded-lg','rounded-full',
        'shadow','shadow-sm','shadow-md','shadow-lg','shadow-xl',
        'text-left','text-center','text-right',
        'font-thin','font-light','font-normal','font-medium','font-semibold','font-bold',
        // generic explicit fallbacks
        'w-full','h-full','w-auto','h-auto','container',

        // regex patterns to catch dynamic classes and variant-prefixed classes
        { pattern: /^(?:hover:|focus:|active:|disabled:|visited:|sm:|md:|lg:|xl:|2xl:)?(?:bg|text|border|ring)-(?:transparent|current|black|white|gray|red|orange|amber|yellow|lime|green|emerald|teal|cyan|sky|blue|indigo|violet|purple|fuchsia|pink|rose)(?:-(?:50|100|200|300|400|500|600|700|800|900))?$/ },
        { pattern: /^(?:hover:|focus:|active:|disabled:|sm:|md:|lg:|xl:|2xl:)?(?:from|via|to)-(?:transparent|black|white|gray|red|green|blue|yellow|indigo|purple|pink)(?:-(?:50|100|200|300|400|500|600|700|800|900))?$/ },
        { pattern: /^(?:p|px|py|pt|pb|pl|pr|m|mx|my|mt|mb|ml|mr)-(?:0|px|0\.5|1|1\.5|2|2\.5|3|3\.5|4|5|6|7|8|9|10|11|12|14|16|20|24|28|32|36|40|44|48|52|56|64)(?:$|\/)/ },
        { pattern: /^(?:w|h|min-w|min-h|max-w|max-h)-(?:full|screen|auto|fit|min|[0-9]+(?:px)?|[0-9]+\/[0-9]+|sm|md|lg|xl)$/ },
        { pattern: /^text-(?:xs|sm|base|lg|xl|2xl|3xl|4xl|5xl|6xl)$/ },
        { pattern: /^rounded(?:-(?:sm|md|lg|xl|2xl|full|none))?(?:-(?:t|b|l|r|tl|tr|bl|br))?$/ },
        { pattern: /^(?:gap|col-gap|row-gap|gap-x|gap-y)-(?:0|0\.5|1|1\.5|2|2\.5|3|3\.5|4|5|6|8|10|12|16)$/ },
        { pattern: /^(?:grid-cols|col-span|row-span|order)-(?:[0-9]+|auto)$/ },
        { pattern: /^(?:flex|inline-flex|grid|inline-grid|block|inline-block|hidden)$/ },
        { pattern: /^(?:shadow|opacity|border)-(?:none|sm|md|lg|xl|[0-9]+)$/ },
        { pattern: /^(?:translate|rotate|scale|skew)-(?:-?\d+|-\d+|0|\d+|\d+\/\d+)$/ },
        // broad catch-all for variant-prefixed dynamic classes
        { pattern: /^(?:hover:|focus:|active:|disabled:|visited:|sm:|md:|lg:|xl:|2xl:).+/ }
    ],
    theme: {
        extend: {},
    },
    plugins: [],
}
