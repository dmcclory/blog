import lume from "lume/mod.ts";
import googleFonts from "lume/plugins/google_fonts.ts";

const site = lume();

site.add("/styles.css");

site.use(googleFonts({
  cssFile: "styles.css",
  fonts: "https://fonts.googleapis.com/css2?family=EB+Garamond:ital,wght@0,400..800;1,400..800&display=swap"
}));

export default site;
