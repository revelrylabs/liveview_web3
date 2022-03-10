// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
const colors = require('@tailwindcss/colors')

module.exports = {
    content: [
        './js/**/*.js',
        '../lib/*_web.ex',
        '../lib/*_web/**/*.*ex',
        "../deps/petal_components/**/*.*ex"
    ],
    theme: {
        extend: {
            colors: {
                primary: colors.blue,
                secondary: colors.pink,
                "cerise": {
                    50: "#ffdaf4",
                    100: "#ffb4e8",
                    200: "#ff8bd8",
                    300: "#f761c5",
                    400: "#e43ca5",
                    500: "#c82475",
                    600: "#a7144b",
                    700: "#830a2b",
                    800: "#5f0415",
                    900: "#3d0108",
                },
                "scarlet": {
                    50: "#ffddd7",
                    100: "#ffbbaf",
                    200: "#ff9685",
                    300: "#ff6a56",
                    400: "#ec4533",
                    500: "#cc2d20",
                    600: "#a81b12",
                    700: "#830f0a",
                    800: "#5f0704",
                    900: "#3c0302",
                },
                "gold": {
                    50: "#f9e495",
                    100: "#e8c954",
                    200: "#d8ad3a",
                    300: "#c98f2c",
                    400: "#b87320",
                    500: "#a55716",
                    600: "#8e3e0e",
                    700: "#752708",
                    800: "#581404",
                    900: "#380801",
                },
                "chartreuse": {
                    50: "#98fe44",
                    100: "#74e52e",
                    200: "#55cb1f",
                    300: "#3db114",
                    400: "#2a970d",
                    500: "#1b7d08",
                    600: "#116504",
                    700: "#094d02",
                    800: "#043601",
                    900: "#012000",
                },
                "sea_green": {
                    50: "#72ffac",
                    100: "#31e96c",
                    200: "#20ce4e",
                    300: "#15b237",
                    400: "#0d9826",
                    500: "#087e18",
                    600: "#05650f",
                    700: "#024d08",
                    800: "#013604",
                    900: "#002101",
                },
                "arctic_blue": {
                    50: "#acf0f7",
                    100: "#68dce6",
                    200: "#40c2d4",
                    300: "#32a6c8",
                    400: "#268bbb",
                    500: "#1c70ac",
                    600: "#14569a",
                    700: "#0c3d86",
                    800: "#07266d",
                    900: "#03124e",
                },
                "sapphire_blue": {
                    50: "#d9e5ff",
                    100: "#b4cbff",
                    200: "#90b1ff",
                    300: "#6d96ff",
                    400: "#4b79ff",
                    500: "#345eee",
                    600: "#2344d3",
                    700: "#152cb2",
                    800: "#0b188a",
                    900: "#040a5c",
                },
                "purple": {
                    50: "#f3ddff",
                    100: "#e6bbff",
                    200: "#d799ff",
                    300: "#c776ff",
                    400: "#b251fd",
                    500: "#9237ea",
                    600: "#6d25d1",
                    700: "#4916b2",
                    800: "#290a8b",
                    900: "#11045e",
                },
            }
        },
    },
    plugins: [
        require('@tailwindcss/forms')
    ]
}
