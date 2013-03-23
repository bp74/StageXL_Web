using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.IO;

namespace SynonymeConverter
{
    class Program
    {
        static void Main(string[] args)
        {
            HashSet<String> synonymIDs = new HashSet<string>();

            Dictionary<string, string> prettifies = new Dictionary<string, string>();
            prettifies["javascript"] = "js";
            prettifies["dart"] = "dart";
            prettifies["java"] = "java";
            prettifies["csharp"] = "java";
            prettifies["as3"] = "js";

            Dictionary<string, string> languageNames = new Dictionary<string, string>();
            languageNames["javascript"] = "JavaScript";
            languageNames["dart"] = "Dart";
            languageNames["java"] = "Java";
            languageNames["csharp"] = "C#";
            languageNames["as3"] = "ActionScript";

            string path = @".\\data";
            string language1 = "as3";
            string language2 = "dart";

            string htmlFile = string.Format("{0}\\synonyms.html", path, language1);

            //----------------------------------------------------------------------------------------

            Directory.CreateDirectory(Path.GetDirectoryName(htmlFile));
            File.Delete(htmlFile);

            //----------------------------------------------------------------------------------------

            XDocument doc = XDocument.Load(path + "\\synonyms.xml");

            foreach (var theme in doc.Root.Elements("theme"))
            {
                var themeId = theme.Attribute("id").Value;
                var themeTitle = theme.Element("title").Value;

                StringBuilder synonymHtml = new StringBuilder();

                List<string> themeSynonyms = new List<string>();

                foreach (var synonym in theme.Elements("synonym"))
                {
                    var synonymID = (synonym.Attribute("id") != null) ? synonym.Attribute("id").Value : null;
                    var synonymTitle = (synonym.Element("title") != null) ? synonym.Element("title").Value : null;

                    if (synonymID == null)
                        throw new Exception("missing synonymeID");

                    if (synonymIDs.Add(synonymID) == false)
                        throw new Exception("duplicate synonymeID");

                    synonymID = synonymID.Replace("syn-", "snippet-");

                    var code1 = synonym.Elements("code").Where((e) => e.Attribute("language").Value == language1).FirstOrDefault().Value;
                    var code2 = synonym.Elements("code").Where((e) => e.Attribute("language").Value == language2).FirstOrDefault().Value;

                    code1 = code1.Replace("\t", "  ");
                    code2 = code2.Replace("\t", "  ");

                    synonymHtml.AppendFormat("  <section class=\"section-synonym\">\n");
                    synonymHtml.AppendFormat("    <div class=\"row\">\n");
                    synonymHtml.AppendFormat("      <div class=\"span12\"><h3 class=\"section\">{0}</h3></div>\n", EscapeHtml(synonymTitle));
                    synonymHtml.AppendFormat("    </div>\n");
                    synonymHtml.AppendFormat("    <div class=\"row\">\n");
                    synonymHtml.AppendFormat("      <div class=\"span6\"><pre class=\"prettyprint lang-{0}\" style=\"border:1px solid #ccc; padding: 10px 10px 10px 10px;\">{1}</pre></div>\n", prettifies[language1], EscapeHtml(code1));
                    synonymHtml.AppendFormat("      <div class=\"span6\"><pre class=\"prettyprint lang-{0}\" style=\"border:1px solid #ccc; padding: 10px 10px 10px 10px;\">{1}</pre></div>\n", prettifies[language2], EscapeHtml(code2));
                    synonymHtml.AppendFormat("    </div>\n");
                    synonymHtml.AppendFormat("  </section>\n");
                }

                //-------------------------------------------------

                StringBuilder themeHtml = new StringBuilder();
                themeHtml.AppendFormat("<section class=\"section-theme\" id=\"{0}\">\n", themeId);
                themeHtml.AppendFormat("  <div class=\"row\"><div class=\"span12\"><h2>{0}</h2></div></div>\n", EscapeHtml(themeTitle));
                themeHtml.Append(synonymHtml.ToString());
                themeHtml.AppendFormat("</section>\n");

                File.AppendAllText(htmlFile, themeHtml.ToString());

            }
        }

        public static string EscapeHtml(string html)
        {
            return html
                .Replace("&", "&amp;")
                .Replace("<", "&lt;")
                .Replace(">", "&gt;")
                .Replace("\"", "&quot;")
                .Replace("'", "&apos;");
        }
    }
}
