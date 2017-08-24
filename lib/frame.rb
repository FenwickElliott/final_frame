require 'erubis'
require 'pry'

class Serve
    def call(env)
        @@repath = nil
        @@env = @env = env
        @path = @env["PATH_INFO"]
        @@app = @app = File.join(File.dirname(__FILE__), "..", "app")
        @view = File.join(@app, "view", @path + ".html.erb")
        @cont = File.join(@app, "control", @path + ".rb")
        @model = File.join(@app, "model", @path + ".rb")
        require @model if File.exist? @model
        load @cont if File.exist? @cont
        return [303, {'Location' => @@repath}, []] if @@repath
        @view = File.join(@app, "view", "404.html.erb") unless File.exist? @view

        render
    end

    def render
        res = [Erubis::Eruby.new(
        File.read(File.join(@app, "view", "template", "tem.html.erb")) +
        File.read(@view) +
        File.read(File.join(@app, "view", "template", "plate.html.erb"))
        ).result(binding)]
        [200, {"Content-Type"=>"text/html"}, res]
    end

    def self.redirect(path)
        @@repath = path
    end

    def self.db
        @@db ||= BlocRecord.new(File.join(@@app, "db", "data.db"))
    end

    def self.env
        @@env
    end
end