# require "rubygems"
# require "browser"

# browser = Browser.new(:ua => "some string", :accept_language => "en-us")
# browser.name            # readable browser name
# browser.version         # major version number
# browser.full_version
# browser.safari?
# browser.opera?
# browser.chrome?
# browser.chrome_os?
# browser.mobile?
# browser.tablet?
# browser.console?
# browser.firefox?
# browser.ie?
# browser.ie6?            # this goes up to 11
# browser.modern?         # Webkit, Firefox 17+, IE 9+ and Opera 12+
# browser.platform        # return :mac, :windows, :linux or :other
# browser.mac?
# browser.windows?
# browser.windows_x64?
# browser.linux?
# browser.blackberry?
# browser.bot?
# browser.search_engine?
# browser.phantom_js?
# browser.quicktime?
# browser.core_media?
# browser.silk?
# browser.known?          # has the browser been successfully detected?
# browser.meta            # an array with several attributes
# browser.to_s            # the meta info joined by space
