class Serve
    def call(env)
        @env = env
        @path = @env["PATH_INFO"]
        @app = File.join(File.dirname(__FILE__), "..", "app")
        @view = File.join(@app, "view", @path + ".html.erb")
        @cont = File.join(@app, "control", @path + ".html.erb")
        require_relative if File.exist? @cont

        [200, {"Content-Type"=>"Text/html"}, ['yes']]
    end
end