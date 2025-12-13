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
        'rounded','rounded-sm','rounded-md','rounded-lg','rounded-xl','rounded-2xl','rounded-full',
        'shadow','shadow-sm','shadow-md','shadow-lg','shadow-xl',
        'text-left','text-center','text-right',
        'font-thin','font-light','font-normal','font-medium','font-semibold','font-bold',
        'w-full','h-full','w-auto','h-auto','container',

        // Design system specific classes
        // Typography
        'text-xs','text-sm','text-base','text-lg','text-xl','text-2xl','text-3xl','text-4xl','text-5xl','text-6xl',
        'text-muted-foreground','text-foreground','text-primary-foreground','text-secondary-foreground','text-destructive-foreground',

        // Backgrounds
        'bg-background','bg-card','bg-muted','bg-primary','bg-secondary','bg-input-background','bg-destructive',

        // Borders
        'border','border-2','border-border',

        // Spacing (design system scale)
        'gap-1','gap-2','gap-3','gap-4','gap-6','gap-8',
        'p-1','p-2','p-3','p-4','p-6','p-8',
        'm-1','m-2','m-3','m-4','m-6','m-8',
        'px-1','px-2','px-3','px-4','px-6','px-8',
        'py-1','py-2','py-3','py-4','py-6','py-8',

        // Gradients
        'bg-gradient-to-br','bg-gradient-to-r','bg-gradient-to-l','bg-gradient-to-t','bg-gradient-to-b',
        'from-[#ff9b9f]','to-[#fd79a8]',
        'from-[#a29bfe]','to-[#6c5ce7]',
        'from-[#ffeaa7]','to-[#fdcb6e]',

        // Transitions and hover effects
        'transition-all','duration-200','duration-300',
        'hover:shadow-xl','hover:scale-[1.02]',
        'focus:ring-2','focus:ring-primary',

        // Custom shadows
        'shadow-[0_4px_20px_rgba(255,155,159,0.08)]',
        'shadow-[0_4px_20px_rgba(162,155,254,0.08)]',

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
        { pattern: /^(?:from|via|to)-\[#[0-9a-fA-F]{6}\]$/ },
        { pattern: /^shadow-\[.*\]$/ },
        { pattern: /^(?:hover:|focus:|active:|disabled:|visited:|sm:|md:|lg:|xl:|2xl:).+/ }
    ],
    theme: {
        extend: {
            colors: {
                background: '#fef8f9',
                foreground: '#4a3b3e',
                card: '#ffffff',
                primary: {
                    DEFAULT: '#ff9b9f',
                    foreground: '#ffffff'
                },
                secondary: {
                    DEFAULT: '#e8d5f2',
                    foreground: '#4a3b3e'
                },
                accent: '#ffeaa7',
                heart: '#fd79a8',
                ribbon: '#a29bfe',
                muted: {
                    DEFAULT: '#f5f0f1',
                    foreground: '#8a7a7d'
                },
                border: 'rgba(255, 155, 159, 0.15)',
                'input-background': '#ffffff',
                destructive: {
                    DEFAULT: '#ef4444',
                    foreground: '#ffffff'
                }
            }
        }
    },
    plugins: [],
}
