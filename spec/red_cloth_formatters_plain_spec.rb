# encoding: UTF-8
require "spec_helper"

describe "RedCloth::Formatters::Plain" do

  it "simple test" do
    RedCloth.new("p. this is *simple* _test_").to_plain.should == "this is simple test"
  end

  describe "Writing Paragraph Text" do
    describe "Simple paragraphs" do
      it "implicit" do
        input = "This is a paragraph.\n\nThis is another paragraph"
        output = "This is a paragraph.\nThis is another paragraph"
        RedCloth.new(input).to_plain.should == output
      end
      it "explicit" do
        input = "p. This is one paragraph.\n\np. This is another."
        output = "This is one paragraph.\nThis is another."
        RedCloth.new(input).to_plain.should == output
      end
    end
    describe "Line breaks" do
      it "implicit" do
        input = "Roses are red,\nViolets are blue,\nI'd like a sandwich;\nPerhaps even two."
        RedCloth.new(input).to_plain.should == input
      end
      it "in tags" do
        input = "<pre>\nMirror mirror\non the wall...\n</pre>"
        output = "\nMirror mirror\non the wall...\n"
        RedCloth.new(input).to_plain.should == output
      end
    end
    describe "Curly quotes" do
      it "quotations" do
        input = "\"I said, 'hold the mayo' twice!\""
        RedCloth.new(input).to_plain.should == input
      end
      it "apostrophes" do
        input = "We went to Steven's mother's house for a party."
        RedCloth.new(input).to_plain.should == input
      end
    end
    describe "Dashes" do
      it "single and double hyphens" do
        input = "I could be happy--fantastically happy--on twenty-one thousand a year if I only had to work 9 am - 1 pm."
        output = "I could be happy-fantastically happy-on twenty-one thousand a year if I only had to work 9 am - 1 pm."
        RedCloth.new(input).to_plain.should == output
      end
      it "between words" do
        input = "June - July 1967"
        RedCloth.new(input).to_plain.should == input
      end
      it "em dashes" do
        input = "Please use the em dash closed--or open if you must -- but I prefer it closed."
        output = "Please use the em dash closed-or open if you must - but I prefer it closed."
        RedCloth.new(input).to_plain.should == output
      end
    end
    describe "Ellipses" do
      it "tree periods" do
        input = "He thought and thought ... and then thought some more."
        RedCloth.new(input).to_plain.should == input
      end
      it "in conjunction with spaces and other punctuation" do
        input = "Four score and seven years ago our fathers brought forth...a new nation...dedicated to the proposition that all men are created equal...."
        RedCloth.new(input).to_plain.should == input
      end
    end
    describe "Dimension sign" do
      it "lowercase letter x" do
        input = "4 x 4 = 16"
        RedCloth.new(input).to_plain.should == input
      end
      it "to represent feet and inches" do
        input = "My office measures 5' x 5'6\"."
        RedCloth.new(input).to_plain.should == input
      end
      it "spaces are optional" do
        input = "4x4=16"
        RedCloth.new(input).to_plain.should == input
      end
    end
    it "Registered, trademark, and copyright symbols" do
      input = "RegisteredTrademark(r), Trademark(tm), and Copyright (c) 2008"
      output = "RegisteredTrademark®, Trademark™, and Copyright © 2008"
      RedCloth.new(input).to_plain.should == output
    end
    it "Acronyms" do
      input = "The EPA(Environmental Protection Agency) is measuring GHG(greenhouse gas) emissions."
      RedCloth.new(input).to_plain.should == input
    end
    it "Uppercase" do
      input = "Many NASDAQ companies are ISO certified."
      RedCloth.new(input).to_plain.should == input
    end
  end
  describe "Page Layout" do
    it "Headings" do
      input = "h1. This is a Heading 1\n\nThis might be an introductory paragraph on the general topic.\n\nh2. Heading 2 gets more specific\n\nNow we're getting into the details."
      output = "This is a Heading 1\nThis might be an introductory paragraph on the general topic.\nHeading 2 gets more specific\nNow we're getting into the details."
      RedCloth.new(input).to_plain.should == output
    end
    describe "Block quotations" do
      it "long quotations" do
        input = "Even Mr. Sedaris, a noted luddite, has finally succumbed to doing his writing on a computer.  The Internet, however, remains an idiotic trifle:\n\n"
        input += "bq. I've never seen the Internet. I don't have email. I just enjoy lying on the couch and reading a magazine. When people say, \"You should visit my Web page,\" I'm always perplexed by it. Why? What do you do there?\n\n"
        input += "Haven't we all pondered that at one time or another?"
        output = "Even Mr. Sedaris, a noted luddite, has finally succumbed to doing his writing on a computer.  The Internet, however, remains an idiotic trifle:\n"
        output += "I've never seen the Internet. I don't have email. I just enjoy lying on the couch and reading a magazine. When people say, \"You should visit my Web page,\" I'm always perplexed by it. Why? What do you do there?\n"
        output += "Haven't we all pondered that at one time or another?"
        RedCloth.new(input).to_plain.should == output
      end
      it "citation URL immediately following the period" do
        input = "A standard Lorem Ipsum passage has been used since the 1500s:\n\n"
        input += "bq.:http://www.lipsum.com/ Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        output = "A standard Lorem Ipsum passage has been used since the 1500s:\n"
        output += "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        RedCloth.new(input).to_plain.should == output
      end
      it "more than one paragraph" do
        input = "bq.. This is one paragraph.\n\n"
        input += "Another paragraph, also part of the quote.\n\n"
        input += "p. A normal paragraph ends the quote."
        output = "This is one paragraph.\n"
        output += "Another paragraph, also part of the quote.\n"
        output += "A normal paragraph ends the quote."
        RedCloth.new(input).to_plain.should == output
      end
    end
    it "Bullet lists" do
      input = "Textile has several advantages over HTML:\n\n"
      input += "* It's easier on the eyes\n"
      input += "* You don't have to write all those HTML tags\n"
      input += "** By not writing the tags yourself, you're less likely to make coding mistakes\n"
      input += "** It requires fewer keystrokes\n"
      input += "*** You don't wear out the keys on your keyboard as fast\n"
      input += "*** You won't wear out your fingers as fast\n"
      input += "* You can write it much quicker"
      output = "Textile has several advantages over HTML:\n"
      output += "- It's easier on the eyes\n"
      output += "- You don't have to write all those HTML tags\n"
      output += "  - By not writing the tags yourself, you're less likely to make coding mistakes\n"
      output += "  - It requires fewer keystrokes\n"
      output += "    - You don't wear out the keys on your keyboard as fast\n"
      output += "    - You won't wear out your fingers as fast\n"
      output += "- You can write it much quicker"
      RedCloth.new(input).to_plain.should == output
    end
    it "Numbered lists" do
      input = "How to make a PB&J:\n\n"
      input += "# Gather bread, peanut butter, and jelly\n"
      input += "# Slice the bread if necessary\n"
      input += "# Assemble the sandwich\n"
      input += "## Spread peanut butter on one slice of bread\n"
      input += "## Put jelly on another slice\n"
      input += "## Put the two slices together\n"
      input += "# Enjoy"
      output = "How to make a PB&J:\n"
      output += "- Gather bread, peanut butter, and jelly\n"
      output += "- Slice the bread if necessary\n"
      output += "- Assemble the sandwich\n"
      output += "  - Spread peanut butter on one slice of bread\n"
      output += "  - Put jelly on another slice\n"
      output += "  - Put the two slices together\n"
      output += "- Enjoy"
      RedCloth.new(input).to_plain.should == output
    end
    it "Mixed nested lists" do
      input = "Three reasons to walk to work:\n\n"
      input += "# It saves fuel\n"
      input += "# It's good for your health\n"
      input += "** Walking burns calories\n"
      input += "** Time outside means lower stress\n"
      input += "# It's good for the environment"
      output = "Three reasons to walk to work:\n"
      output += "- It saves fuel\n"
      output += "- It's good for your health\n"
      output += "  - Walking burns calories\n"
      output += "  - Time outside means lower stress\n"
      output += "- It's good for the environment"
      RedCloth.new(input).to_plain.should == output
    end
    it "Definition lists" do
      input = "- coffee := Hot and black\n"
      input += "- tea := Also hot, but a little less black\n"
      input += "- milk :=\n"
      input += "Nourishing beverage for baby cows.\n\n"
      input += "Cold drink that goes great with cookies. =:"
      output = "coffee:\n  Hot and black\n"
      output += "tea:\n  Also hot, but a little less black\n"
      output += "milk:\n  Nourishing beverage for baby cows.\n"
      output += "Cold drink that goes great with cookies."
      RedCloth.new(input).to_plain.should == output
    end
    it "Footnotes" do
      input = "42.7% of all statistics are made up on the spot.[1]\n\n"
      input += "fn1. \"Dr. Katz\":http://en.wikiquote.org/wiki/Steven_Wright"
      output = "42.7% of all statistics are made up on the spot."
      RedCloth.new(input).to_plain.should == output
    end
    describe "Tables" do
      it "simple" do
        input = "|_. name|_. age|\n"
        input += "|Walter|5|\n"
        input += "|Florence|6|"
        RedCloth.new(input).to_plain.should == ""
      end
      it "cellspan" do
        input = "|{background:#ddd}. Cell with background|Normal|\n"
        input += "|\2. Cell spanning 2 columns|\n"
        input += "|/2. Cell spanning 2 rows|one|\n"
        input += "|two|\n"
        input += "|>. Right-aligned cell|<. Left-aligned cell|"
        RedCloth.new(input).to_plain.should == ""
      end
      it "with attributes" do
        input = "table(#prices).\n"
        input += "|Adults|$5|\n"
        input += "|Children|$2|"
        RedCloth.new(input).to_plain.should == ""
      end
    end
    it "Divisions" do
      input = "div. A simple div."
      output = "A simple div."
      RedCloth.new(input).to_plain.should == output
    end
  end
  describe "Phrase modifiers" do
    it "Strong importance" do
      input = "Don't *ever* pull this lever."
      output = "Don't ever pull this lever."
      RedCloth.new(input).to_plain.should == output
    end
    it "Stress emphasis" do
      input = "You didn't actually _believe_ her, did you?"
      output = "You didn't actually believe her, did you?"
      RedCloth.new(input).to_plain.should == output
    end
    it "Stylistic offset" do
      input = "Search results for **Textile**:\n\n"
      input += "h4. [\"**Textile** (markup language) - Wikipedia\":http://en.wikipedia.org/wiki/Textile_(markup_language)]\n\n"
      input += "**Textile** is a lightweight markup language originally developed by Dean Allen and billed as a \"humane Web text generator\".  **Textile** converts its marked-up text ..."
      output = "Search results for Textile:\n"
      output += "Textile (markup language) - Wikipedia <http://en.wikipedia.org/wiki/Textile_(markup_language)>\n"
      output += "Textile is a lightweight markup language originally developed by Dean Allen and billed as a \"humane Web text generator\".  Textile converts its marked-up text ..."
      RedCloth.new(input).to_plain.should == output
    end
    it "Alternate voice" do
      input = "I just got the weirdest feeling of __déjà vu__."
      output = "I just got the weirdest feeling of déjà vu."
      RedCloth.new(input).to_plain.should == output
    end
    it "Citation" do
      input = "My wife's favorite book is ??The Count of Monte Cristo?? by Dumas."
      output = "My wife's favorite book is The Count of Monte Cristo by Dumas."
      RedCloth.new(input).to_plain.should == output
    end
    describe "Insertions and deletions" do
      it "using minuses and pluses" do
        input = "The news networks declared -Al Gore- +George W. Bush+ the winner in Florida."
        output = "The news networks declared  George W. Bush the winner in Florida."
        RedCloth.new(input).to_plain.should == output
      end
      it "surrounded with square brackets" do
        input = "[-this was deleted-][+this was added+] to the paragraph"
        output = "this was added to the paragraph"
        RedCloth.new(input).to_plain.should == output
      end
    end
    describe "Superscript and subscript" do
      it "surrounded with caret and tilde characters" do
        input = "f(x, n) = log ~4~ x ^n^"
        output = "f(x, n) = log 4 x n"
        RedCloth.new(input).to_plain.should == output
      end
      it "using square brackets" do
        input = "f(x, n) = log[~4~]x[^n^]"
        output = "f(x, n) = log4xn"
        RedCloth.new(input).to_plain.should == output
      end
    end
    describe "Links" do
      it "followed by a colon" do
        input = "Learn more \"about the company\":/about and our \"board of directors\":../about#board."
        output = "Learn more about the company </about> and our board of directors <../about#board>."
        RedCloth.new(input).to_plain.should == output
      end
      it "with title" do
        input = "Visit our \"parent company (Example Corporation)\":http://example.com."
        output = "Visit our parent company <http://example.com>."
        RedCloth.new(input).to_plain.should == output
      end
      it "surrounded with square brackets" do
        input = "This is a link to a [\"Wikipedia article about Textile\":http://en.wikipedia.org/wiki/Textile_(markup_language)]."
        output = "This is a link to a Wikipedia article about Textile <http://en.wikipedia.org/wiki/Textile_(markup_language)>."
        RedCloth.new(input).to_plain.should == output
      end
      it "with alias" do
        input = "I'm really excited about \"RedCloth\":redcloth.  I love it so much, I think I'll name my first child \"RedCloth\":redcloth.\n\n"
        input += "[redcloth]http://redcloth.org"
        output = "I'm really excited about RedCloth <http://redcloth.org>.  I love it so much, I think I'll name my first child RedCloth <http://redcloth.org>."
        RedCloth.new(input).to_plain.should == output
      end
    end
    describe "Images" do
      it "with exclamation marks" do
        input = "!http://www.w3.org/Icons/valid-html401(This page is valid HTML)!"
        output = "This page is valid HTML"
        RedCloth.new(input).to_plain.should == output
      end
      it "linked" do
        input = "!http://www.w3.org/Icons/valid-html401!:http://validator.w3.org/check?uri=referer"
        output = ""
        RedCloth.new(input).to_plain.should == output
      end
    end
  end
  describe "Attributes" do
    describe "CSS classes and IDs" do
      it "class or id" do
        input = "p(my-class). This is a paragraph that has a class and this *(#special-phrase)emphasized phrase* has an id."
        output = "This is a paragraph that has a class and this emphasized phrase has an id."
        RedCloth.new(input).to_plain.should == output
      end
      it "id on paragraph" do
        input = "p(#my-paragraph). This is a paragraph that has an id."
        output = "This is a paragraph that has an id."
        RedCloth.new(input).to_plain.should == output
      end
      it "both class and id" do
        input = "div(myclass#myid). This div has both a CSS class and ID."
        output = "This div has both a CSS class and ID."
        RedCloth.new(input).to_plain.should == output
      end
    end
    it "CSS styles" do
      input = "p{color:blue;letter-spacing:.5em}. Spacey blue"
      output = "Spacey blue"
      RedCloth.new(input).to_plain.should == output
    end
    it "Language" do
      input = "p[fr]. Parlez-vous français ?"
      output = "Parlez-vous français ?"
      RedCloth.new(input).to_plain.should == output
    end
    it "Alignment" do
      input = "p<. align left\n\n"
      input += "p>. align right\n\n"
      input += "p=. centered\n\n"
      input += "p<>. justified justified justified justified justified justified justified justified justified"
      output = "align left\n"
      output += "align right\n"
      output += "centered\n"
      output += "justified justified justified justified justified justified justified justified justified"
      RedCloth.new(input).to_plain.should == output
    end
    it "Indentation" do
      input = "p(. Left pad 1em.\n\n"
      input += "p)). Right pad 2em.\n\n"
      input += "p(). Pad both left and right sides 1em."
      output = "Left pad 1em.\n"
      output += "Right pad 2em.\n"
      output += "Pad both left and right sides 1em."
      RedCloth.new(input).to_plain.should == output
    end
  end
  describe "HTML Integration and Escapement" do
    it "HTML spans" do
      input = "I can put in a %(myclass)span with a class% like this."
      output = "I can put in a span with a class like this."
      RedCloth.new(input).to_plain.should == output
    end
    it "Inline code" do
      input = "On the command line, you can just type @redcloth@."
      output = "On the command line, you can just type redcloth."
      RedCloth.new(input).to_plain.should == output
    end
    describe "Block code" do
      it "block of code" do
        input = "bc. # Output \"I love Ruby\"\n"
        input += "say = \"I love Ruby\"\n"
        input += "puts say"
        output = "# Output \"I love Ruby\"\n"
        output += "say = \"I love Ruby\"\n"
        output += "puts say"
        RedCloth.new(input).to_plain.should == output
      end
      it "including blank lines" do
        input = "bc.. # Output \"I love Ruby\"\n"
        input += "say = \"I love Ruby\"\n"
        input += "puts say\n\n"
        input += "# Output \"I *LOVE* RUBY\"\n"
        input += "say['love'] = \"*love*\"\n"
        input += "puts say.upcase\n\n"
        input += "p. And that is how you do it."
        output = "# Output \"I love Ruby\"\n"
        output += "say = \"I love Ruby\"\n"
        output += "puts say\n\n"
        output += "# Output \"I *LOVE* RUBY\"\n"
        output += "say['love'] = \"*love*\"\n"
        output += "puts say.upcase\n"
        output += "And that is how you do it."
        RedCloth.new(input).to_plain.should == output
      end
    end
    it "Inline HTML" do
      input = "I can use HTML directly in my <span class=\"youbetcha\">Textile</span>."
      output = "I can use HTML directly in my Textile."
      RedCloth.new(input).to_plain.should == output
    end
    it "Block HTML" do
      input = "<div id=\"shopping-cart\">\n"
      input += "<form action=\"form_action\" method=\"get\">\n"
      input += "h3. Your cart\n\n"
      input += "* Item one\n"
      input += "* Item two\n\n"
      input += "<p><input type=\"submit\" value=\"Check Out\" /></p>\n\n"
      input += "</form>\n"
      input += "</div>"
      output = "\n\n"
      output += "Your cart\n"
      output += "- Item one\n"
      output += "- Item two"
      output += "\n\n"
      RedCloth.new(input).to_plain.should == output
    end
    describe "No Textile" do
      it "notextile tag or double-equals" do
        input = "<notextile>\n"
        input += "Don't touch this!\n"
        input += "</notextile>\n\n"
        input += "Use ==*asterisks*== to say something *strongly*."
        output = "Don't touch this!\n"
        output += "Use *asterisks* to say something strongly."
        RedCloth.new(input).to_plain.should == output
      end
      it "as normal or extended block" do
        input = "notextile. This has *no* textile formatting, see?\n\n"
        input += "notextile.. And this notextile block\n\n"
        input += "Just keeps going and going.\n\n"
        input += "p. Until you end it with another block."
        output = "This has *no* textile formatting, see?\n\n"
        output += "And this notextile block\n\n"
        output += "Just keeps going and going."
        output += "Until you end it with another block."
        RedCloth.new(input).to_plain.should == output
      end
    end
    describe "Preformatted text" do
      it "pre block" do
        output = "     Text in a pre block\n"
        output += "is displayed in a fixed-width\n"
        output += "     font. It preserves\n"
        output += "  s p a c e s, line breaks\n"
        output += "     and ascii bunnies.\n"
        output += "           _     _   \n"
        output += "           \`\ /`/   \n"
        output += "            \ V /    \n"
        output += "            /. .\    \n"
        output += "           =\ T /=   \n"
        output += "            / ^ \    \n"
        output += "         {}/\\ //\   \n"
        output += "         __\ " " /__ \n"
        output += "        (____/^\____)"
        input = "pre. #{output}"
        RedCloth.new(input).to_plain.should == output
      end
      it "extended" do
        input = "pre.. All monospaced\n\n"
        input += "Even the blank lines\n\n"
        input += "p. But now a paragraph"
        output = "All monospaced\n"
        output += "Even the blank lines\n"
        output += "But now a paragraph"
        RedCloth.new(input).to_plain.should == output
      end
    end
  end

end
