# encoding: UTF-8
require "cgi"
require "RedCloth"

module RedCloth
  module Formatters
    module Plain

      class Sanitizer
        def self.strip_tags(text)
          # use Rails Sanitizer if available
          begin
            text = ActionController::Base.helpers.strip_tags(text)
          rescue
            # otherwise, use custom method inspired from:
            # RedCloth::Formatters::HTML.clean_html
            # not very secure, but it's ok as output is still
            # meant to be escaped if it needs to be shown
            text.gsub!( /<!\[CDATA\[/, '' )
            text.gsub!( /<(\/*)([A-Za-z]\w*)([^>]*?)(\s?\/?)>/ ){|m| block_given? ? yield(m) : ""}
          end
          CGI.unescapeHTML(text)
        end
      end

      include RedCloth::Formatters::Base

      [:h1, :h2, :h3, :h4, :h5, :h6, :p, :pre, :div].each do |m|
        define_method(m) do |opts|
          "#{opts[:text]}\n"
        end
      end

      [:strong, :code, :em, :i, :b, :ins, :sup, :sub, :span, :cite].each do |m|
        define_method(m) do |opts|
          opts[:block] = true
          "#{opts[:text]}"
        end
      end

      def hr(opts)
        "\n"
      end

      def acronym(opts)
        opts[:block] = true
        opts[:title] ? "#{opts[:text]}(#{opts[:title]})" : "#{opts[:text]}"
      end

      def caps(opts)
        "#{opts[:text]}"
      end

      # don't render deleted text
      def del(opts)
        ""
      end

      # simple list with dashes
      [:ol, :ul].each do |m|
        define_method("#{m}_open") do |opts|
          opts[:block] = true
          opts[:nest] > 1 ? "\n" : ""
        end
        define_method("#{m}_close") do |opts|
          ""
        end
      end
      def li_open(opts)
        @li_need_closing = true
        "#{"  " * (opts[:nest]-1)}- #{opts[:text]}"
      end
      def li_close(opts=nil)
        # avoid multiple line breaks when closing multiple list items
        output = @li_need_closing ? "\n" : ""
        @li_need_closing = false
        output
      end
      def dl_open(opts)
        opts[:block] = true
        ""
      end
      def dl_close(opts=nil)
        ""
      end
      def dt(opts)
        "#{opts[:text]}:\n"
      end
      def dd(opts)
        "  #{opts[:text]}\n"
      end

      # don't render tables
      [:td, :tr_open, :tr_close, :table_open, :table_close].each do |m|
        define_method(m) do |opts|
          ""
        end
      end

      # just add newlines before blockquotes
      [:bc_open, :bq_open].each do |m|
        define_method(m) do |opts|
          opts[:block] = true
          ""
        end
      end
      def bc_close(opts)
        "\n"
      end
      def bq_close(opts)
        ""
      end

      # render link name only
      def link(opts)
        "#{opts[:name]}"
      end

      # render image alternative text or title if not available
      def image(opts)
        "#{opts[:alt] || opts[:title]}"
      end

      # don't render footnotes
      [:footno, :fn].each do |m|
        define_method(m) do |opts|
          ""
        end
      end

      def snip(opts)
        opts[:text] + "\n"
      end

      # render unescaped quotes and special chars
      def quote1(opts)
        "'#{opts[:text]}'"
      end
      def quote2(opts)
        "\"#{opts[:text]}\""
      end
      def multi_paragraph_quote(opts)
        "\"#{opts[:text]}"
      end
      def ellipsis(opts)
        "#{opts[:text]}..."
      end
      {
        :emdash     => "-",
        :endash     => " - ",
        :arrow      => "->",
        :trademark  => "™",
        :registered => "®",
        :copyright  => "©",
        :amp        => "&",
        :gt         => ">",
        :lt         => "<",
        :br         => "\n",
        :quot       => "\"",
        :squot      => "'",
        :apos       => "'",
      }.each do |method, output|
        define_method(method) do |opts|
          output
        end
      end
      def dim(opts)
        opts[:text]
      end
      def entity(opts)
        unescape("&#{opts[:text]};")
      end

      # strip HTML tags
      def html(opts)
        strip_tags(opts[:text]) + "\n"
      end
      def html_block(opts)
        strip_tags(opts[:text])
      end
      def notextile(opts)
        if filter_html
          "#{opts[:text]}"
        else
          strip_tags(opts[:text])
        end
      end
      def inline_html(opts)
        if filter_html
          "#{opts[:text]}"
        else
          strip_tags(opts[:text])
        end
      end

      # unchanged
      def ignored_line(opts)
        opts[:text] + "\n"
      end

    private

      def strip_tags(text)
        Sanitizer.strip_tags(text)
      end

      def unescape(str)
        CGI.unescapeHTML(str.to_s)
      end

      # no escaping
      [:escape, :escape_pre, :escape_attribute].each do |m|
        define_method(m) do |text|
          text
        end
      end
      def after_transform(text)
        text.chomp!
      end
      def before_transform(text)
      end

    end
  end
  class TextileDoc
    def to_plain(*rules)
      apply_rules(rules)
      output = to(Formatters::Plain)
      output = Formatters::Plain::Sanitizer.strip_tags(output)
      output
    end
  end
end